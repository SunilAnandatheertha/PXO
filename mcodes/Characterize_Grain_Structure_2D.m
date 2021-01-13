function [TimeSteps, All_Grains_time, All_GrainBoundaries_time,...
            All_GrainAreas_time, GBL_time, All_GrainEqGrainSize_time, GrainCentroid_xy_time, ogn,...
            CFN, FileLocations, GenericFileName, ImageFileName,...
            DataFileNames, Number_of_grains, Grain_Area_PXL,...
            NGRAINS] = Characterize_Grain_Structure_2D(CFN, TECHNIQUE, ALGORITHM)
%-------------------------------------------------------------------------------------------------------------
% [----] = Characterize_Grain_Structure_2D(-----)
% Internal function calls: (1) EXT: AdvancingFront_2D 
%                          (2) EXT: FindPlotWriteStatistics2d
% todo_A [AA-AA-20]-[AA-AA-20]: 
%-------------------------------------------------------------------------------------------------------------
% Find the grain structure details
disp('-------------  -------------  -------------')
disp('')
disp('CHARACTERIZING THE GRAIN STRUCTRURES...')
disp('')
disp('-------------  -------------  -------------')
pause(1)
switch lower(TECHNIQUE)
    case {'af2d', 'advancingfront'}
        %-----------------------------------------------
        DynPlot = {'plot_grains_dynamically',...
                   'printjpeg',...
                   'dont_Plot_GrainNumber_and_q_at_grain_centroid',...
                   'plot_grainboundaries_dynamically'};
        %-----------------------------------------------
        % Indentify the grains
        [TimeSteps, All_Grains_time, All_GrainBoundaries_time,...
            All_GrainAreas_time, All_GrainEqGrainSize_time, GrainCentroid_xy_time, ogn,...
            CFN, FileLocations, GenericFileName, ImageFileName] = AdvancingFront_2D(CFN, ALGORITHM, DynPlot);
        %-----------------------------------------------
        % Calculate the grain boundary lengths
        [GBL_time] = calculate_GBL(All_Grains_time);
        %-----------------------------------------------
    otherwise
        % To do
end
%-------------------------------------------------------------------------------------------------------------
WriteStatisticsFigureToDisk = 1;
WriteGrainIndicesToDisk     = 1;
WriteToDiskOptions = {WriteStatisticsFigureToDisk, WriteGrainIndicesToDisk};
[CFN, DataFileNames, Number_of_grains, Grain_Area_PXL] = FindPlotWriteStatistics2d(All_GrainAreas_time, All_Grains_time, ogn, CFN,...
                                  WriteGrainIndicesToDisk, FileLocations, GenericFileName);
%--------------------------------------------------------------
[NGRAINS] = Plot__Ng__with__Temporal_Slices(Number_of_grains);
end
