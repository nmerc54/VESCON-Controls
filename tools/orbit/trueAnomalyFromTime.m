function f = trueAnomalyFromTime( mu, a, e, t )
% trueAnomalyFromTime: Computes true anomaly (f) from periapse with 
% an input of time of flight
%
% Nicholas A. Mercadante
% Last Modified: 2/8/2016
% ------------------------
% 
%               mu  -- (kg^3/s^2)   gravitational constant
%               a   -- (km)         semi-major axis
%               f   -- (rad)        Anomaly 1
%               e   -- (1)          eccentricity of orbit
%               t   -- (s)          time of flight

    M = t*sqrt(mu/a^3);
    u = eccentricAnomalyFromMeanAnomaly(M, e);
    f = 2*atan(sqrt((1+e)/(1-e))*tan(u/2));


end

