function cHb = htrans_b2c(q)
% htrans_b2c   Define the Homogenious matrix
%              from the end-effector frame to the base frame

cHb = inv(htrans_c2b(q));
