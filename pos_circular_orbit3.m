%% Position in Circular Orbit 3D
%  N. Mercadante 
%  02-24-2017
%
%  pos_circular_orbit3( altitude (km)  ,  inclination (degrees) , true anomaly (rad) )
%
%
% ******************

function [x, y, z] = circular_orbit3(altitude, inclination, true_anomaly) %#ok<*INUSD>
    % Constants
    deg_to_rad = pi/180;
    i = deg_to_rad*inclination;
    
    radius_earth = 6371;
    
    radius = radius_earth + altitude;

    % true anomaly
    x = radius.*cos(true_anomaly).*cos(i);
    y = radius.*sin(true_anomaly);
    z = radius.*cos(true_anomaly).*sin(i);
    
end