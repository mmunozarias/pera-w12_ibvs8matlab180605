function p_c2o = inv_persproj(vf)
% inv_persproj   compute the inverse of perspective projection

%% load physical parameters
phy_param;

p_c2o = L/vf(3)*[
         f; 
    -vf(1);
     vf(2); 
];
