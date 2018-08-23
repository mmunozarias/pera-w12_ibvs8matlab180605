clear all
clf

tspan = [0 10];
%% initial state
z0 = [0, 0,  0, 0]';
%z0 = [0, 1,  0, 0]';
%z0 = [1, 0,  0, 0]';
%z0 = [1, 1,  0, 0]';

%opts = odeset('RelTol',1e-3,'AbsTol',1e-6);   % default values
opts = odeset('RelTol',1e-6,'AbsTol',1e-12);
[t, z] = ode45(@pera_2dofdyn, tspan, z0, opts);

figure(1)
plot(subplot(2,1,1), t,z(:,1),'-', t,z(:,2),'-')
ylabel('Joint angle (rad)');
legend('q_1','q_2', 'Location','north', 'Orientation','horizontal')
plot(subplot(2,1,2), t,z(:,3),'-', t,z(:,4),'-')
ylabel('Joint velocity (rad/s)');
xlabel('Time (s)');
legend('dq_1/dt','dq_2/dt',...
       'Location','north', 'Orientation','horizontal')

[m, n] = size(t);
K = zeros(m,n);  P = zeros(m,n);  T = zeros(m,n);
for k = 1:m
    qk = [z(k,1), z(k,2)]';
    qkdot = [z(k,3), z(k,4)]';
    K(k,n) = kine_ene_w12(qk,qkdot);
    P(k,n) = poten_ene_w12(qk);
    T(k,n) = K(k,n) + P(k,n);
end
figure(2)
plot(subplot(3,1,1), t,K(:,1),'-')
ylabel('Kinetic ene.');
plot(subplot(3,1,2), t,P(:,1),'-')
ylabel('Potential ene.');
plot(subplot(3,1,3), t,T(:,1),'-')
ylabel('Total ene.');
xlabel('Time (s)');
