function y = TransverselyIsotropicCompliance(E1,E2,NU12,NU23,G12)
%TransverselyIsotropicCompliance This function returns the
% compliance matrix for
% transversely isotropic
% materials. There are five
% arguments representing the
% five independent material
% constants. The size of the
% compliance matrix is 6 x 6.
y = [1/E1     -NU12/E1 -NU12/E1 0             0     0     ;
     -NU12/E1 1/E2     -NU23/E2 0             0     0     ;
     -NU12/E1 -NU23/E2 1/E2     0             0     0     ;
     0        0        0        2*(1+NU23)/E2 0     0     ; 
     0        0        0        0             1/G12 0     ;
     0        0        0        0             0     1/G12];