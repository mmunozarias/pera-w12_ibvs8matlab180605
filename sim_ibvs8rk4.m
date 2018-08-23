clear all
clf

%% initial state (z := [q1, q2,  q1dot, q2dot,  q1d, q2d]^T)
z0 = [ 0, 0,  0, 0,  0, 0 ]';

%t0 = 0;  tf = 8.0;  h = 0.001;  td = t0:h:tf;
t0 = 0;  tf = 0.002;  h = 0.001;  td = t0:h:tf;
fc = @(t, z) w12pera_vision(t, z);
%fd = c2d_rk4( fc, h );   % by using 4th-order Runge-Kutta method
fd = c2d_euler( fc, h );   % by using Euler method
z = zeros( numel(td), numel(z0) );  z(1,:) = z0';
for k=1:(numel(td)-1),
    z(k+1,:) = fd( td(k), z(k,:)');
end

figure(1)
plot(subplot(2,1,1), td,z(:,1),'-', td,z(:,2),'-')
ylabel('Joint angle (rad)');
legend('q_1','q_2', 'Location','north', 'Orientation','horizontal')
plot(subplot(2,1,2), td,z(:,3),'-', td,z(:,4),'-')
ylabel('Joint velocity (rad/s)');
xlabel('Time (s)');
legend('dq_1/dt','dq_2/dt',...
       'Location','north', 'Orientation','horizontal')
figure(2)
obj_info;
[n, m] = size(td);
tau = zeros(m,3);
q = z(:,1:2);
for k = 1:m
    p_c2o = trans_b2c( p_b2o,q(k,:) );
    tau(k,:) = persproj( p_c2o );
end
contr_param;   % only for showing taud
plot(subplot(2,1,1), td,taud(1)*ones(size(td,1),1),'--',...
     td,taud(2)*ones(size(td,1),1),'--', td,tau(:,1),'-', td,tau(:,2),'-')
ylabel('mu, nu (pix)');
legend('\mu_d','\nu_d', '\mu','\nu',...
       'Location','north', 'Orientation','horizontal')
plot(subplot(2,1,2), td,taud(3)*ones(size(td,1),1),'--', td,tau(:,3),'-')
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
plot(subplot(3,1,1), td,K(:,1),'-')
ylabel('Kinetic ene.');
plot(subplot(3,1,2), td,P(:,1),'-')
ylabel('Potential ene.');
plot(subplot(3,1,3), td,T(:,1),'-')
ylabel('Total ene.');
xlabel('Time (s)');
