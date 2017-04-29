function w = getOmega_from_q(q, q_dot)

    q1 = q(1);
    q2 = q(2);
    q3 = q(3);
    q4 = q(4);

    w_temp = ...
        [  q4  q3 -q2 -q1 ; ...
          -q3  q4  q1 -q2 ; ...
           q2 -q1  q4 -q3 ; ...
           q1  q2  q3  q4   ]      *  q_dot  ;
    

    w = w_temp(1:3);
       
end