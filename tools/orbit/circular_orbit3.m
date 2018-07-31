%% Circular Orbit 3D
%  N. Mercadante 
%  02-18-2017
%
%  circular_orbit3( altitude (km)  ,  inclination (degrees)  )
%
%
% ******************

function [x, y, z] = circular_orbit3(altitude, inclination)
    % Constants
    deg_to_rad = pi/180;
    i = deg_to_rad*inclination;
    
    radius_earth = 6371;
    
    radius = radius_earth + altitude;

    % true anomaly
    f = 0:0.001:2*pi; 
    
    x = radius.*cos(f).*cos(i);
    y = radius.*sin(f);
    z = radius.*cos(f).*sin(i);
    
end