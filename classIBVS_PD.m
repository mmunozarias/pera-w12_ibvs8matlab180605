function [u, qdot_d] = classIBVS_PD( q, qdot, qd, tau )
% classIBVS_PD   Generate the control torque based on 
%                classical IBVS and PD controllers

contr_param;   % load (kf, taud) and (kp, kd, ki)

Ji = image_jacobian( tau );
T_b2c = [
    rot_b2c(q), zeros(3,3);
    zeros(3,3), rot_b2c(q);
];
Jgb = geom_jacobian( q );
Jgc = T_b2c*Jgb;
% classical IBVS control
qdot_d = pinv( Ji*Jgc )*kf*( taud - tau );

% PD control
u = kp*( qd - q ) + kd*( qdot_d - qdot );
