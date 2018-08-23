function bHc = htrans_c2b(q)
% htrans_c2b   Define a homogenious matrix
%              from the camera frame to the base frame

%% load physical parameters
phy_param;

a = [ al1, al2 ]';
d = [ 0,   0, dl2 ]';
alpha = [ -pi/2, 0 ]';

bHw1  = htrans(   0,d(1),       0,q(1));
w1Hw2 = htrans(a(1),d(2),alpha(1),q(2));
w2Hc  = htrans(a(2),d(3),alpha(2),   0);

bHc = bHw1*w1Hw2*w2Hc;