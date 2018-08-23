function M = geneM_w12(q)
% geneM_w12   generate the inertia matrix for PERA with W1 and W2
%
% from the model generator 
% based on the DH table of Mauricio's paper submitted to Automatica

%% load physical parameters
phy_param;
%dcl2 = 0;   % ignore dl2 in dynamics

%% the inertia matrix derived from the model generator

m11 = I1 + I2 + m2*dcl2^2 + m2*(acl2*cos(q(2)))^2;
m12 = m2*acl2*dcl2*sin(q(2));
m22 = m2*acl2^2 + I2;

M = [ 
    m11, m12;...
    m12, m22;
];
