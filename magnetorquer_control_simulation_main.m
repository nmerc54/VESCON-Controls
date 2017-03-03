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
orbitPeriod = 60*90;    % sec
dt = 1;               % sec
t = 0 : dt : orbitPeriod;

% Matrix initialization:

H = zeros(3, numel(t));     % Angular Momentum (body-coords)
w = zeros(3, numel(t));     % Body-Fixed rotation rates
T = zeros(3, numel(t));     % Torque (body-fixed)
Euler = zeros(3, numel(t)); % Euler-Angles (inertial-fixed)
q    = zeros(4, numel(t));
qdot = zeros(4, numel(t));

% E_dot = zeros(3, numel(t)); % Euler-Rates (inertial-fixed)

% Initial Values:
w(:, 1) = [0; 0; 0];    % rad/s
H(:, 1) = I_B * w(:,1); 
q(:, 1) = [0; 0; 0; 1]; % In initial position.

%% Environmental Torques:
%  ----------------------

% Earth's magnetic field (IGRF Model)
% INERTIAL REF FRAME
c = 0.0005;
B(1, :) = 0.0005 * sin(c.*t);
B(2, :) = 0.0005 * cos(c.*t);
B(3, :) = 0.0005 * sin(c.*t).^2;

% Control torque
% BODY-FIXED FRAME
mu = zeros(3, numel(t));
mu(1, :) = 0.001;
T(:, 1) = magneticTorque(B(:, 1), mu(:, 1));

% T(1, :) = pulse(dt, 10, 1, 0.001, T(1, :));  % N-m
% T(2, :) = pulse(dt, 11, 1, 0.001, T(2, :));  % N-m
% T(3, :) = pulse(dt, 12, 1, 0.001, T(3, :));  % N-m

plot(t, B, t, mu(1,:));

%% Simulation
for i = 2:numel(t)
    
    H(:, i) = H(:, i-1) + T(:, i) .* dt;
    w(:, i) = I_B \ H(:, i);
    
    % Quaternion Math
    S = quatSkew(w(:, i));
    qdot(:, i) = 0.5 .* S * q(:, i-1);
    
    % Numerically Integrate and Normalize
    q(:, i) = normalize(  q(:, i-1) + qdot(:, i)*dt  );
        
    Euler(:, i) = quat2Euler(q(:, i));
    

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
        legend({'x', 'y', 'z'}), axis([0 orbitPeriod -0.01 0.01]),
        title('Torques');
    

figure('position',[screen_size(3)/4, screen_size(4)/4, 1000, 500])
    subplot(2,1,1)
        plot(t, Euler(1,:).*r2d, t, Euler(2,:).*r2d, t, Euler(3,:).*r2d), grid on,
        legend({'\Psi', '\Theta', '\Phi'}),
        title('Euler Angels'), xlabel('Seconds'), ylabel('degrees');    
    subplot(2,1,2)
        plot(t, T(1,:), t, T(2,:), t, T(3,:)), grid on,
        legend({'x', 'y', 'z'}), axis([0 orbitPeriod -0.01 0.01]),
        title('Torques');







