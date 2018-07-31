%% *********************************************************************** 
%  Select Torque w/ Quaternion Optimizaton
%  Space Systems Research Laboaratory
%  --------------------------------
%  Nicholas Mercadante
%
%  Project: Rascal-1
%
%
% Name          | Date      | Description
% ------------------------------------------------------------------------
% N.Mercadante   04-29-2017   Initial Release.
% ------------------------------------------------------------------------
%
% COPYRIGHT 2017 Space Systems Research Laboratory, all rights reserved.
%
% ************************************************************************

function [torque_decision] = selectTorqueQ(parameters)
    
    q_actual = parameters.q;      
    H        = parameters.H;       
    I        = parameters.I;
    q_des    = parameters.q_des;
    dt       = parameters.dt;
    eA       = parameters.eA;
    eR       = parameters.eR;
   
    % All possible torque combinations. -----------------------------------
%     torque_options = ...
%        [0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,-1,-1,-1,-1,-1,-1,-1,-1,-1;...
%         0,0,0,1,1,1,-1,-1,-1,0,0,0,1,1,1,-1,-1,-1,0,0,0,1,1,1,-1,-1,-1;...
%         0,1,-1,0,1,-1,0,1,-1,0,1,-1,0,1,-1,0,1,-1,0,1,-1,0,1,-1,0,1,-1];
    % ---------------------------------------------------------------------

    
    if 1==2
        % Calculate Optimum Quaternion, and the torque to achieve it
        q_est = getQest(q_des, q_actual);
        qdot   = (q_est - q_actual).*(1/dt);
        w      = getOmega_from_q( q_actual, qdot );
        H_est  = I*w;
        torque = (H - H_est).*(1/dt);  

        % Return the unit vector that places the system in the optimum
        % direction
        torque_decision = torque./norm(torque);
    else
        % Drive the angular velocity to zero.
        torque = H.*(1/dt);
        torque_decision = torque./norm(torque);
    end
end










