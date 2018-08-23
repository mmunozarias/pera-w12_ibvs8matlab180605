function C = geneC_w12(q,qdot)
% geneC_e1w12   generate the Coriolis term for PERA with E1, W1, and W2
% 
% from the model generator 
% based on the DH table of Mauricio's paper submitted to Automatica

%% load physical parameters
phy_param;
%dcl2 = 0;   % ignore dl2 in dynamics

%% definition of the Coriolis term derived from the model generator
c1 = m2*acl2*qdot(2)*(dcl2*qdot(2)*cos(q(2)) - acl2*qdot(1)*sin(2*q(2)));
c2 = 0.5*m2*(acl2*qdot(1))^2*sin(2*q(2));
C = [c1, c2]';
