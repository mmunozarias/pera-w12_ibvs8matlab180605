function vf = persproj(p_c2o)
% image_jacobian   compute the image Jacobian

%% load physical parameters
phy_param;

vf = (f/p_c2o(1))*[
    -p_c2o(2);
     p_c2o(3); 
            L; 
];