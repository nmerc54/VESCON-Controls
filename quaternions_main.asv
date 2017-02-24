%% ***********************************************************************
%  Quaternion Rotations
%  Space Systems Research Laboaratory
%  --------------------------------
%  Nicholas Mercadante
%
%  Project: Rascal-1
%
%
% Name          | Date      | Description
% ------------------------------------------------------------------------
% N.Mercadante   02-24-2017  This script is used to test rotational
%                            kinematics with quaternions.
% ------------------------------------------------------------------------
%
% COPYRIGHT 2017 Space Systems Research Laboratory, all rights reserved.
%
% ************************************************************************

clear all;

%% Parameters
% built-in matlab quaternions;

theta = 1*pi/4;
e1 = 1;
e2 = 2;
e3 = 3;

q1 = e1*sin(theta/2);
q2 = e2*sin(theta/2);
q3 = e3*sin(theta/2);
q4 = cos(theta/2);

q = [q1, q2, q3, q4];
r = [1 1 1];

n = quatrotate(q, r);
