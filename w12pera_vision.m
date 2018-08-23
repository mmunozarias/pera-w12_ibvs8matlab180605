function dzdt = w12pera_vision(t, z)
% W12PERA_VISION   Evaluate the dynamics of the PERA with W1 and W2
%
% z := [q1, q2,  q1dot, q2dot,  q1d, q2d]^T

q = [z(1), z(2)]';
qdot = [z(3), z(4)]';
qd = [z(5), z(6)]';

M = geneM_w12(q);
C = geneC_w12(q,qdot);
G = geneG_w12(q);

obj_info;
% p_b2o(0) = [0.495, 0.118, 0.038]'
p_c2o = trans_b2c( p_b2o, q );
% p_c2o(0) = [0.355, -0.038, 0.083]'
tau = persproj( p_c2o );
% tau(0) = [74.9, 164, 124]'

%% classical IBVS + PD controller
%[u, qdot_d] = classIBVS_PD( q, qdot, qd, tau );

%% reduction-based IBVS controller
u = reductIBVS( q, qdot, tau );  qdot_d = zeros(2, 1);

%% port-Hamiltonian IBVS controller
%u = phIBVS( q, qdot, tau );  qdot_d = zeros(2, 1);

%t   % for debug
vdyn = inv( M )*( u - C - G );
dzdt = [ 
      qdot;
      vdyn;
    qdot_d;
];
