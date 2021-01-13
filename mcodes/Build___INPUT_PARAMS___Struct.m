function Build___INPUT_PARAMS___Struct()
%-------------------------------------------------------------
% STRUCTURE: Include Lattice details: "latticesizei", "latticesizej", 'Triangular', 'Square', 
                     % No_Nearest_Neighbour, delE calc by 'descrete' or 'contnuous'
%-------------------------------------------------------------
global Lattice MC_Param MC_Loop Viz_options CMDL_display File_Fold_Operations
%\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
%\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
Lattice.type.square     = 1;
Lattice.type.triangular = 0;
Lattice.type.hexagonal  = 0;
if (Lattice.type.square + Lattice.type.triangular + Lattice.type.hexagonal) > 1
    Lattice.type.square     = 1;
    Lattice.type.triangular = 0;
    Lattice.type.hexagonal  = 0;
end
Lattice.type.random     = 0;
%-------------------------------------------------------------
Lattice.size.i          = 100;
Lattice.size.j          = 100;
Lattice.size.i_incr     = 1.0;
Lattice.size.j_incr     = 1.0;
Lattice.size.xmin       = -floor(Lattice.size.i)/2+1;
Lattice.size.xmax       = +floor(Lattice.size.i)/2;
Lattice.size.ymin       = -floor(Lattice.size.j)/2+1;
Lattice.size.ymax       = +floor(Lattice.size.j)/2;
Lattice.size.xlength    = abs(Lattice.size.xmin)+abs(Lattice.size.xmax);
Lattice.size.ylength    = abs(Lattice.size.ymin)+abs(Lattice.size.ymax);
Lattice.size.Pert_Fac   = 0; % Perturbation factor
[x, y]                  = meshgrid(Lattice.size.xmin : Lattice.size.i_incr : Lattice.size.xmax,...
                                   Lattice.size.ymin : Lattice.size.i_incr : Lattice.size.ymax);
Lattice.size.sz1        = size(x, 1);
Lattice.size.sz2        = size(x, 2);
Lattice.size.x          = x + Lattice.size.Pert_Fac*rand(Lattice.size.sz1, Lattice.size.sz2);
Lattice.size.y          = y + Lattice.size.Pert_Fac*rand(Lattice.size.sz1, Lattice.size.sz2);
%-------------------------------------------------------------





Lattice.q               = 2^5;





%-------------------------------------------------------------
Lattice.zener.slsp.want_slsp = 0;
Lattice.zener.slsp.Vol_Frac  = 1.00; % IN PERCENTAGE
%-------------------------------------------------------------
Lattice.zener.slspc.want_slspc            = 0;      % 0: no clustering is not desired
Lattice.zener.slspc.typeofcluster         = {'circular'   , 1,...
                                             'oval'       , 0,...
                                             'rectangluar', 0,...
                                             'randomized'};
Lattice.zener.slspc.noslspclusters        = 1;      % Set the number of circular clusters
Lattice.zener.slspc.clusterdistr          = {'circular'   , 0,...
                                             'oval'       , 0,...
                                             'rectangluar', 0,...
                                             'triangular' , 0,...
                                             'hexagfonal' , 0,...
                                             'randomized' , 1};
Lattice.zener.slspc.islspcvf              = 01.00;  % Individual cluster VOLUME FRACTION (percentage)
Lattice.zener.slspc.radiusfactorforcircle = 0.3000; % Control circular cluster radius
Lattice.zener.slspc.cif                   = 0.975;  % Cluster inside factor
%-------------------------------------------------------------
Lattice.zener.cnt.want_cnt                 = 0;     %
Lattice.zener.cnt.noofcnt                  = 0032;  % 
Lattice.zener.cnt.NpCNT                    = 0050;  % Number of co-ordinate points to use per cnt
Lattice.zener.cnt.genradiusfactor          = 1.00;  % Cut-off radius factor for each NpCNT of each noofcnt
Lattice.zener.cnt.cntinsidefactor          = 0.95;  % If cnt length is more, decrease this value
Lattice.zener.cnt.thicknessfactor          = 1.00;  % Controls cnt thickness
Lattice.zener.cnt.startingangle            = 0;     % Default is 0 deg. leave this unaltered.
Lattice.zener.cnt.thetaone                 = 000;   % Input should be single row matrix
Lattice.zener.cnt.thetatwo                 = 030;   % Input should be single row matrix
Lattice.zener.cnt.overlaycntsinlatticeplot = 1;     % 
Lattice.zener.cnt.ROTATEiCNTs              = 1;     % Rotate individual CNTs. 1-yes.0-no.
Lattice.zener.cnt.rotateallaboutsameangle  = 0;     % 1-yes.0-no.
Lattice.zener.cnt.icntrotang               = 5;     % it will be be used only if icntinfo{1,13} is 1;
%-------------------------------------------------------------
Lattice.zener.cntc.want_CNTC      = 0;
Lattice.zener.cntc.nocntclusters  = 1;
%-------------------------------------------------------------
Lattice.orientations.s               = floor(1 + Lattice.q*rand(Lattice.size.sz1, Lattice.size.sz2));
Lattice.orientations.s__1_to_numel_s = 1:numel(Lattice.orientations.s);
%-------------------------------------------------------------
Lattice.s__MATLAB_Indices            = reshape(Lattice.orientations.s__1_to_numel_s,...
                                               Lattice.size.sz1, Lattice.size.sz2);
%-------------------------------------------------------------
temp = Lattice.s__MATLAB_Indices;
ea   = [temp(:,Lattice.size.sz2) temp]; clear temp
ea   = [ea ea(:,2)];
ea   = [ea(Lattice.size.sz1,:); ea];
ea   = [ea; ea(2,:)];
Lattice.s__MATLAB_Indices__BounCond_Wrapped = ea;
dlmwrite(strcat(pwd,'\results','\datafiles','\e','\ewrapped.txt'), ea, 'delimiter', '\t'); clear ea

Lattice.ColourMatrix_RGB_UnitNorm    = rand(Lattice.q, 3);
%\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
%\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
MC_Param.delE_calc.discrete       = 1;
MC_Param.delE_calc.continuous     = 0;

MC_Param.Num_Nearest_Neigh_Level.lattice_square     = 1;
MC_Param.Num_Nearest_Neigh_Level.lattice_triangular = 1;
MC_Param.Num_Nearest_Neigh_Level.lattice_hexagonal  = 1;

MC_Param.StartFrom_MCStep = 1;
%-------------------------------------------------------------
%-------------------------------------------------------------



MC_Param.Num_MC_Steps     = 1E3; %<<|<<|<<|<<|<<|<<|<<|<<|<<|<<|<<|



%-------------------------------------------------------------
%-------------------------------------------------------------
MC_Param.MCP__ALGORITHM   = 05;
MC_Param.dimensionality   = '2d';
MC_Param.WeightMatrixID   = 'symm_03';
MC_Param.constant_centre  = 2;
MC_Param.WeightMatrix     = get__weight_matrix(MC_Param.dimensionality, MC_Param.WeightMatrixID);
MC_Param.Consider_Energy  = 1; % Do not change
%-------------------------------------------------------------
%-------------------------------------------------------------



MC_Loop.DataOperation.txtwriteint          = 1E3;  % MCS interval to write data to disk



%-------------------------------------------------------------
%-------------------------------------------------------------
if MC_Loop.DataOperation.txtwriteint > MC_Param.Num_MC_Steps
    MC_Loop.DataOperation.txtwriteint = MC_Param.Num_MC_Steps;
end
MC_Loop.AutoConverge.want_autoconv         = 0;
MC_Loop.AutoConverge.TemporalCompareEveryM = MC_Loop.DataOperation.txtwriteint;
MC_Loop.AutoConverge.ThresholdPercChange   = 10;
%-------------------------------------------------------------
MC_Param.Num_MC_Steps__from_non_unit_StartFrom_MCStep = MC_Loop.DataOperation.txtwriteint;
%-------------------------------------------------------------
Viz_options.GS.UnCharacterized.Overlaid     = 1; % both grain and grain boundary % BF: Before 
Viz_options.GS.UnCharacterized.Plain        = 1; % only grain
Viz_options.GS.UnCharacterized.GrainBound   = 1; % only grain boundary

Viz_options.GS.UnCharacterized.PrintToFile  = 1;
Viz_options.GS.UnCharacterized.ImageFormat  = 'jpeg';
Viz_options.GS.UnCharacterized.ImageQuality = 75;
%-------------------------------------------------------------
CMDL_display.MC_Kernel__Prog_Disp_Interval_m = 50;
%-------------------------------------------------------------
File_Fold_Operations.writedlm.s.nof = 1;
%-------------------------------------------------------------
% Visualize structure of the structure
% % % % % % structstruct(Lattice)
end