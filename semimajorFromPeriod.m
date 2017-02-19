function a = semimajorFromPeriod( P, mu )
%Provides semimajor axis (a) from Period (P) and mu

    a = mu^(1/3) * (P/(2*pi))^(2/3);


end

