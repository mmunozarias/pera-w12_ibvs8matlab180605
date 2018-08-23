function p_c2o = trans_b2c(p_b2o,q)
% trans_b2c   transform a homogenious vector
%             from the base from to the camera frame

px_b2o = [ p_b2o; 1 ];
px_c2o = htrans_b2c(q)*px_b2o;
p_c2o = px_c2o(1:3);
