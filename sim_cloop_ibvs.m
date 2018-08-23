clear all
clf

tspan = [0 8];
%% initial state (z := [bq1, bq2,  bp1, bp2,  u, v, w]^T)
z0 = [ 0, 0,  0, 0,  0, 0 ]';

%opts = odeset('RelTol',1e-3,'AbsTol',1e-6);   % default values
opts = odeset('RelTol',1e-6,'AbsTol',1e-12);
[t, z] = ode45(@w12pera_cloop_vision, tspan, z0, opts);

figure(1)
plot(subplot(2,1,1), t,z(:,1),'-', t,z(:,2),'-')
ylabel('Joint angle (rad)');
legend('q_1','q_2', 'Location','north', 'Orientation','horizontal')
plot(subplot(2,1,2), t,z(:,3),'-', t,z(:,4),'-')
ylabel('Joint velocity (rad/s)');
xlabel('Time (s)');
legend('dq_1/dt','dq_2/dt',...
       'Location','north', 'Orientation','horizontal')
figure(2)
obj_info;
[m, n] = size(t);
tau = zeros(m,3);
q = z(:,1:2);
for k = 1:m
    p_c2o = trans_b2c( p_b2o,q(k,:) );
    tau(k,:) = persproj( p_c2o );
end
contr_param;   % only for showing taud
plot(subplot(2,1,1), t,taud(1)*ones(size(t,1),1),'--',...
     t,taud(2)*ones(size(t,1),1),'--', t,tau(:,1),'-', t,tau(:,2),'-')
ylabel('mu, nu (pix)');
legend('\mu_d','\nu_d', '\mu','\nu',...
       'Location','north', 'Orientation','horizontal')
plot(subplot(2,1,2), t,taud(3)*ones(size(t,1),1),'--', t,tau(:,3),'-')
ylabel('l (pix)');
xlabel('Time (s)');
legend('l_d', 'l', 'Location','north', 'Orientation','horizontal')

K = zeros(m,n);  P = zeros(m,n);  T = zeros(m,n);
for k = 1:m
    qk = [z(k,1), z(k,2)]';
    qkdot = [z(k,3), z(k,4)]';
    K(k,n) = kine_ene_w12(qk,qkdot);
    P(k,n) = poten_ene_w12(qk);
    T(k,n) = K(k,n) + P(k,n);
end
figure(3)
plot(subplot(3,1,1), t,K(:,1),'-')
ylabel('Kinetic ene.');
plot(subplot(3,1,2), t,P(:,1),'-')
ylabel('Potential ene.');
plot(subplot(3,1,3), t,T(:,1),'-')
ylabel('Total ene.');
xlabel('Time (s)');
