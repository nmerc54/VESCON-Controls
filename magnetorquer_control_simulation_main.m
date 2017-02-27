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
print_intro_to_term('Magnetorquer Control Simulation');

%% Parameters

mass = 10;              % kg

% SPACECRAFT Dimensions -- on SPACECRAFT Axis system
x_dimension = 0.100;    % m
y_dimension = 0.100;    % m
z_dimension = 0.681;    % m

% Inertia Tensor -- on SPACECRAFT Axis system
I_SC = inertiaTensor(mass, x_dimension, y_dimension, z_dimension);

% Orbit Period
orbitPeriod = 60*90;    % sec
dt = 0.1;               % sec
t = 0 : dt : orbitPeriod;


%% Display Results
disp(I_SC);