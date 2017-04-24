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
orbitPeriod = 60*10;    % sec
dt = 0.01;              % sec --> Make sure that this works with coils_freq
t = 0 : dt : orbitPeriod;

% Spacecraft Body-Axis Parameters
mass = 10;              % kg
x_dimension = 0.200;    % m
y_dimension = 0.100;    % m
z_dimension = 0.300;    % m

% Inertia Tensor
I_B = zeros(3, 3, numel(t));
I_B(:, :, 1) = inertiaTensor(mass, x_dimension, y_dimension, z_dimension);

% Propulsion Characteristics
initial_prop_mass = 1;  % kg
mdot = 0.008;           % kg/s
prop_mass_used = zeros(1, numel(t));

% Torque Parameters
thruster_torque_magnitude = 10e-4; % N-m
torque_time               = 0.5;  % s
magcoils_torque_magnetude = 1e-4; % N-m
coils_freq                = 100;  % Hz

% Matrix initialization:
H_B = zeros(3, numel(t));     % Angular Momentum (body-coords)
w_B = zeros(3, numel(t));     % Body-Fixed rotation rates
T_B = zeros(3, numel(t));     % Torque (body-fixed)
B_I = zeros(3, numel(t));    
B_B = zeros(3, numel(t));
%Euler     = zeros(3, numel(t)); % Euler-Angles (inertial-fixed)
q_BtoI    = zeros(4, numel(t));
qdot_BtoI = zeros(4, numel(t));

% Initial Values:
w_B(:, 1) = [0.01; 0.01; 0.01];    % rad/s
H_B(:, 1) = I_B(:,:,1) * w_B(:,1); 
q_BtoI(:, 1) = normalize(0.5.*[1; -1; -1; -1]); % I to Body

%% Simulation
h = waitbar(0,'Initializing waitbar...');
% --------------------------------------------------------------
   q_D = 0.5.*[1; -1; -1; -1];       % Q DESIRED
   w_D = [0 ; 0 ; 0 ];               % w DESIRED
   
   eA  = zeros(1, numel(t));         % eA -> error attitude
   eR  = zeros(1, numel(t));         % eR -> error rate

   % Calculate initial Errors and Gain
   Ke(1) = 1;                        % Keep constant for now
   eA(1) = getError(q_BtoI(:, 1) , q_D);
   eR(1) = getError(w_B(:, 1)    , w_D);
   
   % Pulse Logic
   pulsing_bool = false;    % Is system in a torque-pulse?
   pulse = torque_time/dt;  % Number of iterations in a pulse
   %pulse = 10;
   pulse_ctr = 0;           % Keep track of pulse time
   
   torque_choice = zeros(3, numel(t));
% --------------------------------------------------------------
tic
for i = 2:numel(t)
 
    % PARAMETERS: ---------------------------------------------------------
    parameters = Parameters( ...
        q_BtoI(:, i-1), qdot_BtoI(:, i-1), q_D, H_B(:, i-1), I_B(:,:,i-1),       ...
        thruster_torque_magnitude, dt,  1  , eA(i-1), eR(i-1)           ...
        );
   
    
    % TORQUE SELECTION ----------------------------------------------------
    
    % System not in torque. Free to calculate torque to resolve motion
    if mod(i, pulse) == 0  
        
        % If the error is acceptible
        if (eA < 0.10) & (eR < 0.10)
            torque_choice(:, i) = [0; 0; 0]; 
            
        % If the error is not acceptible
        else
            torque_choice(:, i) = selectThrusterTorqe(parameters);   
        end
        
        T_B(:, i) = thruster_torque_magnitude.*torque_choice(:, i);
    
    
    % System in a torque pulse. Torque is same as previous iteration
    else 
 
        torque_choice(:, i) = torque_choice(:, i-1);
        T_B(:, i) = thruster_torque_magnitude.*torque_choice(:, i);
        
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

