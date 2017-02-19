function m1 = rocketmass(deltaV, time, stages)
%time should be in days
%dletaV should be in m/s
go = 9.81; %m/s^2
t = time; %time in days
lam1 = 0.05;  %structural mass fraction for each stage
lam2 = 0.08;
lam3 = 0.1;
lam4 = 0.12;
lam5 = 0.15;
isp = 450; %specific impusle in seconds
mpl = (1000 + 10*t); %mass of the payload in kg at start of trip
%MR is constant throughout each stage
 mr = exp(deltaV/(go*isp*stages)); %mass ratio
 z = (mr - 1)/mr ;%propellan mass fraction
 format long g
 
if stages == 1
    m1 = abs(mpl/abs((1 - z/(1-lam1)))); %mass of whole rocket
    mp1 = z*m1;   %propellant mass
    ms1 = m1 - mp1 - mpl; %structural mass
elseif stages == 2
    m2 = mpl/(1 - z/(1-lam2)); %mass of second stage
    mp2 = z*m2;   %propellant mass of stage 2
    ms2 = m2 - mp2 - mp2;  %structural mass of stage 2
    m1 = abs(m2/abs((1 - z/(1-lam1)))); %mass of whole rocket
    mp1 = z*m1;   %propellant mass
    ms1 = m1 - m2- mpl; %structural mass
elseif stages == 3
    m3 = mpl/(1 - z/(1-lam3)); %mass of third stage
    mp3 = z*m3;   %propellant mass of stage 3
    ms3 = m3 - mp3 - mp3;  %structural mass of stage 3
    m2 = m3/(1 - z/(1-lam2)); %mass of second stage
    mp2 = z*m2;   %propellant mass
    ms2 = m2 - m3- mp2; %structural mass
    m1 = abs(m2/abs((1 - z/(1-lam1)))); %mass of whole rocket
    mp1 = z*m1;   %propellant mass
    ms1 = m1 - m2- mpl; %structural mass
elseif stages == 4
    m4 = mpl/(1 - z/(1-lam4)); %mass of fourth stage rocket
    mp4 = z*m4;   %propellant mass
    ms4 = m4 - mpl- mp4; %structural mass
    m3 = m4/(1 - z/(1-lam3)); %mass of third stage
    mp3 = z*m3;   %propellant mass
    ms3 = m3 - m4- mp3; %structural mass
    m2 = m3/(1 - z/(1-lam2)); %mass of second stage
    mp2 = z*m2;   %propellant mass
    ms2 = m2 - m3- mp2; %structural mass
    m1 = abs(m2/abs((1 - z/(1-lam1)))); %mass of whole rocket
    mp1 = z*m1;   %propellant mass
    ms1 = m1 - m2- mpl; %structural mass
elseif stages == 5
    m5 = mpl/(1 - z/(1-lam5)); %mass of fifth stage
    mp5 = z*m5;   %propellant mass
    ms5 = m5 - mpl- mp5; %structural mass
    m4 = m5/(1 - z/(1-lam4)); %mass of fourth stage
    mp4 = z*m4;   %propellant mass
    ms4 = m4 - m5- mp4; %structural mass
    m3 = m4/(1 - z/(1-lam3)); %mass of third stage
    mp3 = z*m3;   %propellant mass
    ms3 = m3 - m4- mp3; %structural mass
    m2 = m3/(1 - z/(1-lam2)); %mass of second stage
    mp2 = z*m2;   %propellant mass
    ms2 = m2 - m3- mp2; %structural mass
    m1 = abs(m2/abs((1 - z/(1-lam1)))); %mass of whole rocket
    mp1 = z*m1;   %propellant mass
    ms1 = m1 - m2- mpl; %structural mass
else 
    m6 = mpl/(1 - z/(1-lam5)); %mass of sixth stage
    mp6 = z*m6;   %propellant mass
    ms6 = m6 - mpl- mp6; %structural mass
    m5 = m6/(1 - z/(1-lam5)); %mass of fifth stage
    mp5 = z*m5;   %propellant mass
    ms5 = m5 - mpl- mp5; %structural mass
    m4 = m5/(1 - z/(1-lam4)); %mass of fourth stage
    mp4 = z*m4;   %propellant mass
    ms4 = m4 - m5- mp4; %structural mass
    m3 = m4/(1 - z/(1-lam3)); %mass of third stage
    mp3 = z*m3;   %propellant mass
    ms3 = m3 - m4- mp3; %structural mass
    m2 = m3/(1 - z/(1-lam2)); %mass of second stage
    mp2 = z*m2;   %propellant mass
    ms2 = m2 - m3- mp2; %structural mass
    m1 = abs(m2/abs((1 - z/(1-lam1)))); %mass of whole rocket
    mp1 = z*m1;   %propellant mass
    ms1 = m1 - m2- mpl; %structural mass
end



