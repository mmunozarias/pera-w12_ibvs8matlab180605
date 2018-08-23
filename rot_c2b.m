function bRc = rot_c2b(q)
% rot_c2b   Define a rotational matrix
%           from the camera frame to the base frame

bRc = [ 
    cos(q(1))*cos(q(2)), -cos(q(1))*sin(q(2)), -sin(q(1));
    sin(q(1))*sin(q(2)), -sin(q(1))*sin(q(2)),  cos(q(1));
             -sin(q(2)),            -cos(q(2)),         0; 
];