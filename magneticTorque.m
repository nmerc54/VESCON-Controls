%% *********************************************************************** 
%  Magnetic Torque
%  Space Systems Research Laboaratory
%  --------------------------------
%  Nicholas Mercadante
%
%  Project: Rascal-1
%
%
% Name          | Date      | Description
% ------------------------------------------------------------------------
% N.Mercadante   03-02-2017  
% ------------------------------------------------------------------------
%
% COPYRIGHT 2017 Space Systems Research Laboratory, all rights reserved.
%
% ************************************************************************

function torque = magneticTorque(Earth_vector, local_vector)

    torque = cross(local_vector, Earth_vector);

end