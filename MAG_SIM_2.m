%% *********************************************************************** 
%  Magnetorquer Controls - 2 TEMP
%  Space Systems Research Laboaratory
%  --------------------------------
%  Nicholas Mercadante
%
%  Project: Rascal-1
%
%
% Name          | Date      | Description
% ------------------------------------------------------------------------
% N.Mercadante   03-29-2017  TEMP -- intended as a sandbox-type script.
%                            right now I have the logic 'trying' to calm
%                            the system down. Need to implement logic to
%                            damp, not just slew.
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

mass = 10;              % kg

% SPACECRAFT Dimensions -- on Body Axis system
x_dimension = 0.100;    % m
y_dimension = 0.100;    % m
z_dimension = 0.681;    % m

% Inertia Tensor -- on BODY Axis system
I_B = inertiaTensor(mass, x_dimension, y_dimension, z_dimension);
t_mag = 0.01; % N-m


% Orbit Period
orbitPeriod = 60*90;    % sec
dt = 0.01;             % sec
t = 0 : dt : orbitPeriod;

% Matrix initialization:

H_B = zeros(3, numel(t));     % Angular Momentum (body-coords)
w_B = zeros(3, numel(t));     % Body-Fixed rotation rates
T_B = zeros(3, numel(t));     % Torque (body-fixed)
B_I = zeros(3, numel(t));    
B_B = zeros(3, numel(t));

%Euler     = zeros(3, numel(t)); % Euler-Angles (inertial-fixed)
q_BtoI    = zeros(4, numel(t));
qdot_BtoI = zeros(4, numel(t));

% For debugging - euler axis and rotations
axis_angle = zeros(1, numel(t));
euler_axis = zeros(1, numel(t));

% Initial Values:
w_B(:, 1) = [0.01; 0.01; 0.01];    % rad/s
H_B(:, 1) = I_B * w_B(:,1); 

q_BtoI(:, 1) = normalize([0.25, -5.6, 1.23, -0.99]); % I to Body


h = waitbar(0,'Initializing waitbar...');
%% Simulation

% --------------------------------------------------------------
   q_D = 0.5.*[1; -1; -1; -1];       % Q DESIRED
   
   Ke  = ones(1, numel(t));         % |Ke| -> torque gain
   eA  = zeros(1, numel(t));         % |eA| -> error attitude
   eR  = zeros(1, numel(t));         % |eR| -> error rate

   % Calculate initial Errors and Gain
   Ke(1) = 1;                        % Keep constant for now
   eA(1) = getError(q_BtoI(:, 1), q_D);
   eR(1) = getError(w_B(:, 1) , [0;0;0]);
% --------------------------------------------------------------
tic
for i = 2:numel(t)
   
    % Parameters: ---------------------------------------------------------
    parameters = Parameters( ...
        q_BtoI(:, i-1), qdot_BtoI(:, i-1), q_D, H_B(:, i-1), I_B, t_mag, dt, ...
        Ke(i-1), eA(i-1), eR(i-1) ...
        );
    % ---------------------------------------------------------------------
    
    % Calculate Control Torque in body-frame
    T_B(:, i) = selectTorque(parameters);
    
    % Calculate the body rate changes
    H_B(:, i) = H_B(:, i-1) + T_B(:, i) .* dt;
    w_B(:, i) = I_B \ H_B(:, i);
    
    % Quaternion Math
    S = quatSkew(w_B(:, i));
    qdot_BtoI(:, i) = 0.5 .* S * q_BtoI(:, i-1);
    
    % Numerically Integrate and Normalize
    q_BtoI(:, i) = normalize(  q_BtoI(:, i-1) + qdot_BtoI(:, i)*dt  );
     
    % Calculate Errors:
    eA(i) = getError(q_BtoI(:, i), q_D);
    eR(i) = getError(w_B(:, i), [0;0;0]);
    
    %Euler(:, i) = quat2Euler(q_BtoI(:, i));
    
    
    
    % Display to screen: Adds 0.8% to the sim time. That's ~5 seconds on a
    %                    10 minute simulation.
    if mod(i, 1000) == 0
        waitbar( i/numel(t) , h,  'Percent Complete:'); 
    end
    
    % For debugging. Euler axis and rotations.
    axis_angle(i)    = 2*acos(q_BtoI(4, i));
    euler_axis(1, i) = q_BtoI(1, i)/sin(axis_angle(i)/2);
    euler_axis(2, i) = q_BtoI(2, i)/sin(axis_angle(i)/2);
    euler_axis(3, i) = q_BtoI(3, i)/sin(axis_angle(i)/2);
    
end
toc
%% Save workspace
    format shortg;
    c = clock;
    fix(c);

    year =  c(1);
    month = c(2);
    day =   c(3);
    hh =    c(4);
    mm =    c(5);

    filename = sprintf('rascalmagnetics_workspace_%d-%d-%d_%d-%d', month, day, year, hh, mm);

    save(filename);

%% Plot
% comment out if running on hopper or apex
plotting

