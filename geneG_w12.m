function G = geneG_w12(q)
% geneG_e1w12   generate the gravitational term for PERA with E1, W1, and W2
% 
% from the model generator 
% based on the DH table of Mauricio's paper submitted to Automatica

%% load physical parameters
phy_param;
%dcl2 = 0;   % ignore dl2 in dynamics

%% definition of the gravitational term derived from the model generator
g1 = m2*g*( dcl2*cos(q(1)) + acl2*cos(q(2))*sin(q(1)) );
g2 = m2*g*acl2*cos(q(1))*sin(q(2));
G = [g1, g2]';
