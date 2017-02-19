function [ grav_force ] = GravForce( m1 , m2, r )
% ---------------------------------------------------------
% GravForce: Calculates Gravitational force given required
%            parameters.
%
%               m1  -- (kg)         First mass
%               m2  -- (kg)         Second mass
%               r   -- (m)          Distance between m1 & m2
%       grav_force  -- (N)          Gravitational force
%
% ---------------------------------------------------------

    G = 6.67e-11;
    
    grav_force = G*m1*m2 / (r^2) ; 

end

