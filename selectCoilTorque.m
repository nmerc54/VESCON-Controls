%% *********************************************************************** 
%  Select Torque
%  Space Systems Research Laboaratory
%  --------------------------------
%  Nicholas Mercadante
%
%  Project: Rascal-1
%
%
% Name          | Date      | Description
% ------------------------------------------------------------------------
% N.Mercadante   03-29-2017  out and in are in the following form:
%                                       [ Ke_out  ]
%                                       [ error_A ]
%                                       [ error_R ]
%                            This is to conform to the matlab function
%                            standard.
% ------------------------------------------------------------------------
%
% COPYRIGHT 2017 Space Systems Research Laboratory, all rights reserved.
%
% ************************************************************************

function [torque_decision] = selectCoilTorque(parameters)
    
    q       = parameters.q;      
    H       = parameters.H;       
    T       = parameters.T;   % Torque Magnitude
    I       = parameters.I;
    q_des   = parameters.q_des;
    dt      = parameters.dt;
    eA      = parameters.eA;
    eR      = parameters.eR;
    Ke      = parameters.Ke;
   
    % All possible torque combinations. -----------------------------------
    torque_options = ...
        [0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,-1,-1,-1,-1,-1,-1,-1,-1,-1;...
         0,0,0,1,1,1,-1,-1,-1,0,0,0,1,1,1,-1,-1,-1,0,0,0,1,1,1,-1,-1,-1;...
         0,1,-1,0,1,-1,0,1,-1,0,1,-1,0,1,-1,0,1,-1,0,1,-1,0,1,-1,0,1,-1];
    % ---------------------------------------------------------------------

     counter = 1;
     
%    *** GAINS ***  should add up to 1 for sim to work with Ke                      
     kA = 0.70;
     kR = 1-kA;
%    *************
    
    % Initialize Estimated Errors
    error_attitude_est = eA;
    error_rate_est = eR;

    
    for i = 1:27
       % Calculate new quaternion from torque choice
       torque = torque_options(:, i).*T.*Ke;
       H_est = H + torque.*dt;
       w_est = I\H_est;      
       S = quatSkew(w_est);
       q_dot_est = 0.5 .* S * q;            % I am assuming that q_dot_des = 0     
       q_est = normalize( q + q_dot_est.*dt );
       
       % Calculate error and store in array
       q_error = q_est - q_des;     
       error_temp_at = norm(q_error);
       error_temp_rt = norm(w_est);
            
       if (kA*error_temp_at + kR*error_temp_rt) < ...
               (kA*error_attitude_est + kR*error_rate_est)
           
           error_attitude_est = error_temp_at;
           error_rate_est = error_temp_rt;
           counter = i;
       end 
    end
    
    torque_decision = torque_options(:, counter);

end