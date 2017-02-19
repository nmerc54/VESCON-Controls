function [ radius ] = radiusFromTrueAnomaly( semimajor, eccentricity, f )
% radiusFromTrueAnomaly 
% Nicholas A. Mercadante
% Last Modified: 2/12/2016
% ------------------------

% Can handle arrays

% f in radians

radius = (semimajor.*(1-eccentricity.^2))./(1+eccentricity.*cos(f));



%%%%%%%%%%%%%%%% Answer to 1c %%%%%%%%%%%%%%%%
% The periapse radius continuosuly increases as the
% eccentricity increases.

end

