%% *********************************************************************** 
%  Quaternion Skew Matrix
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
%                            quaternion skew from the body rates.
% ------------------------------------------------------------------------
%
% COPYRIGHT 2017 Space Systems Research Laboratory, all rights reserved.
%
% ************************************************************************

function S = quatSkew(w)
    
    w1 = w(1); w2 = w(2); w3 = w(3);

    S = [ 0  , w3, -w2, w1 ; ...
         -w3, 0  ,  w1, w2 ; ...
         w2 , -w1, 0  , w3 ; ...
         -w1, -w2, -w3, 0  ];
    

end