function dzdt = w12pera_vision(t, z)
% W12PERA_VISION   Evaluate the dynamics of the PERA with W1 and W2
%
% z := [q1, q2,  q1dot, q2dot,  u, v, w,  q1d, q2d]^T

q = [z(1), z(2)]';  qdot = [z(3), z(4)]';  tau = [z(5), z(6), z(7)]';
qd = [z(8), z(9)]';

M = geneM_w12(q);
C = geneC_w12(q,qdot);
G = geneG_w12(q);

kf = 1;  taud = [0, 0, 119]';
Ji = image_jacobian(tau);
T_b2c = [
    rot_b2c(q), zeros(3,3);
    zeros(3,3), rot_b2c(q);
];
Jgb = geom_jacobian(q);
Jgc = T_b2c*Jgb;
qdot_d = pinv( Ji*Jgc )*kf*( taud - tau );

kp = 1;  kd = 1;  ki = 0;
u = kp*( qd - q ) + kd*( qdot_d - qdot );
vdyn = inv( M )*( u - C - G );


dzdt = [ 
           qdot;
           vdyn;
    Ji*Jgc*qdot;
         qdot_d;
];
