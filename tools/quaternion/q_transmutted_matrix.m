function matrix = q_transmutted_matrix( q_prime )
    
    q1 = q_prime(1);
    q2 = q_prime(2);
    q3 = q_prime(3);
    q4 = q_prime(4);

    matrix = [  q4  -q3   q2  q1  ;
                q3   q4  -q1  q2  ;
               -q2   q1   q4  q3  ;
               -q1  -q2  -q3  q4  ];
          


end

