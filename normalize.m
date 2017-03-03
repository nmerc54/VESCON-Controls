%% *********************************************************************** 
%  Normalize vector
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

function norm_vector = normalize(vector)
    
    sum = 0;
    for i = 1:numel(vector)
        sum = sum + vector(i)^2;       
    end
    norm = sqrt(sum);
    
    norm_vector = vector./norm;
    
    
end