function u = eccentricAnomalyFromMeanAnomaly( M, e )
% Eccentric Anomaly from Mean Anomaly: Finds eccentric anomaly (u) from
%   Mean Anomaly (M) and eccentricity (e).
%   ---
%   Brute force way of doing this. I modeled this after a functioning 
%   C++ program that iteratively computed the friction factor in laminar
%   flow.


    u = M;
    rhs = u-e*sin(u);
    
    % count = 0;                % for debugging
    accuracy = 0.0001;
    
    while (((M - rhs) >= accuracy) || ((M - rhs) <= -accuracy))
        if ((M - rhs) >= accuracy)
            u = 1.01*u;     
            
        elseif ((M - rhs) <= -accuracy)
            u = 0.99*u;
            
        end
        rhs = u-e*sin(u);
        % count = count + 1;    % for debugging
    end

end

