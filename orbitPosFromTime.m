function [ f1, f2, r1, r2, v1, v2 ] = orbitPosFromTime( a1, a2, e1, e2, mu, t )
% Orbit Position from time
% ------------------------
% Calculates position, velocity, and anomaly of two 
% bodies from time and orbit characteristics.

    f1 = trueAnomalyFromTime(mu, a1, e1, t);
    f2 = trueAnomalyFromTime(mu, a2, e2, t);
    
    r1 = radiusFromTrueAnomaly(a1, e1, f1);
    r2 = radiusFromTrueAnomaly(a2, e2, f2);
    
    v1 = velocity(mu, a1, r1);
    v2 = velocity(mu, a2, r2);
    
end

