%%% Physical parameters

%% length
al1 = 0.0;  al2 = 0.14;  dl2 = 0.035;
acl1 = 0.5*al1;  acl2 = 0.5*al2;  %dcl2 = 0.5*dl2;
% *take dl2 into account in kinematics; ignore dl2 in dynamics (i.e., dcl2 = 0)
L = 0.063;   % width of the object

%% mass
m1 = 0.2;  m2 = m1;   % from Heck's MSc Thesis'11@TUe

%% inertia
%I1 = 0.5;  I2 = 0.5;   % tetative values from physics
I1 = 2.641e-4;   % moments of inertia w.r.t. W1 (kg m^2) given in [Heck 2011] (m.thesis@TUe)
I2 = 3.467e-4;   % moments of inertia w.r.t. W2 (kg m^2)

%% gravitational acceleration
g = 9.80665;

%% cut-off frequency for pseudo-differentiater
f = 700;
