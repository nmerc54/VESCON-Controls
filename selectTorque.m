%% *********************************************************************** 
%  Magnetorquer Controls - 2 TEMP
%  Space Systems Research Laboaratory
%  --------------------------------
%  Nicholas Mercadante
%
%  Project: Rascal-1
%
%
% Name          | Date      | Description
% ------------------------------------------------------------------------
% N.Mercadante   03-29-2017  TEMP
% ------------------------------------------------------------------------
%
% COPYRIGHT 2017 Space Systems Research Laboratory, all rights reserved.
%
% ************************************************************************

function torque_output = selectTorque(parameters)
    
    q       = parameters.q;      
    H       = parameters.H;       
    T       = parameters.T;   % Torque Magnitude
    I       = parameters.I;
    q_des   = parameters.q_des;
    dt      = parameters.dt;
    
    % All possible torque combinations. -----------------------------------
    torque_options = [0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,-1,-1,-1,-1,-1,-1,-1,-1,-1;...
                      0,0,0,1,1,1,-1,-1,-1,0,0,0,1,1,1,-1,-1,-1,0,0,0,1,1,1,-1,-1,-1;...
                      0,1,-1,0,1,-1,0,1,-1,0,1,-1,0,1,-1,0,1,-1,0,1,-1,0,1,-1,0,1,-1];
    % ---------------------------------------------------------------------
    
    % Initialize
    %error = Inf.*zeros(1,27); % Note that everything will fail 
                              % spectacularly if something doesn't get
                              % written. :)
     error = 100;
     counter = 1;
    % parfor?
    for i = 1:27
       % Calculate new quaternion from torque choice
       torque = torque_options(:, i).*T;
       H_new = H + torque.*dt;
       w = I\H_new;
       
       S = quatSkew(w);
       q_dot = 0.5 .* S * q;
       
       q_new = normalize( q + q_dot.*dt );
       
       % Calculate error and store in array
       q_error = q_new - q_des;
       error_temp = norm(q_error);
      
       
       if error_temp < error
           error = error_temp;
           counter = i;
       end
        
    end
    
    torque_decision = torque_options(:, counter);
    torque_output = torque_decision.*T;

end