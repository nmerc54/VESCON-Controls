%% 3-D plot of orbits
%  N. Mercadante



%% Parameters

radius_earth = 6371; % km

%inclination = 90 * deg_to_rad;  % radians
altitude = 375;    % km

% true anomaly
f = 0:0.001:2*pi;    

% Plotting:
% phi = (pi/2 - inclination)*ones(1, numel(f));
% phi = (pi/2 - inclination).*cos(f);
% theta = f;

inclination = [0 25 45 55 90];

figure()
hold all
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