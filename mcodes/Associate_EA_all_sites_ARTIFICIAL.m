function [phi1, psi, phi2, PHASEMATRIX] = Associate_EA_all_sites_ARTIFICIAL(dimensionality, statematrix)
%---------------------------------------------------------
global Lattice MC_Param MC_Loop
%---------------------------------------------------------
% rset = 4;
%------------------------------------------------------
x            = Lattice.size.x;
y            = Lattice.size.y;
Q            = Lattice.q;
m            = MC_Param.Num_MC_Steps;
txtwriteint  = MC_Loop.DataOperation.txtwriteint;
%---------------------------------------------------------
LatticeSize_row   = size(x,1);
LatticeSize_col   = size(x,2);
%---------------------------------------------------------
phi1        = zeros(LatticeSize_row, LatticeSize_col);
psi         = zeros(LatticeSize_row, LatticeSize_col);
phi2        = zeros(LatticeSize_row, LatticeSize_col);
PHASEMATRIX = ones(LatticeSize_row, LatticeSize_col);
%---------------------------------------------------------
PARTICLE_LOCATIONS_FILE__FOLDER = 'C:\Users\anandats\OneDrive - Coventry University\coventry-thesis\PAPERS\Monte-Carlo paper codes\results\datafiles\e\zener_indices.txt';
PLOC = dlmread(PARTICLE_LOCATIONS_FILE__FOLDER);
PLOC(find(PLOC<=0))=[];
%---------------------------------------------------------
switch lower(dimensionality)
    case {'2d', 'thinfilm'}
        %---------------------------------------------------------
        for countq = 1:Q % Orientation level
            siteswithq = find(statematrix==countq);
            if ~isempty(siteswithq)
                
                phi1_rand = 90*rand(1);
                psi_rand  = 90*rand(1);
                phi2_rand = 90*rand(1);

                phi1(siteswithq) = phi1_rand;
                psi(siteswithq)  = psi_rand;
                phi2(siteswithq) = phi2_rand;
                
            end
        end
        %---------------------------------------------------------
        for countP = 1:numel(PLOC)
            part_loc = PLOC(countP);
            PHASEMATRIX(part_loc) = 2;
            phi1(part_loc) = 0;
            psi(part_loc)  = 0;
            phi2(part_loc) = 0;
        end
end
%---------------------------------------------------------
end