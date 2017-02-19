function a = semimajorFromTime( mu, e, t, f )
% TIME IN DAYS
    
    t = t*24*3600;  % Now t is in seconds
    
    u = 2*atan( sqrt(( 1-e )/( 1+e )) * tan(f/2) );
    a = mu^(1/3) * (t / (u - e*sin(u) ))^(2/3);

end

