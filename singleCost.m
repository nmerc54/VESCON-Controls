function [ cost ] = singleCost( time, mass, stages )
% Computed the cost of total mission - does not vary any parameters
    
    % time in days
    % mass in kg
    % stages = numer of stages [1-6]
    
    cost = 5*time + mass/500 + 100*stages;  % Millions of $


end

