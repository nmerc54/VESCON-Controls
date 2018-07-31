function thrusters = get_thruster_fires( torque_choice )

    length = numel(torque_choice(1, :));
    thrusters = zeros(12, length);
    
    for i = 1:length
        
        % X-Body Torque  --------------------------------------------------
        if      torque_choice(1, i) == 1
            thrusters(10, i) = 1;       % Thruster 10
            thrusters(12, i) = 1;       % Thruster 12
        elseif torque_choice(1, i) == -1
            thrusters(9, i) = 1;        % Thruster 9
            thrusters(11, i) = 1;       % Thruster 11
        end
        
        % Y-Body Torque  --------------------------------------------------
        if      torque_choice(2, i) == 1
            thrusters(3, i) = 1;       % Thruster 3
            thrusters(4, i) = 1;       % Thruster 4
            thrusters(5, i) = 1;       % Thruster 5
            thrusters(6, i) = 1;       % Thruster 6            
        elseif torque_choice(2, i) == -1
            thrusters(1, i) = 1;       % Thruster 1
            thrusters(2, i) = 1;       % Thruster 2
            thrusters(7, i) = 1;       % Thruster 7
            thrusters(8, i) = 1;       % Thruster 8 
        end   
        
        % Z-Body Torque  --------------------------------------------------
        if      torque_choice(3, i) == 1
            thrusters(2, i) = 1;       % Thruster 2
            thrusters(4, i) = 1;       % Thruster 4
            thrusters(6, i) = 1;       % Thruster 6
            thrusters(8, i) = 1;       % Thruster 8            
        elseif torque_choice(3, i) == -1
            thrusters(1, i) = 1;       % Thruster 1
            thrusters(3, i) = 1;       % Thruster 3
            thrusters(5, i) = 1;       % Thruster 5
            thrusters(7, i) = 1;       % Thruster 7 
        end  
        
    end
    
end

