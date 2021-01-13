function Generate__Zener_Particles__2d()
%-------------------------------------------------------------
global zenerindices zslsp zslspc cntele zcnt cntxythetainfo
%-------------------------------------------------------------
% KEY VARIABLES
zslsp          = [];
zslspc         = [];
zcnt           = [];
zenerindices   = [];
%-------------------------------------------------------------
cntele         = [];
cntxythetainfo = [];
%-------------------------------------------------------------
create_slsp_2d()
create_slspc_2d()
create_high_AR_pseudo_1D_particle_chains()
%-------------------------------------------------------------
%  CARBON NANO-TUBES

% %% form 'zenerindices' variable
% if numel(zenerindices)==0
%     zenerindices = [-1E4 -2E4];
% end

end