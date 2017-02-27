%% *********************************************************************** 
%  Magnetorquer Control Model
%  Space Systems Research Laboaratory
%  --------------------------------
%  Nicholas Mercadante
%
%  Project: Rascal-1
%
%
% Name          | Date      | Description
% ------------------------------------------------------------------------
% N.Mercadante   02-26-2017  This script will develop the control
%                            simulation for the Rascal-1 magnetorquer
%                            payload.
% ------------------------------------------------------------------------
%
% COPYRIGHT 2017 Space Systems Research Laboratory, all rights reserved.
%
% ************************************************************************

clear; clc; clear all;
set(0,'units','pixels');
screen_size = get(0,'screensize');

print_intro_to_term('Magnetorquer Control Simulation');

%% Parameters

mass = 10;              % kg

% SPACECRAFT Dimensions -- on SPACECRAFT Axis system
x_dimension = 0.100;    % m
y_dimension = 0.100;    % m
z_dimension = 0.681;    % m

% Inertia Tensor -- on SPACECRAFT Axis system
I_SC = inertiaTensor(mass, x_dimension, y_dimension, z_dimension);

% CHANGE!!!!!!!!!!
I_B = I_SC;

% Orbit Period
orbitPeriod = 60*90;    % sec
dt = 0.1;               % sec
t = 0 : dt : orbitPeriod;

% Matrix initialization:

H = zeros(3, numel(t));     % Angular Momentum (body-coords)
w = zeros(3, numel(t));     % Body-Fixed rotation rates
T = zeros(3, numel(t));     % Torque (body-fixed)
Euler = zeros(3, numel(t)); % Euler-Angles (inertial-fixed)
E_dot = zeros(3, numel(t)); % Euler-Rates (inertial-fixed)

% Initial Values:
w(:, 1) = [0; 0; 0];    % rad/s
H(:, 1) = I_B * w(:,1); 

T(1, 25000:30000) = 0.01;       % N-m
T(2, 30000:35000) = 0.01;       % N-m
T(3, 35000:40000) = 0.01;       % N-m

%% Simulation
for i = 2:numel(t)
    
    H(:, i) = H(:, i-1) + T(:, i) .* dt;
    w(:, i) = I_B \ H(:, i);
    
    E_dot(:, i) = (1/sin(0.001 + (Euler(2, i-1)))) .* euler_transform(Euler(:,i-1)) * w(:, i);
    Euler(:, i) = Euler(:, i) + E_dot(:, i) .* dt;

end

%% Display Results
disp(I_SC);

figure('position',[screen_size(3)/4, screen_size(4)/4, 1000, 500])
    plot(t, w(1,:), t, w(2,:), t, w(3,:)), grid on,
    legend({'\omega_{x}', '\omega_{y}', '\omega_{z}'}),
    title('Body-Rates');
    
figure('position',[screen_size(3)/4, screen_size(4)/4, 1000, 500])
    plot(t, Euler(1,:), t, Euler(2,:), t, Euler(3,:)), grid on,
    legend({'\Psi', '\Theta', '\Phi'}),
    title('Euler Angels');    

figure('position',[screen_size(3)/4, screen_size(4)/4, 1000, 500])
    plot(t, E_dot(1,:), t, E_dot(2,:), t, E_dot(3,:)), grid on,
    legend({'\Psi_dor', '\Theta_dot', '\Phi_dot'}),
    title('Euler Rates');

figure('position',[screen_size(3)/4, screen_size(4)/4, 1000, 500])
    plot(t, T(1,:), t, T(2,:), t, T(3,:)), grid on,
    legend({'x', 'y', 'z'}),
    title('Torques');












