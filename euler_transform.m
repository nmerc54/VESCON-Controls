%% *********************************************************************** 
%  Euler Cosine Transform
%  Space Systems Research Laboaratory
%  --------------------------------
%  Nicholas Mercadante
%
%  Project: Rascal-1
%
%
% Name          | Date      | Description
% ------------------------------------------------------------------------
% N.Mercadante   02-26-2017  This script will generate a matrix for the
%                            Euler kinematic angles.
% ------------------------------------------------------------------------
%
% COPYRIGHT 2017 Space Systems Research Laboratory, all rights reserved.
%
% ************************************************************************

function C = euler_transform(Euler_angles)

    %psi     = Euler_angles(1);
    theta   = Euler_angles(2);
    phi     = Euler_angles(3);
    
    C = [ sin(phi)            , cos(phi)            , 0          ; ...
          cos(phi)*sin(theta) , -sin(phi)*sin(theta), 0          ; ...
          -sin(phi)*cos(theta), -cos(phi)*cos(theta) , sin(theta)];

end