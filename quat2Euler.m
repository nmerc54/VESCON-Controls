%% *********************************************************************** 
%  Quaternion to Euler Angles
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

function euler_angles = quat2Euler( quaternion_vector )

    q1 = quaternion_vector(1);
    q2 = quaternion_vector(2);
    q3 = quaternion_vector(3);
    q4 = quaternion_vector(4);


    euler_angles = [ ...
        
        atan2( 2*(q1*q4 + q2*q3) , 1 - 2*(q1^2 + q2^2) ) ;  % Roll  , Phi
        asin( 2*(q2*q4 - q1*q3) )  ;                        % Pitch , Theta
        atan2( 2*(q3*q4 + q1*q2) , 1 - 2*(q2^2 + q3^2) ) ]; % Yaw   , Psi



end