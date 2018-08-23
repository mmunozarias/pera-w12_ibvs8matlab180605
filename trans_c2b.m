function p_b2o = trans_c2b(p_c2o,q)
% trans_c2b   transform a homogenious vector
%             from the camera from to the base frame

px_c2o = [ p_c2o; 1 ];
px_b2o = htrans_c2b(q)*px_c2o;
p_b2o = px_b2o(1:3);
