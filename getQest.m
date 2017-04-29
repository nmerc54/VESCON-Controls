function q_est = getQest(q_desired, q_actual)
    
    % Compute quaternion transmutted matrix
    % -------------------------------------------------
    % q   = q_desired    : Where I want to go
    % q'  = q_actual     : Where I am
    % q'' = q_estimated  : How I get from where I am to 
    %                      where I need to go
    % -------------------------------------------------
    q_trans = q_transmutted_matrix(q_actual)^-1;
    
    q_est = q_trans * q_desired;

end