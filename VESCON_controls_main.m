%% *********************************************************************** 
%  VESCON ADC Controls
%  Space Systems Research Laboaratory
%  --------------------------------
%  Nicholas Mercadante
%
%  Project: VESCON
%
%
% Name          | Date      | Description
% ------------------------------------------------------------------------
% N.Mercadante   04-08-2017  Adapted from Rascal-1 controls. Intended as
%                            the improved versions of the Fall 2016 VESCON
%                            Damping and Slewing simulations. This sim will
%                            encompass both thrusters and magnetorqers.
% 
% N.Mercadante  04-09-2017   Added in magnetic torque. There has been an
%                            issue with eA settling at 2 (???) - now I need
%                            to address so that the logic can switch to
%                            megnetorquers.
% ------------------------------------------------------------------------
%
% COPYRIGHT 2017 Space Systems Research Laboratory, all rights reserved.
%
% ************************************************************************

clear; clc; close all;
set(0,'units','pixels');
screen_size = get(0,'screensize');

print_intro_to_term('Magnetorquer Control Simulation');

d2r = pi/180;
r2d = 180/pi;

%% Parameters

% Orbit Period
orbitPeriod = 60*2;    % sec
dt = 0.01;              % sec --> Make sure that this works with coils_freq
t = 0 : dt : orbitPeriod;

% Spacecraft Body-Axis Parameters
mass = 10;              % kg
x_dimension = 0.200;    % m
y_dimension = 0.200;    % m
z_dimension = 0.100;    % m

% Inertia Tensor
I_B = zeros(3, 3, numel(t));
I_B(:, :, 1) = inertiaTensor(mass, x_dimension, y_dimension, z_dimension);

% Propulsion Characteristics
initial_prop_mass = 1;  % kg
mdot = 0.008;           % kg/s
prop_mass_used = zeros(1, numel(t));

% Torque Parameters
thruster_torque_magnitude = 8e-3; % N-m
torque_time               = 0.8;  % s
magcoils_torque_magnetude = 1e-4; % N-m
coils_freq                = 100;  % Hz

% Matrix initialization:
H_B = zeros(3, numel(t));     % Angular Momentum (body-coords)
w_B = zeros(3, numel(t));     % Body-Fixed rotation rates
T_B = zeros(3, numel(t));     % Torque (body-fixed)
B_I = zeros(3, numel(t));    
B_B = zeros(3, numel(t));
Euler     = zeros(3, numel(t)); % Euler-Angles (inertial-fixed)
q_BtoI    = zeros(4, numel(t));
qdot_BtoI = zeros(4, numel(t));

% Initial Values:
w_B(:, 1) = [0.1; 0.1; 0.45];    % rad/s
H_B(:, 1) = I_B(:,:,1) * w_B(:,1); 
q_BtoI(:, 1) = normalize([0.26; 0.58; -0.2; -0.61]); % I to Body

%% Simulation
h = waitbar(0,'Initializing waitbar...');
% --------------------------------------------------------------
   q_D = normalize([0.26; 0.58; -0.2; -0.61]);       % Q DESIRED
   w_D = [0 ; 0 ; 0 ];               % w DESIRED
   
   eA  = zeros(1, numel(t));         % eA -> error attitude
   eR  = zeros(1, numel(t));         % eR -> error rate
   Ke  = ones(1, numel(t));          % Ke -> torque scaling factor
   
   attitude_tolerance = 0.10;        % Tolerance

   % Calculate initial Errors and Gain
   Ke(1) = 1;                        % Keep constant for now
   eA(1) = getError(q_BtoI(:, 1) , q_D);
   eR(1) = getError(w_B(:, 1)    , w_D);
   
   % Pulse Logic
   pulsing_bool = false;    % Is system in a torque-pulse?
   pulse = torque_time/dt;  % Number of iterations in a pulse
   pulse_ctr = 0;           % Keep track of pulse time
   
   torque_choice = zeros(3, numel(t));
   
   mag_bool = 100*ones(1, numel(t));
   mag_bool(1) = 0;
   
% --------------------------------------------------------------
tic
for i = 2:numel(t)
    
    % Use magnetorquers -- should implement Hz in here somehow...
    if ((eA(i-1) <= 0.10) || (eA(i-1) >= 2-0.10)) && (eR(i-1) <= 0.10)
    %if 1 == 2
        mag_bool(i) = 1;
        % PARAMETERS: -----------------------------------------------------
        parameters = Parameters( ...
         q_BtoI(:, i-1), qdot_BtoI(:, i-1), q_D, H_B(:, i-1), I_B(:,:,i-1), ...
         magcoils_torque_magnetude, dt,  1  , eA(i-1), eR(i-1)              ...
         );   
 
        % TORQUE SELECTION ------------------------------------------------
        % Check for eA and eR
        if (eA(i-1) <= 0.05) && (eR(i-1) <= 0.10)
            torque_choice(:, i) = [0;0;0];
        else
            torque_choice(:, i) = selectCoilTorque(parameters);
        end
        
        T_B(:, i) = magcoils_torque_magnetude.*torque_choice(:, i);
        
    % Use Thrusters
    else
        mag_bool(i) = 0;
        % PARAMETERS: -----------------------------------------------------
        parameters = Parameters( ...
         q_BtoI(:, i-1), qdot_BtoI(:, i-1), q_D, H_B(:, i-1), I_B(:,:,i-1), ...
         thruster_torque_magnitude, torque_time,  Ke(i-1)  , eA(i-1), eR(i-1)              ...
         );


        % TORQUE SELECTION ------------------------------------------------
        if mod(i, pulse) == 0  % System not in torque. Free to calculate torque to resolve motion

            % Check for eA and eR
            if ((eA(i-1) <= 0.10) || (eA(i-1) >= 2-0.10)) && (eR(i-1) <= 0.10)
                torque_choice(:, i) = [0;0;0];
            else
                torque_choice(:, i) = selectThrusterTorque(parameters);
            end
            T_B(:, i) = Ke(i-1).*thruster_torque_magnitude.*torque_choice(:, i);

        else % System in a torque pulse. Torque is same as previous iteration

            torque_choice(:, i) = torque_choice(:, i-1);
            T_B(:, i) = thruster_torque_magnitude.*torque_choice(:, i);

        end                
    end
        
    
    % DYNAMICS ------------------------------------------------------------
    
    % Calculate the body rate changes
    H_B(:, i) = H_B(:, i-1) + T_B(:, i) .* dt;
    w_B(:, i) = I_B(:,:,i-1) \ H_B(:, i);

    % Quaternion Math
    S = quatSkew(w_B(:, i));
    qdot_BtoI(:, i) = 0.5 .* S * q_BtoI(:, i-1);

    % Numerically Integrate and Normalize
    q_BtoI(:, i) = normalize(  q_BtoI(:, i-1) + qdot_BtoI(:, i)*dt  );

    % Calculate Errors:
    eA(i) = getError( q_BtoI(:, i)   , q_D);
    eR(i) = getError( w_B(:, i)      , w_D);
    Ke(i) = 1;

    % **** CHANGE SELECT_TORQUE to output thruster_choice
    prop_mass_used(i) = iteratePropMass(prop_mass_used(i-1), mdot, dt, torque_choice(:, i));
    I_B(:, :, i) = inertiaTensor(mass - 0*prop_mass_used(i), ...
                                x_dimension, y_dimension, z_dimension);
           

    
    % Waitbar Status (every 1000 iterations) ------------------------------
    if mod(i, 1000) == 0
        waitbar( i/numel(t) , h,  'Percent Complete:'); 
    end
end
toc

for i = 1:numel(t)
    Euler(:,i) = quat2Euler(q_BtoI(:, i))*r2d;
end


clear('h');
%% Save workspace
%     format shortg;
%     c = clock;
%     fix(c);
% 
%     year =  c(1);
%     month = c(2);
%     day =   c(3);
%     hh =    c(4);
%     mm =    c(5);
% 
%     filename = sprintf('rascalmagnetics_workspace_%d-%d-%d_%d-%d', month, day, year, hh, mm);
% 
%     save(filename);

%% Plot
% comment out if running on hopper or apex
plotting

