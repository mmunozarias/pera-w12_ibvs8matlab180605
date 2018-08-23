function valP = poten_ene_w12(q)
% poten_ene_w12   compute the potential energy of PERA with W1 and W2

%% load physical parameters
phy_param;

%% from the model generator
valP = g*m2*(dcl2*sin(q(1)) - acl2*cos(q(1))*cos(q(2)));