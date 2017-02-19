function [ time_of_flight ] = timeFromTrueAnomaly( mu, a, e, f1, f2 )
% timeFromTrueAnomaly: Computes time (in seconds) between anomalies f1, f2
% Nicholas A. Mercadante
% Last Modified: 4/30/2016
% ------------------------
% 
%               mu  -- (kg^3/s^2)   gravitational constant
%               a   -- (km)         semi-major axis
%               f1  -- (rad)        Anomaly 1
%               f2  -- (rad)        Anomaly 2
%               e   -- (1)          eccentricity of orbit
%


% Recursive Algorithm
if mod(f1, 2*pi) > pi
    time_of_flight = timeFromTrueAnomaly(mu, a, e, 0, pi - mod(f1,pi) ) ...
                   + timeFromTrueAnomaly(mu, a, e, 0, f2);
    
elseif mod(f2, 2*pi) > pi 
    time_of_flight = timeFromTrueAnomaly(mu, a, e, f1, pi) ...
                   + timeFromTrueAnomaly(mu, a, e, pi - mod(f2, pi), pi); 

elseif  mod(f2, 2*pi) == 0
    time_of_flight = timeFromTrueAnomaly(mu, a, e, f1, pi) ...
                   + timeFromTrueAnomaly(mu, a, e, 0, pi); 
                                  
    
else
% Base Case:

    u1 = 2*atan(sqrt((1-e)/(1+e))*tan(f1/2)); % eccentric anomaly, f1 -- (rad)
    u2 = 2*atan(sqrt((1-e)/(1+e))*tan(f2/2)); % eccentric anomaly, f1 -- (rad)

    M1 = u1 - e*sin(u1);    % Mean anomaly, f1 -- (rad)
    M2 = u2 - e*sin(u2);    % Mean anomaly, f2 -- (rad)

    time_of_flight = sqrt(a^3 / mu)*(M2-M1);    % Time of flight -- (s)

end

end



