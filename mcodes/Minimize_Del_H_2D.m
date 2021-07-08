function Minimize_Del_H_2D()
%--------------------------------------------------------------------------------
global Lattice MC_Loop MC_Param File_Fold_Operations
global secondaryphaseinfo CFN
%--------------------------------------------------------------------------------
delE_Calc_discrete   = MC_Param.delE_calc.discrete;
delE_Calc_continuous = MC_Param.delE_calc.continuous;

N_neigh              = MC_Param.Num_Nearest_Neigh_Level.lattice_square;
lattice_triangular   = MC_Param.Num_Nearest_Neigh_Level.lattice_triangular;
lattice_hexagonal    = MC_Param.Num_Nearest_Neigh_Level.lattice_hexagonal;
%--------------------------------------------------------------------------------
txtwriteint = MC_Loop.DataOperation.txtwriteint;
% MC_Loop.AutoConverge.want_autoconv         = 0;
% MC_Loop.AutoConverge.TemporalCompareEveryM = MC_Loop.DataOperation.txtwriteint;
% MC_Loop.AutoConverge.ThresholdPercChange   = 10;
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
    nof          = File_Fold_Operations.writedlm.s.nof;
    ham          = zeros(finalmcs, 1);
    delham       = zeros(finalmcs, 1);
    dlmwrite(strcat(pwd,'\txtfiledet.txt'),...
        [(txtwriteint:txtwriteint:finalmcs)' repmat(nof+1,numel((txtwriteint:txtwriteint:finalmcs)'),1)],...
        'delimiter','\t')
    dlmwrite(strcat(pwd,'\simparameters','\initialfinalmcs.txt'),[initialmcs; finalmcs]);
else
    nof          = File_Fold_Operations.writedlm.s.nof;
    simpar1      = dlmread(strcat(pwd,'\simparameters','\simpar.txt'));
    s            = dlmread(strcat(pwd, '\results\datafiles\statematrices', '\s', num2str(initialmcs+txtwriteint),'mcs1','.txt'));
    zenerindices = dlmread(strcat(pwd, '\results\datafiles\e','\zener_indices.txt'));
    initialham   = dlmread(strcat(pwd, '\results\datafiles\e','\zener_indices.txt'));
    q            = simpar1(1);
    ham          = zeros(finalmcs,1);
    delham       = zeros(finalmcs,1);
    dlmwrite(strcat(pwd, '\simparameters', '\initialfinalmcs.txt'), [initialmcs; finalmcs]);
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
if numel(zenerindices) > 0
    s(zenerindices) = 0;
    skipmatrix(zenerindices) = 1;
end
SZS1P1           = sz1 + 1;
SZS1P2           = sz1 + 2;
SZS1P3           = sz1 + 3;
fprintf('Starting grain growth simulation from MCS = %d\n', initialmcs)
%--------------------------------------------------------------------------------
% MC_Param.dimensionality = '2d';
% MC_Param.WeightMatrixID = 'symm_02';
%--------------------------------------------------------------------------------
consider_energy = 1;
ConsoleDisplay  = 1; % 1: LIGHT -- USE FOR SPEED, 2: HEAVY -- USE FOR MORE INFORMATION DISPLAY
%--------------------------------------------------------------------------------
switch MC_Param.MCP__ALGORITHM
    case 01; disp('Using algorithm 1');  KERNEL__LOOP_MC_2D____ALGORITHM_01(initialmcs, finalmcs, consider_energy, E, delE, ham, SZS1P1, SZS1P2, SZS1P3, vf, skipmatrix, ConsoleDisplay)
    case 0101; disp('Using algorithm 0101'); KERNEL__LOOP_MC_2D____ALGORITHM_0101(initialmcs, finalmcs, consider_energy, E, delE, ham, SZS1P1, SZS1P2, SZS1P3, vf, skipmatrix, ConsoleDisplay)
    case 0102; disp('Using algorithm 0102'); KERNEL__LOOP_MC_2D____ALGORITHM_0102(initialmcs, finalmcs, consider_energy, E, delE, ham, SZS1P1, SZS1P2, SZS1P3, vf, skipmatrix, ConsoleDisplay)
    case 02; disp('Using algorithm 2');  KERNEL__LOOP_MC_2D____ALGORITHM_02(initialmcs, finalmcs, consider_energy, E, delE, ham, SZS1P1, SZS1P2, SZS1P3, vf, skipmatrix, ConsoleDisplay)
    case 0201; disp('Using algorithm 0201');  KERNEL__LOOP_MC_2D____ALGORITHM_0201(initialmcs, finalmcs, consider_energy, E, delE, ham, SZS1P1, SZS1P2, SZS1P3, vf, skipmatrix, ConsoleDisplay)
    case 0202; disp('Using algorithm 0202');  KERNEL__LOOP_MC_2D____ALGORITHM_0202(initialmcs, finalmcs, consider_energy, E, delE, ham, SZS1P1, SZS1P2, SZS1P3, vf, skipmatrix, ConsoleDisplay)
    case 03; disp('Using algorithm 3');  KERNEL__LOOP_MC_2D____ALGORITHM_03(initialmcs, finalmcs, consider_energy, E, delE, ham, SZS1P1, SZS1P2, SZS1P3, vf, skipmatrix, ConsoleDisplay)
    case 0301; disp('Using algorithm 0301');  KERNEL__LOOP_MC_2D____ALGORITHM_0301(initialmcs, finalmcs, consider_energy, E, delE, ham, SZS1P1, SZS1P2, SZS1P3, vf, skipmatrix, ConsoleDisplay)
    case 0302; disp('Using algorithm 0302');  KERNEL__LOOP_MC_2D____ALGORITHM_0302(initialmcs, finalmcs, consider_energy, E, delE, ham, SZS1P1, SZS1P2, SZS1P3, vf, skipmatrix, ConsoleDisplay)
    case 04; disp('Using algorithm 4');  KERNEL__LOOP_MC_2D____ALGORITHM_04(initialmcs, finalmcs, consider_energy, E, delE, ham, SZS1P1, SZS1P2, SZS1P3, vf, skipmatrix, ConsoleDisplay)
    case 05; disp('Using algorithm 5');  KERNEL__LOOP_MC_2D____ALGORITHM_05(initialmcs, finalmcs, E, delE, ham, SZS1P1, SZS1P2, SZS1P3, vf, skipmatrix, ConsoleDisplay) % ONLY WHEN THERE ARE ZERO ZENER PARTICLES
    case 06; disp('Using algorithm 6');  KERNEL__LOOP_MC_2D____ALGORITHM_06(initialmcs, finalmcs, consider_energy, E, delE, ham, SZS1P1, SZS1P2, SZS1P3, vf, skipmatrix, ConsoleDisplay)
    case 07; disp('Using algorithm 7');  KERNEL__LOOP_MC_2D____ALGORITHM_07(initialmcs, finalmcs, consider_energy, E, delE, ham, SZS1P1, SZS1P2, SZS1P3, vf, skipmatrix, ConsoleDisplay)        
    case 08; disp('Using algorithm 8');  KERNEL__LOOP_MC_2D____ALGORITHM_08(initialmcs, finalmcs, consider_energy, E, delE, ham, SZS1P1, SZS1P2, SZS1P3, vf, skipmatrix, ConsoleDisplay)
    case 09; disp('Using algorithm 9');  KERNEL__LOOP_MC_2D____ALGORITHM_09(initialmcs, finalmcs, consider_energy, E, delE, ham, SZS1P1, SZS1P2, SZS1P3, vf, skipmatrix, ConsoleDisplay)
    case 10; disp('Using algorithm 10'); KERNEL__LOOP_MC_2D____ALGORITHM_10(initialmcs, finalmcs, consider_energy, E, delE, ham, SZS1P1, SZS1P2, SZS1P3, vf, skipmatrix, ConsoleDisplay)
    case 11; disp('Using algorithm 11'); KERNEL__LOOP_MC_2D____ALGORITHM_11(initialmcs, finalmcs, consider_energy, E, delE, ham, SZS1P1, SZS1P2, SZS1P3, vf, skipmatrix, ConsoleDisplay)
    case 12; disp('Using algorithm 12'); KERNEL__LOOP_MC_2D____ALGORITHM_12(initialmcs, finalmcs, consider_energy, E, delE, ham, SZS1P1, SZS1P2, SZS1P3, vf, skipmatrix, ConsoleDisplay)
    case 13; disp('Using algorithm 13'); KERNEL__LOOP_MC_2D____ALGORITHM_13(initialmcs, finalmcs, consider_energy, E, delE, ham, SZS1P1, SZS1P2, SZS1P3, vf, skipmatrix, ConsoleDisplay)
    case 14; disp('Using algorithm 14'); KERNEL__LOOP_MC_2D____ALGORITHM_14(initialmcs, finalmcs, consider_energy, E, delE, ham, SZS1P1, SZS1P2, SZS1P3, vf, skipmatrix, ConsoleDisplay)
    case 15; disp('Using algorithm 15'); KERNEL__LOOP_MC_2D____ALGORITHM_15(initialmcs, finalmcs, consider_energy, E, delE, ham, SZS1P1, SZS1P2, SZS1P3, vf, skipmatrix, ConsoleDisplay)
    case 16; disp('Using algorithm 16'); KERNEL__LOOP_MC_2D____ALGORITHM_16(initialmcs, finalmcs, consider_energy, E, delE, ham, SZS1P1, SZS1P2, SZS1P3, vf, skipmatrix, ConsoleDisplay)
    case 17; disp('Using algorithm 17'); KERNEL__LOOP_MC_2D____ALGORITHM_17(initialmcs, finalmcs, consider_energy, E, delE, ham, SZS1P1, SZS1P2, SZS1P3, vf, skipmatrix, ConsoleDisplay)
    case 18; disp('Using algorithm 18'); KERNEL__LOOP_MC_2D____ALGORITHM_18(initialmcs, finalmcs, consider_energy, E, delE, ham, SZS1P1, SZS1P2, SZS1P3, vf, skipmatrix, ConsoleDisplay)
    case 19;
    case 20; disp('Using algorithm 20'); KERNEL__LOOP_MC_2D____ALGORITHM_20(initialmcs, finalmcs, consider_energy, E, delE, ham, SZS1P1, SZS1P2, SZS1P3, vf, skipmatrix, ConsoleDisplay)
    case 21;
    otherwise
        
end
end