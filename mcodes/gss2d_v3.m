clear all;close all
% STARTUP MTEX
% MTEX_FOLDER = 'C:\Users\anandats\Desktop\mtex-5.7.0\mtex-5.7.0';
% cd(MTEX_FOLDER)
% startup_mtex

% WORKING_DIR = 'C:\Users\anandats\OneDrive - Coventry University\coventry-thesis\PAPERS\Monte-Carlo paper codes';
% cd(WORKING_DIR)

% rng(1);
TOTAL_TRIALS  = 1;
AnGSmtex_flag = 1;
%0000000000000000000000000000000000000000000000000000000000000000000000000000
%0000000000000000000000000000000000000000000000000000000000000000000000000000
%0000000000000000000000000000000000000000000000000000000000000000000000000000
% GS_Plot_Options_Choices = {'DontPLotAnything',...
%                             'Grains,GB,Phases',...
%                             'Grains,GB,Phases,TriPntJunc',...
%                             'Orientations',...
%                             'Orientations,GB',...
%                             'Orientations,GB,Phases',...
%                             'OrientationsIPFColorKeyed',...
%                             'OrientationsIPFColorKeyed,GB',...
%                             'OrientationsIPFColorKeyed,GB,Phases'};
GS_Plot_Options = {'Grains,GB,Phases,TriPntJunc'}; % Choose from the above options
%0000000000000000000000000000000000000000000000000000000000000000000000000000
%0000000000000000000000000000000000000000000000000000000000000000000000000000
%0000000000000000000000000000000000000000000000000000000000000000000000000000
for trial_count = 1:TOTAL_TRIALS
    fprintf(['WORKING ON TRIAL NUMBER # ' num2str(trial_count) '\n'])
    XTal_Start_level_n()
    Build___INPUT_PARAMS___Struct()
    WRITE___INPUT_PARAMS___Struct()
    Initialize___MCSolver_DATA()
    Minimize_Del_H_2D()
    [CFN] = plotgrainstructure2d(1, 0, 0, 998);
    % plazp2d()
    [TimeSteps, All_Grains_time, All_GrainBoundaries_time, All_GrainAreas_time, GBL_time,...
        All_GrainEqGrainSize_time, GrainCentroid_xy_time, ogn, CFN, FileLocations, GenericFileName,...
        ImageFileName, DataFileNames, Number_of_grains, Grain_Area_PXL,...
        NGRAINS] = Characterize_Grain_Structure_2D(0, 'af2d', 'ALG_01');
%     close all;
%     figure
%     plot__Grain_Structure_in_pixels('2d', TimeSteps, All_Grains_time)
%     plot__Grain_Structure_in_patches('2d', TimeSteps, All_Grains_time)
    
    
    if trial_count == 1
%         global MC_Param MC_Loop
%         MCSlices          = MC_Loop.DataOperation.txtwriteint: MC_Loop.DataOperation.txtwriteint: MC_Param.Num_MC_Steps;
%         finalMC_TimeSlice = MC_Param.Num_MC_Steps/MC_Loop.DataOperation.txtwriteint;
%         %-----------------------------------
        GrainSizes_mtex_TRIALS          = cell(1, TOTAL_TRIALS);
        numNeighbors_mtex_TRIALS        = cell(1, TOTAL_TRIALS);
        equivalentRadius_mtex_TRIALS    = cell(1, TOTAL_TRIALS);
%         equivalentPerimeter_mtex_TRIALS = cell(1, TOTAL_TRIALS);
        ShapeFactor_mtex_TRIALS         = cell(1, TOTAL_TRIALS);
        AspectRatio_mtex_TRIALS         = cell(1, TOTAL_TRIALS);
    end
    [GrainSizes_mtex_TRIALS, numNeighbors_mtex_TRIALS,...
        equivalentRadius_mtex_TRIALS,~,...
        ShapeFactor_mtex_TRIALS, AspectRatio_mtex_TRIALS] = ANALYZE_GRAINSTRUCTURE_MTEX_V1(AnGSmtex_flag,...
        trial_count, GrainSizes_mtex_TRIALS, numNeighbors_mtex_TRIALS, equivalentRadius_mtex_TRIALS,...
        ShapeFactor_mtex_TRIALS, AspectRatio_mtex_TRIALS, GS_Plot_Options);
end
%0000000000000000000000000000000000000000000000000000000000000000000000000000
%0000000000000000000000000000000000000000000000000000000000000000000000000000
% %0000000000000000000000000000000000000000000000000000000000000000000000000000
global MC_Param MC_Loop
MCSlices          = MC_Loop.DataOperation.txtwriteint: MC_Loop.DataOperation.txtwriteint: MC_Param.Num_MC_Steps;
finalMC_TimeSlice = MC_Param.Num_MC_Steps/MC_Loop.DataOperation.txtwriteint;
%0000000000000000000000000000000000000000000000000000000000000000000000000000
%0000000000000000000000000000000000000000000000000000000000000000000000000000
%0000000000000000000000000000000000000000000000000000000000000000000000000000
PLOT_HISTOGRAMS_GSANA_RESFRMMTEX_V1('GrainAreaDistribution_hist_plotMarkup_sjkhvbke78', MCSlices, TOTAL_TRIALS, GrainSizes_mtex_TRIALS, [])
PLOT_HISTOGRAMS_GSANA_RESFRMMTEX_V1('GrainDiameterDistribution_hist_plotMarkup_sjkhvbke78', MCSlices, TOTAL_TRIALS, equivalentRadius_mtex_TRIALS, [])
PLOT_HISTOGRAMS_GSANA_RESFRMMTEX_V1('numNeighDistribution_hist_plotMarkup_sjkhvbke78',  MCSlices, TOTAL_TRIALS, numNeighbors_mtex_TRIALS, [])
PLOT_HISTOGRAMS_GSANA_RESFRMMTEX_V1('ShapeFactor_hist_plotMarkup_sjkhvbke78',  MCSlices, TOTAL_TRIALS, ShapeFactor_mtex_TRIALS, [])
PLOT_HISTOGRAMS_GSANA_RESFRMMTEX_V1('AspectRatio_hist_plotMarkup_sjkhvbke78',  MCSlices, TOTAL_TRIALS, AspectRatio_mtex_TRIALS, [])
%------------------------------------------------------------------------
%------------------------------------------------------------------------
figure
GrainAreas_AVG = zeros(numel(MCSlices), TOTAL_TRIALS);
for timeslice = 1:numel(MCSlices)
    for trial_number = 1:TOTAL_TRIALS
        data = GrainSizes_mtex_TRIALS{1, trial_number}{timeslice, 1};
        GrainAreas_AVG(timeslice, trial_number) = sum(data)/numel(data);
    end
end
GrainAreas_AVERAGE = sum(GrainAreas_AVG, 2)/size(GrainAreas_AVG, 2);
GrainAreas_max = zeros(1, TOTAL_TRIALS);
for trial_number = 1:TOTAL_TRIALS
    Data = GrainAreas_AVG(:,trial_number); GrainAreas_max(trial_number) = max(Data);
    loglog(MCSlices, Data, '-', 'LIneWidth', 1); hold on
end
plot(MCSlices, GrainAreas_AVERAGE, 'ko', 'MarkerSize', 4, 'MarkerFaceColor', 'none', 'LIneWidth', 2)
SetPlottingProperties01('souhkshbvj9684a6dv', [min(MCSlices) max(MCSlices) min(GrainAreas_max) max(GrainAreas_max)], [12 14], {min(MCSlices), max(MCSlices), min(GrainAreas_max), max(GrainAreas_max)})
arraystring = num2clip(GrainAreas_AVG);
arraystring = num2clip(MCSlices');
%------------------------------------------------------------------------
%------------------------------------------------------------------------
figure
numNeighbors_AVG = zeros(numel(MCSlices), TOTAL_TRIALS);
for timeslice = 1:numel(MCSlices)
    for trial_number = 1:TOTAL_TRIALS
        data = numNeighbors_mtex_TRIALS{1, trial_number}{timeslice, 1};
        numNeighbors_AVG(timeslice, trial_number) = sum(data)/numel(data);
    end
end
numNeighbors_AVERAGE = sum(numNeighbors_AVG, 2)/size(numNeighbors_AVG, 2);
% loglog(MCSlices, numNeighbors_AVERAGE, '-ko', 'MarkerSize', 7, 'MarkerFaceColor', 'y', 'LIneWidth', 1)
% hold on

for trial_number = 1:TOTAL_TRIALS
    loglog(MCSlices, numNeighbors_AVG(:,trial_number), '-', 'LIneWidth', 1); hold on
end
loglog(MCSlices, numNeighbors_AVERAGE, 'ko', 'MarkerSize', 5, 'MarkerFaceColor', 'y', 'LIneWidth', 1)
arraystring = num2clip(numNeighbors_AVG);
%------------------------------------------------------------------------
%------------------------------------------------------------------------
figure
equivalentRadius_AVG = zeros(numel(MCSlices), TOTAL_TRIALS);
for timeslice = 1:numel(MCSlices)
    for trial_number = 1:TOTAL_TRIALS
        data = equivalentRadius_mtex_TRIALS{1, trial_number}{timeslice, 1};
        equivalentRadius_AVG(timeslice, trial_number) = sum(data)/numel(data);
    end
end
equivalentRadius_AVERAGE = sum(equivalentRadius_AVG, 2)/size(equivalentRadius_AVG, 2);
% loglog(MCSlices, equivalentRadius_AVERAGE, '-ko', 'MarkerSize', 7, 'MarkerFaceColor', 'y', 'LIneWidth', 1)
for trial_number = 1:TOTAL_TRIALS
    loglog(MCSlices, equivalentRadius_AVG(:,trial_number), '-', 'LIneWidth', 1); hold on
end
loglog(MCSlices, equivalentRadius_AVERAGE, 'ko', 'MarkerSize', 5, 'MarkerFaceColor', 'y', 'LIneWidth', 1)
arraystring = num2clip(2*equivalentRadius_AVG);
%------------------------------------------------------------------------
%------------------------------------------------------------------------
% figure
% equivalentPerimeter_AVG = zeros(numel(MCSlices), TOTAL_TRIALS);
% for timeslice = 1:numel(MCSlices)
%     for trial_number = 1:TOTAL_TRIALS
%         data = equivalentPerimeter_mtex_TRIALS{1, trial_number}{timeslice, 1};
%         equivalentPerimeter_AVG(timeslice, trial_number) = sum(data)/numel(data);
%     end
% end
% equivalentPerimeter_AVERAGE = sum(equivalentPerimeter_AVG, 2)/size(equivalentPerimeter_AVG, 2);
% % loglog(MCSlices, equivalentPerimeter_AVERAGE, '-ko', 'MarkerSize', 7, 'MarkerFaceColor', 'y', 'LIneWidth', 1)
% for trial_number = 1:TOTAL_TRIALS
%     loglog(MCSlices, equivalentPerimeter_AVG(:,trial_number), '-', 'LIneWidth', 1); hold on
% end
% loglog(MCSlices, equivalentPerimeter_AVERAGE, 'ko', 'MarkerSize', 5, 'MarkerFaceColor', 'y', 'LIneWidth', 1)
%------------------------------------------------------------------------
%------------------------------------------------------------------------
figure
ShapeFactor_AVG = zeros(numel(MCSlices), TOTAL_TRIALS);
for timeslice = 1:numel(MCSlices)
    for trial_number = 1:TOTAL_TRIALS
        data = ShapeFactor_mtex_TRIALS{1, trial_number}{timeslice, 1};
        ShapeFactor_AVG(timeslice, trial_number) = sum(data)/numel(data);
    end
end
ShapeFactor_AVERAGE = sum(ShapeFactor_AVG, 2)/size(ShapeFactor_AVG, 2);
% plot(MCSlices, ShapeFactor_AVERAGE, '-ko', 'MarkerSize', 7, 'MarkerFaceColor', 'y', 'LIneWidth', 1)
for trial_number = 1:TOTAL_TRIALS
    plot(MCSlices, ShapeFactor_AVG(:,trial_number), '-', 'LIneWidth', 1); hold on
end
plot(MCSlices, ShapeFactor_AVERAGE, 'ko', 'MarkerSize', 5, 'MarkerFaceColor', 'y', 'LIneWidth', 1)
hxlab = xlabel('Simulation time');
hylab = ylabel('Shape factor');
set(gca, 'fontsize', 12)

arraystring = num2clip(ShapeFactor_AVG);
%------------------------------------------------------------------------
%------------------------------------------------------------------------ 
figure
AspectRatio_AVG = zeros(numel(MCSlices), TOTAL_TRIALS);
for timeslice = 1:numel(MCSlices)
    for trial_number = 1:TOTAL_TRIALS
        data = AspectRatio_mtex_TRIALS{1, trial_number}{timeslice, 1};
        AspectRatio_AVG(timeslice, trial_number) = sum(data)/numel(data);
    end
end
AspectRatio_AVERAGE = sum(AspectRatio_AVG, 2)/size(AspectRatio_AVG, 2);
for trial_number = 1:TOTAL_TRIALS
    plot(MCSlices, AspectRatio_AVG(:,trial_number), '-', 'LIneWidth', 1); hold on
end
plot(MCSlices, AspectRatio_AVERAGE, 'ko', 'MarkerSize', 5, 'MarkerFaceColor', 'y', 'LIneWidth', 1)
hxlab = xlabel('Simulation time');
hylab = ylabel('Aspect Ratio');
set(gca, 'fontsize', 12)