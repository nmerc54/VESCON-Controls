%% Control theory

% SPACECRAFT Dimensions -- on Body Axis system
x_dimension = 0.100;    % m
y_dimension = 0.100;    % m
z_dimension = 0.681;    % m

% Inertia Tensor -- on BODY Axis system
I = inertiaTensor(mass, x_dimension, y_dimension, z_dimension);
c = 1e-5;
k = 1e-6;

wn = sqrt(k/I(1,1));
DR = 2*sqrt(k*I(1,1));

T = tf([0 0 1], [1 2*DR*wn wn^2]);

step(T);