function dzdt = w12pera_cloop_vision(t, z)
% W12PERA_VISION   Evaluate the dynamics of the PERA with W1 and W2
%
% z := [bq1, bq2,  bp1, bp2,  u, v, w]^T

qbar = [z(1), z(2)]';
pbar = [z(3), z(4)]';
tau = [z(5), z(6), z(7)]';

ptld = pbar + 

%--- developing from here ---

M = geneM_w12(q);
C = geneC_w12(q,qdot);
G = geneG_w12(q);

obj_info;
p_c2o = trans_b2c( p_b2o, q );
% p_c2o = [0.355, -0.038, 0.083]';
tau = persproj( p_c2o );



vdyn = inv( M )*( u - C - G );
dzdt = [ 
      qdot;
      vdyn;
    qdot_d;
];
