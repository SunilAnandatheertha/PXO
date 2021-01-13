function Minimize_Del_H_2d_V3()
% Minimize global hamilotonian change
global Lattice MC_Loop MC_Param File_Fold_Operations
global secondaryphaseinfo CFN
%--------------------------------------------------------------------------------
delE_Calc_discrete   = MC_Param.delE_calc.discrete;
delE_Calc_continuous = MC_Param.delE_calc.continuous;

N_neigh              = MC_Param.Num_Nearest_Neigh_Level.lattice_square;
lattice_triangular   = MC_Param.Num_Nearest_Neigh_Level.lattice_triangular;
lattice_hexagonal    = MC_Param.Num_Nearest_Neigh_Level.lattice_hexagonal;
%-------------------------------------------------------------
txtwriteint = MC_Loop.DataOperation.txtwriteint;
MC_Loop.AutoConverge.want_autoconv         = 0;
MC_Loop.AutoConverge.TemporalCompareEveryM = MC_Loop.DataOperation.txtwriteint;
MC_Loop.AutoConverge.ThresholdPercChange   = 10;
%--------------------------------------------------------------------------------
% ASSIGN VARIABLES ACCORDING TO INPUTS
initialmcs = MC_Param.StartFrom_MCStep;
if initialmcs == 1
    finalmcs = MC_Param.Num_MC_Steps;
else
    initialmcs = initialmcs + txtwriteint + 1;
    finalmcs   = initialmcs + MC_Param.Num_MC_Steps;
end
%--------------------------------------------------------------------------------
if initialmcs == 1;
    q            = Lattice.q;
    s = Lattice.orientations.s;
    zenerindices = secondaryphaseinfo{1,1};
%     txtwriteint  = ffo{1}{1};
%     nof          = ffo{1}{2};
    nof         = File_Fold_Operations.writedlm.s.nof;
    ham          = zeros(finalmcs,1);
    delham       = zeros(finalmcs,1);
    dlmwrite(strcat(pwd,'\txtfiledet.txt'),...
        [(txtwriteint:txtwriteint:finalmcs)' repmat(nof+1,numel((txtwriteint:txtwriteint:finalmcs)'),1)],...
        'delimiter','\t')
    dlmwrite(strcat(pwd,'\simparameters','\initialfinalmcs.txt'),[initialmcs; finalmcs]);
else
%     nof          = 1;
    nof         = File_Fold_Operations.writedlm.s.nof;
    simpar1      = dlmread(strcat(pwd,'\simparameters','\simpar.txt'));
    %ffo1         = dlmread(strcat(pwd,'\simparameters','\ffo.txt'));
    %     txtwriteint  = ffo1(1);
    s            = dlmread(strcat(pwd, '\results\datafiles\statematrices', '\s', num2str(initialmcs+txtwriteint),'mcs1','.txt'));
    zenerindices = dlmread(strcat(pwd, '\results\datafiles\e','\zener_indices.txt'));
    initialham   = dlmread(strcat(pwd, '\results\datafiles\e','\zener_indices.txt'));
    q            = simpar1(1);
    ham          = zeros(finalmcs,1);
    delham       = zeros(finalmcs,1);
    dlmwrite(strcat(pwd,'\simparameters','\initialfinalmcs.txt'),[initialmcs; finalmcs]);
end
%--------------------------------------------------------------------------------
sz1              = Lattice.size.sz1;
sz2              = Lattice.size.sz2;

E                = zeros(sz1, sz2);
delE             = zeros(sz1, sz2);

e  = Lattice.s__MATLAB_Indices;
ea = Lattice.s__MATLAB_Indices__BounCond_Wrapped;

vf               = dlmread(strcat(pwd,'\simparameters\volumefraction.txt'));
skipmatrix       = zeros(size(s));
zenerindices(zenerindices < 0) = [];
%--------------------------------------------------------------------------------
if numel(zenerindices)>0
    s(zenerindices) = 0;
    skipmatrix(zenerindices) = 1;
end
SZS1P1           = sz1 + 1;
SZS1P2           = sz1 + 2;
SZS1P3           = sz1 + 3;
fprintf('Starting grain growth simulation from MCS = %d\n',initialmcs)
% % % % % % if initialmcs == 1;
% % % % % %     start = initialmcs;
% % % % % % else
% % % % % %     start = initialmcs + txtwriteint + 1;
% % % % % % end
% MONTE-CARLO LOOP
MC_Param.dimensionality = '2d';
MC_Param.WeightMatrixID = 'symm_02';
%--------------------------------------------------------------------------------
consider_energy = 1;
% ConsoleDisplay == 1, LIGHT -- USE FOR SPEED
% ConsoleDisplay == 2, HEAVY -- USE FOR MORE INFORMATION DISPLAY
ConsoleDisplay = 1;
%--------------------------------------------------------------------------------
switch MC_Param.MCP__ALGORITHM
    case 1
        KERNEL__LOOP_MC_2D____ALGORITHM_01(initialmcs, finalmcs, E, delE, SZS1P1, SZS1P2, SZS1P3, ConsoleDisplay, vf, consider_energy, ham)
    case 2
        
    case 3
        
    case 4
        
    case 44
        WeightMatrix = get__weight_matrix(dimensionality, WeightMatrixID);
    case 444
        
    case 4444
        
    case 44441
        
    otherwise
        
end
end