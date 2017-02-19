function [C,r_mass] = cost( v_earth_1, v_T_1, v_earth_2, v_T_2, time, mu_earth, mu_L4 )
%Computes cost from various parameters

    dV = totaldv(v_earth_1, v_T_1, v_T_2, v_earth_2, mu_L4, mu_earth);
    
    for n = 1:6
        r_mass(n) = rocketmass(dV*1e3, time, n);
        C(n) = 5*time + r_mass(n)/500 + 100*n;
    end
    
    
    C = C';  % Invert for ease of grabbing data
    r_mass = r_mass';
end

