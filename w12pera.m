function dzdt = w12pera(t, z)
% W12PERA   Evaluate the dynamics of the PERA with W1 and W2
%
% z = [ q1, q2, q1dot, q2dot ]'

q = [z(1), z(2)]';  qdot = [z(3), z(4)]';

M = geneM_w12(q);
C = geneC_w12(q,qdot);
G = geneG_w12(q);

kp = 1;  kd = 1;  ki = 0;
qd = [0.1, -0.1]';  qdot_d = [0, 0]';
tau = kp*(qd - q) + kd*(qdot_d - qdot);

f2 = inv(M)*(tau - C - G);

dzdt = [ 
    z(3);
    z(4);
    f2;
];
