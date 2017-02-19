function [dV_1, dV_2, a_trans] = transferOrbit( r1, r2, a_curr, a_des, e_trans, mu )
% This function calculates transfer orbit from two locations
% plus the eccentricity of the desired transfer.

    %% Orbit Parameters of Current(1) ad Desired(2) Orbits
        
        % Current Orbit Characteristics
        %a_curr = (r1 / (1+e_curr)^2) * (1 + e_curr*cos(f1));
        v_curr_1 = velocity(mu, a_curr, r1);
        
        % Desired Orbit Characteristics
        %a_des = (r2 / (1+e_des)^2) * (1 + e_des*cos(f2));
        v_des_2 = velocity(mu, a_des, r2);
        
    %% Orbit Parameters of Transfer Orbit
    
        % Assume r1 == rp
        a_trans = r1/(1+e_trans);
        
        v_trans_1 = velocity(mu, a_trans, r1);
        v_trans_2 = velocity(mu, a_trans, r2);
        
        
    %% DeltaV calculations
        
        dV_1 = abs(v_curr_1 - v_trans_1);
        dV_2 = abs(v_des_2 - v_trans_2);


end

