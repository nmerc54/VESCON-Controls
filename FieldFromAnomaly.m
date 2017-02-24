%% Magnetic Field from True Anomaly
%  Space Systems Research Laboaratory
%  --------------------------------
%  Nicholas Mercadante
%
%  Project: Rascal-1
%
%
% Name          | Date      | Description
% ------------------------------------------------------------------------
% C. Franz       02-24-2017  takes lat, long as input
% B. Fiedler                 elevation, azimuth in spherical coordinates == 
%                            lat, long r stays constant for circular orbit
%                            True anomaly adjusts both angles
% ------------------------------------------------------------------------
%
% COPYRIGHT 2017 Space Systems Research Laboratory, all rights reserved.
%
% ************************************************************************

%% Parameters
inclination = 55; %both in degrees for the moment
true_anomaly = 25; 
altitude = 375; %km
DateString = '24-Feb-2017'; %Edit with date
formatIn = 'dd-mmm-yyyy';
time = datenum(DateString,formatIn);


%% Calculations


%Calls orbit coordinates and converts to spherical
[x, y, z] = pos_circular_orbit3(altitude, inclination*pi/180, f);
[az, el, r] = cart2sph(x,y,z) %az = azimuth, el = elevation, r = radius 

%Calculates x,y,z components of field vector 
[Bx, By, Bz] = igrf(time, el, az, r, 'geocentric')
