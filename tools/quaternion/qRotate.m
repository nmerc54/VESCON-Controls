%% *********************************************************************** 
%  Column quaternion rotate
%  Space Systems Research Laboaratory
%  --------------------------------
%  Nicholas Mercadante
%
%  Project: Rascal-1
%
%
% Name          | Date      | Description
% ------------------------------------------------------------------------
% N.Mercadante   03-04-2017  Wrapper function for quatrotate.m to enable
%                            column vector inputs and output.
% ------------------------------------------------------------------------
%
% COPYRIGHT 2017 Space Systems Research Laboratory, all rights reserved.
%
% ************************************************************************


function p = qRotate(q, r)
    temp = quatrotate(q', r');
    p = temp';

end