function ms = stagemass(deltaV, mp1, mp2, stage, stages)
%stage is the specific stage that you are calculating mass for
%stages is the total number of stages from the beginning
%mp1 is the time-varying mass of the payload
%mp2 is the mass of all other stages being carried(second payload)
mpl = mp1 + mp2; %total payload mass for current stage
isp = 450;
go = 9.81;
lam1 = 0.05;  %structural mass fraction for each stage
lam2 = 0.08;
lam3 = 0.1;
lam4 = 0.12;
lam5 = 0.15;
%MR is constant throughout each stage
 mr = exp(deltaV/(go*isp*stages)) %mass ratio
 z = (mr - 1)/mr %propellan mass fraction
 format long g
 if stage == 1
    m1 = mpl/(1 - z/(1-lam1)); %mass of whole rocket
    mp1 = z*m1;   %propellant mass
    ms1 = m1 - mpl- mpl; %structural mass
    ms = abs(m1);
 elseif stage == 2
    m2 = mpl/(1 - z/(1-lam2)); %mass of whole rocket
    mp2 = z*m2;   %propellant mass
    ms2 = m2 - mpl- mp2; %structural mass
    ms = abs(m2);
 elseif stage == 3
    m3 = mpl/(1 - z/(1-lam3)); %mass of whole rocket
    mp3 = z*m3;   %propellant mass
    ms3 = m3 - mpl- mp3; %structural mass
    ms = abs(m3);
 elseif stage == 4
    m4 = mpl/(1 - z/(1-lam4)); %mass of whole rocket
    mp4 = z*m4;   %propellant mass
    ms4 = m4 - mpl- mp4; %structural mass
    ms = abs(m4);
 elseif stage == 5
    m5 = mpl/(1 - z/(1-lam5)); %mass of whole rocket
    mp5 = z*m5;   %propellant mass
    ms5 = m5 - mpl- mp5; %structural mass
    ms = abs(m5);
 else 
    m6 = mpl/(1 - z/(1-lam6)); %mass of whole rocket
    mp6 = z*m6;   %propellant mass
    ms6 = m6 - mpl- mp6; %structural mass
    ms = abs(m6);
    
 end 
    

    
    
 