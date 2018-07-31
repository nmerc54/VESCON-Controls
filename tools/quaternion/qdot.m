function out = qdot(q,I_omega_B,time);
% dq = qdot(q,I_omega_B,time) calculates either dq/dt or q at the next timestep 
%	depending on the existence of time:
%
% for no inputted time,  out = dq/dt = 0.5*omega_matrix*q
% for any value of time, out = exp(0.5*omega_matrix*t)*q, kinematic propagation
%
% q 	    - quaternion of Euler Symmetric Parameters
% I_omega_B - angular velocity of body with respect to inertial,
%	      expressed in body coordinates
%
% qdot.m Created 4/28/95	M. Swartwout
% qdot.m Updated 11/18/97	M. Swartwout

omega_matrix = [     0 		I_omega_B(3)   -I_omega_B(2) 	I_omega_B(1);
		-I_omega_B(3) 	    0 		I_omega_B(1) 	I_omega_B(2);
		 I_omega_B(2)  -I_omega_B(1) 	     0 		I_omega_B(3);
		-I_omega_B(1)  -I_omega_B(2)   -I_omega_B(3) 	     0];
if nargin == 2
   out = 0.5*omega_matrix*q;
else
   out = expm(0.5*omega_matrix*time)*q;
end
