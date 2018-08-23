function valK = kine_ene_w12(q,qdot)
% kine_ene_w12   compute the kinetic energy of PERA with W1 and W2

M = geneM_w12(q);

valK = 0.5*(qdot.')*M*qdot;
