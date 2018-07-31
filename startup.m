%% * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
%  N.Mercadante
%  VESCON Controls
%
%  Startup
% * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
close all; clear; clc;

%% Create Paths:
HOME = pwd;

% CLASSES
addpath(genpath([HOME '/classes']))

% MAGNETICS
addpath(genpath([HOME '/magnetics']))

% SIM
addpath(genpath([HOME '/sim']))

% TOOLS
addpath(genpath([HOME '/tools']))

%% Create log path
LOGPATH = [HOME './log'];