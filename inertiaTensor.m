%% ***********************************************************************
%  Calculate Inertia Tensor
%  Space Systems Research Laboaratory
%  --------------------------------
%  Nicholas Mercadante
%
%  Project: Rascal-1
%
%
% Name          | Date      | Description
% ------------------------------------------------------------------------
% N.Mercadante  11-10-2016   Calculates the inertia tensor in kg-m^2. 
%
% N.Mercadante  02-26-2017   Takes arguments of x, y, z in meters, and mass
%                            in kg. Taken from VESCON project.
%
% ------------------------------------------------------------------------
%
% COPYRIGHT 2017 Space Systems Research Laboratory, all rights reserved.
%
% ************************************************************************


function I = inertiaTensor(mass, x, y, z)
    
    I = [ (mass/12)*(y^2 + z^2)    0    0 ; ...
          0    (mass/12)*(z^2 + x^2)    0 ; ...
          0    0    (mass/12)*(x^2 + y^2) ];        % kg-m^2

end
    