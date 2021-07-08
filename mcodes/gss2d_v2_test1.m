clear all;
close all
% rng(1);
TOTAL_TRIALS  = 1;
AnGSmtex_flag = 1;
%0000000000000000000000000000000000000000000000000000000000000000000000000000
%0000000000000000000000000000000000000000000000000000000000000000000000000000
%0000000000000000000000000000000000000000000000000000000000000000000000000000
GS_Plot_Options_Choices = {'DontPLotAnything',...
                            'Grains,GB,Phases',...
                            'Grains,GB,Phases,TriPntJunc',...
                            'Orientations',...
                            'Orientations,GB',...
                            'Orientations,GB,Phases',...
                            'OrientationsIPFColorKeyed',...
                            'OrientationsIPFColorKeyed,GB',...
                            'OrientationsIPFColorKeyed,GB,Phases'};

GS_Plot_Options = {'Grains,GB,Phases,TriPntJunc'}; % Choose from the above options
%0000000000000000000000000000000000000000000000000000000000000000000000000000
%0000000000000000000000000000000000000000000000000000000000000000000000000000
%0000000000000000000000000000000000000000000000000000000000000000000000000000
trial_count = 1;

fprintf(['WORKING ON TRIAL NUMBER # ' num2str(trial_count) '\n'])
XTal_Start_level_n()
Build___INPUT_PARAMS___Struct_test1()
WRITE___INPUT_PARAMS___Struct()
Initialize___MCSolver_DATA()
Minimize_Del_H_2D()
[CFN] = plotgrainstructure2d(1, 0, 0, 998);
plazp2d()
[TimeSteps, All_Grains_time, All_GrainBoundaries_time, All_GrainAreas_time, GBL_time,...
    All_GrainEqGrainSize_time, GrainCentroid_xy_time, ogn, CFN, FileLocations, GenericFileName,...
    ImageFileName, DataFileNames, Number_of_grains, Grain_Area_PXL,...
    NGRAINS] = Characterize_Grain_Structure_2D(0, 'af2d', 'ALG_01');

%     close all;
    figure
%     plot__Grain_Structure_in_pixels('2d', TimeSteps, All_Grains_time)
    plot__Grain_Structure_in_patches('2d', TimeSteps, All_Grains_time)


if trial_count == 1
    GrainSizes_mtex_TRIALS          = cell(1, TOTAL_TRIALS);
    numNeighbors_mtex_TRIALS        = cell(1, TOTAL_TRIALS);
    equivalentRadius_mtex_TRIALS    = cell(1, TOTAL_TRIALS);
    ShapeFactor_mtex_TRIALS         = cell(1, TOTAL_TRIALS);
    AspectRatio_mtex_TRIALS         = cell(1, TOTAL_TRIALS);
end
[GrainSizes_mtex_TRIALS, numNeighbors_mtex_TRIALS,...
    equivalentRadius_mtex_TRIALS,~,...
    ShapeFactor_mtex_TRIALS, AspectRatio_mtex_TRIALS] = ANALYZE_GRAINSTRUCTURE_MTEX_V1(AnGSmtex_flag,...
    trial_count, GrainSizes_mtex_TRIALS, numNeighbors_mtex_TRIALS, equivalentRadius_mtex_TRIALS,...
    ShapeFactor_mtex_TRIALS, AspectRatio_mtex_TRIALS, GS_Plot_Options);