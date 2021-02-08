% INITIALIZATION

rng(1);

XTal_Start_level_n()
Build___INPUT_PARAMS___Struct()
WRITE___INPUT_PARAMS___Struct()
Initialize___MCSolver_DATA()
%------------------------------------------------------------------------------------------------------
% SOLVER
tic
Minimize_Del_H_2D()
toc
%------------------------------------------------------------------------------------------------------
[CFN] = plotgrainstructure2d(1, 1, 1, 998);
%------------------------------------------------------------------------------------------------------
% POST-PROCESSING
figure
[TimeSteps, All_Grains_time, All_GrainBoundaries_time, All_GrainAreas_time, GBL_time,...
    All_GrainEqGrainSize_time, GrainCentroid_xy_time, ogn, CFN, FileLocations, GenericFileName,...
    ImageFileName, DataFileNames, Number_of_grains, Grain_Area_PXL,...
    NGRAINS] = Characterize_Grain_Structure_2D(0, 'af2d', 'ALG_01');
close all;
figure
% plot__Grain_Structure_in_pixels('2d', TimeSteps, All_Grains_time)
plot__Grain_Structure_in_patches('2d', TimeSteps, All_Grains_time)
%------------------------------------------------------------------------------------------------------
% VISUALIZATIONS
plazp2d()
% figure
% [delhamiltonian, CFN] = plotdelham(0);
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