function FEA_2d_SingleGrapheneSheet(xsgs,ysgs,cov_gra,vd1_gra,vd2_gra)
% This function performs LINEAR and NON-LINEAR F.E.A of single graphene sheets. 
% Types of elements considered: 1. Elements representing Covalent bonds
%                               2. Elements representing Van-Der Walls bonds of type 1
%                               2. Elements representing Van-Der Walls bonds of type 2
% Governing Pot.Function for Non-Linear Covalent element: Morse Potential
% Morse Potential function parameters:
% Governing Pot.Function for Non-Linear Van-Der Walls element: L-J Potential
% L-J Potential function parameters:

%% Calculate Degree Of Freedom
dimensionality = 2; % 'x' and 'y' only since this is a 2D simulation
DOF = dimensionality*(numel(xsgs)-numel(find(isnan(xsgs)==1)));
%% Form stiffness matrix
% Initialize GLobal Stiffness Matrix
KGBL = zeros(DOF); % KGBL: K GloBaL

NumOfCovEle = size(cov_gra,1);
for ct1 = 1:NumOfCovEle
    KLCL = 
end

end