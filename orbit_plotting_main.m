%% 3-D Orbit Plotting Script
%  Space Systems Research Laboaratory
%  --------------------------------
%  Nicholas Mercadante
%
%  Project: Rascal-1
%
%
% Name          | Date      | Description
% ------------------------------------------------------------------------
% N.Mercadante   02-20-2017  This script is used to develop a 3D model of
%                            various orbits around the earth.
% ------------------------------------------------------------------------
%
% COPYRIGHT 2017 Space Systems Research Laboratory, all rights reserved.
%
% ************************************************************************

plot_earth = false;

%% Parameters

radius_earth = 6371; % km
altitude = 375;      % km
% true anomaly
f = 0:0.001:2*pi;    % rad

inclination = [0 25 45 55 90];

%% Plotting
figure()
    hold all
    % Plot Earth:
    if plot_earth
        [x_earth, y_earth, z_earth] = sphere(50);
        surf(x_earth.*radius_earth, ... 
            y_earth.*radius_earth,  ...
            z_earth.*radius_earth),

        colormap([1 1 1]);
    end

    for i = 1:numel(inclination)
        [x, y, z] = circular_orbit3(altitude, inclination(i));

        % Plot:
        plot3(x, y, z),
        axis(7000*[-1 1 -1 1 -1 1]),
        xlabel('x'), ylabel('y'), zlabel('z'),
        title('Rascal-1 Orbit'),
        grid on;
    end
hold off