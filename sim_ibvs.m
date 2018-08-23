clear all
close all

tspan = [0 8];
%tspan = [0 .00001];   % for debug

%% initial state (z := [q1, q2,  q1dot, q2dot,  u, v, w,  q1d, q2d]^T)
z0 = [ 0, 0,  0, 0,  0, 0 ]';

%opts = odeset('RelTol',1e-3,'AbsTol',1e-6);   % default values
opts = odeset('RelTol',1e-6,'AbsTol',1e-12);
tic
[t, z] = ode23s(@w12pera_vision, tspan, z0, opts);
toc
%%
figure
grid on
plot(subplot(2,3,1), t,z(:,1),'-', t,z(:,2),'-')
grid on
ylabel('Joint angle (rad)');
legend('q_1','q_2', 'Location','north', 'Orientation','horizontal')
plot(subplot(2,3,2), t,z(:,3),'-', t,z(:,4),'-')
grid on
ylabel('Joint velocity (rad/s)');
xlabel('Time (s)');
legend('dq_1/dt','dq_2/dt',...
       'Location','north', 'Orientation','horizontal')
%figure(2)
obj_info;
[m, n] = size(t);
tau = zeros(m,3);
q = z(:,1:2);
for k = 1:m
    p_c2o = trans_b2c( p_b2o,q(k,:) );
    tau(k,:) = persproj( p_c2o );
end
contr_param;   % only for showing taud
plot(subplot(2,3,3), t,taud(1)*ones(size(t,1),1),'--',...
     t,taud(2)*ones(size(t,1),1),'--', t,tau(:,1),'-', t,tau(:,2),'-')
grid on
ylabel('mu, nu (pix)');
legend('\mu_d','\nu_d', '\mu','\nu',...
       'Location','north', 'Orientation','horizontal')
plot(subplot(2,3,4), t,taud(3)*ones(size(t,1),1),'--', t,tau(:,3),'-')
grid on
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
%figure(3)
plot(subplot(2,3,4), t,K(:,1),'-')
ylabel('Kinetic ene.');
grid on
plot(subplot(2,3,5), t,P(:,1),'-')
grid on
ylabel('Potential ene.');
plot(subplot(2,3,6), t,T(:,1),'-')
grid on
ylabel('Total ene.');
xlabel('Time (s)');
