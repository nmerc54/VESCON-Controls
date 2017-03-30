classdef Parameters
    %UNTITLED3 Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        q;
        q_dot;
        q_des;
        H;
        I;
        T;
        dt;
              
    end
    
    methods
        function obj = Parameters(quaternion, quat_dot, desiredQuaternion, AngularMomentum, ...
                                  InertiaTensor, TorqueMagnitude, time_step)
           obj.q        = quaternion; 
           obj.q_dot    = quat_dot;
           obj.q_des    = desiredQuaternion;
           obj.H        = AngularMomentum;
           obj.I        = InertiaTensor;
           obj.T        = TorqueMagnitude;
           obj.dt       = time_step;
           
        end
    end
    
end

