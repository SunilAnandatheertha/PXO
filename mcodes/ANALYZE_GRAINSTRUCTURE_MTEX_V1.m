function  [GrainSizes_mtex_TRIALS, numNeighbors_mtex_TRIALS,...
    equivalentRadius_mtex_TRIALS,equivalentPerimeter_mtex_TRIALS,...
    ShapeFactor_mtex_TRIALS, AspectRatio_mtex_TRIALS] = ANALYZE_GRAINSTRUCTURE_MTEX_V1(AnGSmtex_flag,...
    trial_count, GrainSizes_mtex_TRIALS, numNeighbors_mtex_TRIALS, equivalentRadius_mtex_TRIALS,...
    ShapeFactor_mtex_TRIALS, AspectRatio_mtex_TRIALS, GS_Plot_Options)

%-----------------------------------
if AnGSmtex_flag == 1
    %-----------------------------------
    fprintf(['Extracting grain structure parameters for TRIAL # ' num2str(trial_count) '\n'])
    [GrainSizes_mtex, numNeighbors_mtex,...
        equivalentRadius_mtex, equivalentPerimeter_mtex,...
        ShapeFactor_mtex, AspectRatio_mtex] = Calculate_GS_Data_using_mtex_v2(trial_count, GS_Plot_Options);
    %close all
    %-----------------------------------
    GrainSizes_mtex_TRIALS{1,trial_count}          = GrainSizes_mtex;
    numNeighbors_mtex_TRIALS{1,trial_count}        = numNeighbors_mtex;
    equivalentRadius_mtex_TRIALS{1,trial_count}    = equivalentRadius_mtex;
    equivalentPerimeter_mtex_TRIALS{1,trial_count} = equivalentPerimeter_mtex;
    ShapeFactor_mtex_TRIALS{1,trial_count}         = ShapeFactor_mtex;
    AspectRatio_mtex_TRIALS{1,trial_count}         = AspectRatio_mtex;
end

