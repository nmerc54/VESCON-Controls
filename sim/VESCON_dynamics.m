RWA.DCM = [ sqrt(1/3) ,  sqrt(1/3) , -sqrt(1/3) , -sqrt(1/3) ; ...
            sqrt(2/3) , -sqrt(2/3) , 0          , 0          ; ...
            0         , 0          , -sqrt(2/3) , sqrt(2/3)  ];
        
RWA.numwheels = 4;
RWA.MAX_WHEEL_SPEED = 280; % rad/s

RWA.wheel_inertia(1) = 4.3e-4; % kg
RWA.wheel_inertia(2) = 4.3e-4; % kg
RWA.wheel_inertia(3) = 4.3e-4; % kg
RWA.wheel_inertia(4) = 4.3e-4; % kg

RWA.wheel_speed(1,1) = 0; % rad/s
RWA.wheel_speed(2,1) = 0; % rad/s
RWA.wheel_speed(3,1) = 0; % rad/s
RWA.wheel_speed(4,1) = 0; % rad/s