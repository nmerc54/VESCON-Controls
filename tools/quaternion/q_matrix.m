function matrix = q_matrix( q_2prime )
    
    q1 = q_2prime(1);
    q2 = q_2prime(2);
    q3 = q_2prime(3);
    q4 = q_2prime(4);

    matrix = [  q4   q3  -q2   q1  ;
               -q3   q4   q1   q2  ;
                q2  -q1   q4   q3  ;
               -q1  -q2  -q3   q4  ];
          


end