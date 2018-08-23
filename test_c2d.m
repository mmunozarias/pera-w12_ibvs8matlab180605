close all
clear all

% Problem setting
x0 = [2, 0];  t0 = 0;  tf = 10;
fc = @(t, x) [ x(2); (1-x(1)^2)*x(2) - x(1) ];

% Continuous Simulation
[tc, xc] = ode45( fc, [t0 tf], x0 );

% Discrete Simulation
h = 0.2;
td = t0:h:tf;
fd_euler = c2d_euler( fc, h );
xd_euler = zeros( numel(td), 2 );  xd_euler(1,:) = x0;
fd_rk4 = c2d_rk4( fc, h );
xd_rk4 = zeros( numel(td), 2 );  xd_rk4(1,:) = x0;
for k=1:(numel(td)-1)
    xd_euler(k+1,:) = fd_euler( td(k), xd_euler(k,:)');
    xd_rk4(k+1,:) = fd_rk4( td(k), xd_rk4(k,:)');
end

% Show results
plot( tc,xc(:,1),'-g', td, xd_euler(:,1),'xb', td, xd_rk4(:,1),'*r' )
xlabel('t'), ylabel('x1')
legend('Continuous', 'Discrete (Euler)', 'Discrete (RK4)')