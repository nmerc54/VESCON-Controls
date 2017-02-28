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

d2r = pi/180;
r2d = 180/pi;
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
orbitPeriod = 60;    % sec
dt = 0.001;               % sec
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

T(1, :) = pulse(dt, 10, 1, 0.001, T(1, :));  % N-m
T(2, :) = pulse(dt, 11, 1, 0.001, T(2, :));  % N-m
T(3, :) = pulse(dt, 12, 1, 0.001, T(3, :));  % N-m

T(1, :) = pulse(dt, 30, 1, -0.001, T(1, :));  % N-m
T(2, :) = pulse(dt, 31, 1, -0.001, T(2, :));  % N-m
T(3, :) = pulse(dt, 32, 1, -0.001, T(3, :));  % N-m

% % Debug:
% plot(t./60, T), axis([0 60 -0.01, 0.01]);

%% Simulation
for i = 2:numel(t)
    
    H(:, i) = H(:, i-1) + T(:, i) .* dt;
    w(:, i) = I_B \ H(:, i);
    
    E_dot(:, i) = (1/sin(0.001 + (Euler(2, i-1)))) .* euler_transform(Euler(:,i-1)) * w(:, i);
    Euler(:, i) = Euler(:, i-1) + E_dot(:, i) .* dt;

end

%% Display Results
disp(I_SC);

figure('position',[screen_size(3)/4, screen_size(4)/4, 1000, 500])
    subplot(2, 1, 1)
        plot(t, w(1,:).*r2d, t, w(2,:).*r2d, t, w(3,:).*r2d), grid on,
        legend({'\omega_{x}', '\omega_{y}', '\omega_{z}'}),
        title('Body-Rates'), xlabel('Seconds'), ylabel('degrees/sec');
    subplot(2,1,2)
        plot(t, T(1,:), t, T(2,:), t, T(3,:)), grid on,
        legend({'x', 'y', 'z'}),
        title('Torques');
    
figure('position',[screen_size(3)/4, screen_size(4)/4, 1000, 500])
    subplot(2, 1, 1)    
        plot(t, Euler(1,:).*r2d, t, Euler(2,:).*r2d, t, Euler(3,:).*r2d), grid on,
        legend({'\Psi', '\Theta', '\Phi'}),
        title('Euler Angels'), xlabel('Seconds'), ylabel('degrees');    
    subplot(2,1,2)
        plot(t, E_dot(1,:).*r2d, t, E_dot(2,:).*r2d, t, E_dot(3,:).*r2d), grid on,
        legend({'\Psi - dot', '\Theta - dot', '\Phi - dot'}),
        title('Euler Rates'), xlabel('Seconds'), ylabel('degrees/sec');












