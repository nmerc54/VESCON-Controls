%% Gravity plot
% N. Mercadante
%
% This is a filler for the B field.

clear all;
%% Parameters:

radius_earth = 6371; % km
mu_earth = 3.986e5; % km^3/s^2

max_alt = 10000;

% dh = 10; % km
% x = radius_earth : dh : max_alt;
% y = radius_earth : dh : max_alt;
% z = radius_earth : dh : max_alt;

%% Plotting
%mu = 3.986e5;
mu = 1;

x = 0:1:10;
y = 0:1:10;
z = 0:1:10;

[X, Y, Z] = meshgrid(x, y, z);

for i = 1:numel(x)
    for j = 1:numel(y)
        for k = 1:numel(z)
            
            z(i,j,k) = -mu*(x(i)^2 + y(j)^2 + z(k)^2);
            
        end
    end
end


[dx, dy, dz] = gradient(z);
quiver3(X, Y, Z, dx, dy, dz, 0);









