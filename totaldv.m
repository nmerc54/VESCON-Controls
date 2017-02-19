function DV = totaldv(v_earth_1, v_A_1, v_B_2, v_earth_2, mu_L4, mu_earth)
%% Departure from Earth
    Eesc_earth = 0.5*abs(v_earth_1-v_A_1)^2;
    aesc_earth = -mu_earth/(2*Eesc_earth);
    
    %%% Radius of Earth:
    r_earth = 6378; % km
    
    dv1 = velocity(mu_earth, aesc_earth, r_earth);

%% Insertion to L4
    
    %%% Radius of L4
    r_L4 = 10;  % km
    
    E_Transfer1 = 0.5*abs(v_A_1-v_earth_1)^2;     % V_L4 = V_earth
    a_L4 = -mu_L4/(2*E_Transfer1);
    V_land = velocity(mu_L4, a_L4, r_L4);
    
    dv2 = abs(V_land);

%% Departure from L4

    Eesc_L4 = 0.5*abs(v_earth_2-v_B_2)^2;
    aesc_L4 = -mu_L4/(2*Eesc_L4);
    dv3 = velocity(mu_L4, aesc_L4, r_L4); %radius at location of L4 departure (earth apoapse?)


%% Insertion to Earth (ISS)
% Need velocity of ISS at 6778 km

    v_iss = velocity(mu_earth, 6778, 6778);

    dv4 = abs(v_B_2-v_earth_2-v_iss);

%% Total DeltaV 

DV = (dv1+dv2+dv3+dv4);

end
