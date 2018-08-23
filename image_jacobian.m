function Ji = image_jacobian(tau)
% image_jacobian   compute the image Jacobian

%% load physical parameters
phy_param;

%% from the model generator
% Ji = [
%   -tau(3)/L,         0, tau(3)*tau(1)/(f*L),   tau(1)*tau(2)/f, -f-tau(1)*tau(1)/f,  tau(2);...
%           0, -tau(3)/L, tau(3)*tau(2)/(f*L), f+tau(2)*tau(2)/f,   -tau(1)*tau(2)/f, -tau(1);...
%           0,         0, tau(3)*tau(3)/(f*L),   tau(3)*tau(2)/f,   -tau(3)*tau(1)/f,       0;
% ];

Ji = [
  tau(3)*tau(1)/(f*L),  tau(3)/L,        0, -tau(2),   tau(1)*tau(2)/f, f+tau(1)*tau(1)/f;...
  tau(3)*tau(2)/(f*L),         0, tau(3)/L,  tau(1), f+tau(2)*tau(2)/f,   tau(1)*tau(2)/f;...
  tau(3)*tau(3)/(f*L),         0,        0,       0,   tau(3)*tau(2)/f,   tau(3)*tau(1)/f;
];
