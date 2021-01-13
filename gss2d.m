% [____Poly-Xtal operations V.9.02____] Developed and maintained by Sunil Anandatheertha 
% (anandats@uni.coventry.ac.uk).Copyright (c) 2020, Sunil Anandatheertha, PhD student 
% (Coventry University) All rights reserved.
%------------------------------------------------------------------------------------------------------
% To_Do
% todo_B_01. (Solver.WM.Field.Calc) PARAMETRIC EQUATION FOR WEIGHT MATRIX IN DELE CALCULATION COMPUTED FOR EVERY LATTICE SITE

% todo_C_01. (ForCPFEM.Mesh.Calc.Quad) GENERATE REGULAR QUAD MESH FOR ABAQUS
% todo_C_02. (ForCPFEM.Mesh.Calc.Tri) GENERATE REGULAR TRI MESH FOR ABAQUS
% todo_C_03. (Domain.GS.ThinFilm.Generate) GENERATE 3D THIN FILM GRAIN STRUCTURE
% todo_C_04. (Char.GS.GrainSize.ZenerFit) AUTO-FIT THE ZENER EQUATION TO GRAIN SIZE EVOLUTION

% todo_D_04. (PXO_Mtex.TEX) EULER SPACE VIEW OF GENERATED ORIENTATIONS
% todo_D_05. (PXO_Mtex.TEX) CONTOUR CODF AND PF, SLICES, ETC

% todo_E_01. (PXO_Mtex.TEX) VORONOI EQUIVALENT OF THE GRAIN STRUCTURE

% todo_F_01. (ForCPFEM.TensileSPecimen.Mesh) GENERATE TENSILE SPECIMEN MESH

% todo_G_01. (Documentation.Video.)
%------------------------------------------------------------------------------------------------------
% BUGS
% (1) grain centroid plot makes overlaps !
% (2) fit equations in todo_A_04 does not look very accurate
% (3) in todo_F_01, geoemtry generation is not straigftorward. Grids may not be same as G.Structure !!
%------------------------------------------------------------------------------------------------------
% INITIALIZATION
XTal_Start_level_n()
Build___INPUT_PARAMS___Struct()
WRITE___INPUT_PARAMS___Struct()
Initialize___MCSolver_DATA()
%------------------------------------------------------------------------------------------------------
% SOLVER
tic
Minimize_Del_H_2D()
toc


[CFN] = plotgrainstructure2d(1, 0, 1, 998);


%------------------------------------------------------------------------------------------------------
% POST-PROCESSING
figure
[TimeSteps, All_Grains_time, All_GrainBoundaries_time, All_GrainAreas_time, GBL_time,...
    All_GrainEqGrainSize_time, GrainCentroid_xy_time, ogn, CFN, FileLocations, GenericFileName,...
    ImageFileName, DataFileNames, Number_of_grains, Grain_Area_PXL,...
    NGRAINS] = Characterize_Grain_Structure_2D(0, 'af2d', 'ALG_01');
close all;
figure
plot__Grain_Structure_in_pixels('2d', TimeSteps, All_Grains_time)
plot__Grain_Structure_in_patches('2d', TimeSteps, All_Grains_time)
% close all
%------------------------------------------------------------------------------------------------------
% VISUALIZATIONS
plazp2d()
figure
[delhamiltonian, CFN] = plotdelham(0);
figure
[CFN]                 = plotgrainstructure2d(1, 1, 1, 998);
%--------------------------
% plot__grain_centroids('2d', GrainCentroid_xy_time)
%--------------------------
plot__grain_area___grain_length('2d', All_GrainAreas_time, GBL_time)
%--------------------------
% close all
% postprocessPROPERTIES2d();
% grainsize_interceptmethod2d; % close all
figure
[AGS_PXL___Time, No_GRAINS___Time] = Plot___AGS_PXL__vs__No_Grains(Grain_Area_PXL, Number_of_grains,...
                                                                   {1, 'jpeg', 100});
%------------------------------------------------------------------------------------------------------
% Extract_Domain_Subset('_left', 0.0, '_right', 1.0, '_bottom', 0.0, '_top'  , 1.0)
%------------------------------------------------------------------------------------------------------
% CONSTRUCT DATASETS
global PHASE GS
[GDTable_0, GrainData_Matrix_0] = PX_Data(TimeSteps, All_Grains_time, All_GrainAreas_time);
% [Fil_Fol_Table] = BookKeeping_FFNames(FileLocations, GenericFileName, ImageFileName, DataFileNames);
Build_PHASE_Struct();
Build_GS_Struct();
%------------------------------------------------------------------------------------------------------
% LINK TEXTURE DATA
[Temporal_Phase_Texture, Number_of_Phases, Phase_SymmDetails,...
    PhaseDetails__for__TEX] = Map__TEX__GRST(GrainData_Matrix_0, Number_of_grains, PHASE, GS);
%------------------------------------------------------------------------------------------------------
[NUM_Grains_PHASE] = Calc_Num_Grains_FOR_Phases('2d', TimeSteps, All_Grains_time);
%---------------------------------------------------------
[EulerAngles_Pixellated] = Associate_EA_all_sites('2d', TimeSteps,...
                                                    All_Grains_time,...
                                                    Temporal_Phase_Texture);
%------------------------------------------------------------------------------------------------------
Build__CTF(EulerAngles_Pixellated)
%------------------------------------------------------------------------------------------------------
%------------------------------------------------------------------------------------------------------
% https://docs.google.com/forms/d/e/1FAIpQLScj3G0NjkNleDJUKRQqJOtcqhQETehmkbF-1lY3DhzBV1O2VA/viewform
%------------------------------------------------------------------------------------------------------
% This to do list start: 19-08-2020
% This to do list end:   
% POLY-XTAL OPERATIONS 9.02

% DONE todo_A_01. (Char.GS.Centroid.Calc) CALCULATE CENTROID FOR EVERY GRAINS
% DONE todo_A_02. (Char.GS.Centroid.Viz) CENTROID PLOT OF THE POLY-CRYSTAL
% DONE todo_A_03. (Char.GS.GrBound.Length.Calc) CALCULATE GRAIN BOUNDARY LENGTH FOR EACH GRAIN
% DONE todo_A_04. (Char.GS.GrBound.Length.Vis) VISUALIZE HOW GRAIN BOUNDARY LENGTH VARIES WITH GRAIN AREA AND FIT MODELS

% DONE todo_D_01. (Data.Build.CTF) EXPORT POLY-CRYSTAL DATA TO .CTF FILE
% DONE todo_D_02. (Data.Build.Orientation) ASSOCIATE EVERY LATTICE SITE WITH THE ORIENTATION OF THE GRAIN
% DONE todo_D_03. (PXO_Mtex.GS.GB.MO) GRAIN BOUNDARY MISORIENTATION PLOT

% DONE todo_F_01. (ForCPFEM.TensileSPecimen.Geometry) GENERATE TENSILE SPECIMEN GEOMETRY

% DONE todo_G_01 get plotxtal out to be called independently
% DONE todo_G_02 get GB calculation and plotting out to be called independently
%------------------------------------------------------------------------------------------------------
%------------------------------------------------------------------------------------------------------