%% Vector Field Plotting Script
%  Space Systems Research Laboaratory
%  --------------------------------
%  Nicholas Mercadante
%
%  Project: Rascal-1
%
%
% Name          | Date      | Description
% ------------------------------------------------------------------------
% N.Mercadante   02-20-2017  This script is used to develop a vector field
%                            plot using the built-in MATLAB quiver
%                            function. This is a 3-D vector field.
% ------------------------------------------------------------------------
%
% COPYRIGHT 2017 Space Systems Research Laboratory, all rights reserved.
%
% ************************************************************************

clear;

debug = true;
debug_print(debug, 'Starting!');

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

debug_print(debug, 'Settng up x, y, and z');
x = -10:1:10;
y = -10:1:10;
z = -10:1:10;

debug_print(debug, 'finished creating x, y, and z. Starting meshgrid')
[X, Y, Z] = meshgrid(x, y, z);

debug_print(debug, 'Finished meshgrid. Starting for loop.')
for i = 1:numel(x)
    for j = 1:numel(y)
        for k = 1:numel(z)

            debug_print(debug, 'Im in iteration: i = ');
            T(i,j,k) = -mu*(x(i)^2 + y(j)^2 + z(k)^2);
            
%             u(i,j,k) = -mu*x(i);
%             v(i,j,k) = -mu*y(j);
%             w(i,j,k) = -mu*z(k);
                        
        end
    end
end

debug_print(debug, 'finished for loop. about to start gradient');
[dx, dy, dz] = gradient(T);
debug_print(debug, 'Im finished with the gradient');
quiver3(X, Y, Z, dx, dy, dz, 2);









