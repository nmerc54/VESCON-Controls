function A = q2dc(q);
% A = q2dc(q) translates a quaternion of Euler Symmetric Parameters into a 
%	direction cosine matrix.  Equations from Wertz, pp. 414-15
%
% q2dc.m Created 4/28/95	M. Swartwout
% q2dc.m Updated 06/24/2004	M. Swartwout Updated Error Corrections
if size(q,2)*size(q,1) > length(q)
    error('Input q must be a row or column vector')
elseif size(q,2) > 1
    q = q';
end
Q = [0 -q(3) q(2); q(3) 0 -q(1); -q(2) q(1) 0];
A = (2*q(4)^2 - 1)*eye(3) + 2*q(1:3)*q(1:3)' - 2*q(4)*Q;