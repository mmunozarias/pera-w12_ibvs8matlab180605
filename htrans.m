function H = htrans(a,d,alpha,theta)
% htrans   Define a homogenious matrix based on the modified D-H parameters
%          a: a_{i-1}
%          d: d_i
%          alpha: alpha_{i-1}
%          theta: theta_i

H = [
               cos(theta),           -sin(theta),           0,             a;
    cos(alpha)*sin(theta), cos(alpha)*cos(theta), -sin(alpha), -d*sin(alpha);
    sin(alpha)*sin(theta), sin(alpha)*cos(theta),  cos(alpha),  d*cos(alpha);
                        0,                     0,           0,             1;
];
