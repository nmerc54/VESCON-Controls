function q = dc2q(A, q_last);
% q = dc2q(A) translates a direction cosine matrix into a quaternion
%	of Euler Symmetric Parameters.  Equations from Wertz, pp. 414-15.
%
% dc2q accepts the optional parameter q_last used to maintain sign
% "smoothness"; since q and -q have the exact same direction cosine matrix,
% the base dc2q always sets the max value of q to be positive.  With
% q_last, the max value of q is set to have the same sign as the
% corresponding element of q_last - which means that the user is
% responsible for any sign confusion that results.
%
% dc2q.m Created 05/01/1995	M. Swartwout
% dc2q.m Updated 05/04/2005	M. Swartwout to handle sign ambiguity
q = zeros(4,1);
q(1) = 0.5*sqrt(1 + A(1,1) - A(2,2) - A(3,3));
q(2) = 0.5*sqrt(1 - A(1,1) + A(2,2) - A(3,3));
q(3) = 0.5*sqrt(1 - A(1,1) - A(2,2) + A(3,3));
q(4) = 0.5*sqrt(1 + A(1,1) + A(2,2) + A(3,3));

[best, bestnum] = max(q); % Choosing the largest ensures numeric accuracy
q(bestnum) = best;
% If q_last is supplied, set q(bestnum) to have the
% same sign as q_last(bestnum)
if (nargin > 1)
    q(bestnum) = sign(q_last(bestnum))*q(bestnum);
end
% Now assign the other three parameters based on the best one
if bestnum == 4
   q(1) = (A(2,3)-A(3,2))/4/q(4);
   q(2) = (A(3,1)-A(1,3))/4/q(4);
   q(3) = (A(1,2)-A(2,1))/4/q(4);
else
   if bestnum == 1
       b = 2; 
       c = 3;
   elseif bestnum == 2, 
       b = 3; 
       c = 1; 
   else
       b = 1; 
       c = 2; 
   end
   q(b) = (A(bestnum,b) + A(b,bestnum))/4/q(bestnum);
   q(c) = (A(bestnum,c) + A(c,bestnum))/4/q(bestnum);
   q(4) = (A(b,c) - A(c,b))/4/q(bestnum);
end