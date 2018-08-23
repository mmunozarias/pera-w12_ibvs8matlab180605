function u = reductIBVS( q, qdot, tau )
% reductIBVS   Generate the control torque based on 
%              reduction-based IBVS controller

phy_param;     % load some kinds of phsical parameters
contr_param;   % load (kf, taud) and (kp, kd, ki)

M = geneM_w12( q );
p = M*qdot;

%T = chol( M, 'lower' );
%T = zeros(2, 2);  T(1,1) = sqrt(M(1,1));  T(2,2) = sqrt(M(2,2));

T = geneT_w12( q );


%[q', det( T )]   % for debug
invT = inv( T );
pbar = invT*p;

G = eye(2);
Gbar = T'*G;

Kp = 1*kp*eye(2);
%% (mu, nu) were converged to (mu_d, nu_d); l was also converged to l_d with (small) steady error
Kt = 0.01*[
    1, 0, 0;
    0, 1, 0;
];
%% (mu, nu) were converged to (mu_d, nu_d); l was also converged to l_d with (small) steady error
% Kt = 0.01*[
%     1, 0, 1;
%     0, 1, 0;
% ];
%% (mu, nu) were converged to (mu_d, nu_d); l was also converged to l_d with (small) steady error
% Kt = 0.01*[
%     1, 0, 0.5;
%     0, 1, 0.5;
% ];
%% (mu, nu) were converged to (mu_d, nu_d); l was also converged to l_d with (small) steady error
% Kt = 0.01*[
%     1, 0, 0;
%     0, 1, 1;
% ];
%% (mu, l) were converged to (mu_d, l_d); nu was also converged to nu_d with steady error
% Kt = 0.01*[
%     1, 0, 0;
%     0, 0, 1;
% ];
%% Computation failed at first approx. 3 ms because telerance setting was not satisfied. 
% Kt = 0.01*[
%     0, 1, 0;
%     0, 0, 1;
% ];
%% Computation failed at first approx. 3 ms because telerance setting was not satisfied. 
% Kt = 0.01*[
%     1, 1, 0;
%     0, 0, 1;
% ];

ferr = tau - taud;   % original

C1 = Kp*( pbar + T'*Kt*ferr );

Jbar22 = zeros(2, 2);
Jbar22(1,2) = ...
    (m2*acl2^2*sin(q(2))*cos(q(2))*p(1))...
    *(I1 + I2 + m2*(acl2*cos(q(2)))^2)^(-0.3e1/0.2e1)...
    *(m2*acl2^2 + I2)^(-0.1e1/0.2e1);
Jbar22(2,1) = -Jbar22(1,2);

D = eye(2);
D(1,1) = 0;   % currently ignore matrix D,...
D(2,2) = 0;   %   but should be like Eq.(67)
Dbar = invT*D*invT';
C2 = (Jbar22 - Dbar)*T'*Kt*ferr;

%% Case A: take dl2 into account
%dVdq = [ g*m2*(dcl2*cos(q(1)) + acl2*sin(q(1))*cos(q(2))), ...
%                            g*m2*acl2*cos(q(1))*sin(q(2)) ];
%% Case B: ignore dl2 (i.e., dcl2 = 0)
dVdq = [ g*m2*acl2*sin(q(1))*cos(q(2)), ...
         g*m2*acl2*cos(q(1))*sin(q(2)) ];

C3 = T*dVdq';

Tdot = zeros(2, 2);
Tdot(1, 1) = ...
    -(m2*acl2^2*qdot(2)*sin(q(2))*cos(q(2)))...
    *(I1 + I2 + m2*(acl2*cos(q(2)))^2)^(-0.1e1/0.2e1);

C4 = Tdot'*Kt*ferr;

Delta = image_jacobian( tau );
T_b2c = [
    rot_b2c(q), zeros(3,3);
    zeros(3,3), rot_b2c(q);
];
Jgb = geom_jacobian( q );
Jgc = T_b2c*Jgb;
Delta_tau = Delta*Jgc;

C5 = T'*Kt*Delta_tau*invT'*pbar;

u = inv( Gbar )*( -C1 + C2 + C3 - C4 - C5 );
