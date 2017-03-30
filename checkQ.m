function flag = checkQ(q, dt, i)
    TIME = 3;   % s
    
    % Check if q is within tolerance for three seconds
    for j = i - (TIME/dt): i
        for n = 1:4
            if q(:, n) > qt + tolerance || q(:, n) < qt - tolerance
                flag = false;
                return
            end
        end
    end
    
    flag = true;

end