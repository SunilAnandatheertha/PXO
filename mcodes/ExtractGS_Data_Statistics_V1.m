function [GrArea_PeakPosition_TRIALS, GrArea_PeakHeight_TRIALS, GrArea_PeakWidth_TRIALS,...
NumNeigh_PeakPosition_TRIALS, NumNeigh_PeakHeight_TRIALS, NumNeigh_PeakWidth_TRIALS,...
EqRad_PeakPosition_TRIALS, EqRad_PeakHeight_TRIALS, EqRad_PeakWidth_TRIALS,...
EqPer_PeakPosition_TRIALS, EqPer_PeakHeight_TRIALS, EqPer_PeakWidth_TRIALS,...
ShFac_PeakPosition_TRIALS, ShFac_PeakHeight_TRIALS, ShFac_PeakWidth_TRIALS,...
AsRat_PeakPosition_TRIALS, AsRat_PeakHeight_TRIALS, AsRat_PeakWidth_TRIALS] = ExtractGS_Data_Statistics_V1(TOTAL_TRIALS, finalMC_TimeSlice,...
                          GrainSizes_mtex_TRIALS,...
                          numNeighbors_mtex_TRIALS,...
                          equivalentRadius_mtex_TRIALS,...
                          equivalentPerimeter_mtex_TRIALS,...
                          ShapeFactor_mtex_TRIALS,...
                          AspectRatio_mtex_TRIALS)

close all
disp('-----------------------------------------')
GrArea_PeakPosition_TRIALS   = cell(1, TOTAL_TRIALS);GrArea_PeakHeight_TRIALS     = cell(1, TOTAL_TRIALS);GrArea_PeakWidth_TRIALS      = cell(1, TOTAL_TRIALS);
NumNeigh_PeakPosition_TRIALS = cell(1, TOTAL_TRIALS);NumNeigh_PeakHeight_TRIALS   = cell(1, TOTAL_TRIALS);NumNeigh_PeakWidth_TRIALS    = cell(1, TOTAL_TRIALS);
EqRad_PeakPosition_TRIALS    = cell(1, TOTAL_TRIALS);EqRad_PeakHeight_TRIALS      = cell(1, TOTAL_TRIALS);EqRad_PeakWidth_TRIALS       = cell(1, TOTAL_TRIALS);
EqPer_PeakPosition_TRIALS    = cell(1, TOTAL_TRIALS);EqPer_PeakHeight_TRIALS      = cell(1, TOTAL_TRIALS);EqPer_PeakWidth_TRIALS       = cell(1, TOTAL_TRIALS);
ShFac_PeakPosition_TRIALS    = cell(1, TOTAL_TRIALS);ShFac_PeakHeight_TRIALS      = cell(1, TOTAL_TRIALS);ShFac_PeakWidth_TRIALS       = cell(1, TOTAL_TRIALS);
AsRat_PeakPosition_TRIALS    = cell(1, TOTAL_TRIALS);AsRat_PeakHeight_TRIALS      = cell(1, TOTAL_TRIALS);AsRat_PeakWidth_TRIALS       = cell(1, TOTAL_TRIALS);
disp('-----------------------------------------')
PeakFitType_GrainSizes_mtex = 25; % Log-Normal
disp('-----------------------------------------')

for trial_count = 1:TOTAL_TRIALS
    disp('Initialising Gr.Strc. property extraction')
    %------------------------------------
    GrArea_PeakPosition   = zeros(finalMC_TimeSlice, 1);GrArea_PeakHeight   = zeros(finalMC_TimeSlice, 1);GrArea_PeakWidth   = zeros(finalMC_TimeSlice, 1);
    NumNeigh_PeakPosition = zeros(finalMC_TimeSlice, 1);NumNeigh_PeakHeight = zeros(finalMC_TimeSlice, 1);NumNeigh_PeakWidth = zeros(finalMC_TimeSlice, 1);
    EqRad_PeakPosition    = zeros(finalMC_TimeSlice, 1);EqRad_PeakHeight    = zeros(finalMC_TimeSlice, 1);EqRad_PeakWidth    = zeros(finalMC_TimeSlice, 1);
    EqPer_PeakPosition    = zeros(finalMC_TimeSlice, 1);EqPer_PeakHeight    = zeros(finalMC_TimeSlice, 1);EqPer_PeakWidth    = zeros(finalMC_TimeSlice, 1);
    ShFac_PeakPosition    = zeros(finalMC_TimeSlice, 1);ShFac_PeakHeight    = zeros(finalMC_TimeSlice, 1);ShFac_PeakWidth    = zeros(finalMC_TimeSlice, 1);
    AsRat_PeakPosition    = zeros(finalMC_TimeSlice, 1);AsRat_PeakHeight    = zeros(finalMC_TimeSlice, 1);AsRat_PeakWidth    = zeros(finalMC_TimeSlice, 1);
    %------------------------------------
    disp('-----------------------------------------')
    disp('Extracting time wise property stat. distr. of Gr.structure.')
    %------------------------------------    
    GrainSizes_mtex          = GrainSizes_mtex_TRIALS{1,trial_count};
    numNeighbors_mtex        = numNeighbors_mtex_TRIALS{1,trial_count};
    equivalentRadius_mtex    = equivalentRadius_mtex_TRIALS{1,trial_count};
    equivalentPerimeter_mtex = equivalentPerimeter_mtex_TRIALS{1,trial_count};
    ShapeFactor_mtex         = ShapeFactor_mtex_TRIALS{1,trial_count};
    AspectRatio_mtex         = AspectRatio_mtex_TRIALS{1,trial_count};
    %------------------------------------
    for MC_Time_Slice = 1:finalMC_TimeSlice
        %------------------------------------
        Data     = GrainSizes_mtex{MC_Time_Slice,1};
        h1       = histogram(Data, 20);ble = h1.BinEdges(1:end-1); bre = h1.BinEdges(2:end); xpoints = (ble + bre)/2;
        PeakData = peakfit([xpoints' h1.Values'], 0,0,1,PeakFitType_GrainSizes_mtex, 0,1,[0 0 0 0],0,0,0);close
        GrArea_PeakPosition(MC_Time_Slice) = PeakData(2);
        GrArea_PeakHeight(MC_Time_Slice)   = PeakData(3);
        GrArea_PeakWidth(MC_Time_Slice)    = PeakData(4);
        %    -    -    -    -    -    -    -    -
        GrArea_PeakPosition_TRIALS{1,trial_count}   = GrArea_PeakPosition;
        GrArea_PeakHeight_TRIALS{1,trial_count}     = GrArea_PeakHeight;
        GrArea_PeakWidth_TRIALS{1,trial_count}      = GrArea_PeakWidth;
        %------------------------------------
        Data     = numNeighbors_mtex{MC_Time_Slice,1};
        h1       = histogram(Data, 20);ble = h1.BinEdges(1:end-1); bre = h1.BinEdges(2:end); xpoints = (ble + bre)/2;
        PeakData = peakfit([xpoints' h1.Values'], 0,0,1,PeakFitType_GrainSizes_mtex, 0,1,[0 0 0 0],0,0,0);close
        NumNeigh_PeakPosition(MC_Time_Slice) = PeakData(2);
        NumNeigh_PeakHeight(MC_Time_Slice)   = PeakData(3);
        NumNeigh_PeakWidth(MC_Time_Slice)    = PeakData(4);
        %    -    -    -    -    -    -    -    -
        NumNeigh_PeakPosition_TRIALS{1,trial_count}  = NumNeigh_PeakPosition;
        NumNeigh_PeakHeight_TRIALS{1,trial_count}   = NumNeigh_PeakHeight;
        NumNeigh_PeakWidth_TRIALS{1,trial_count}    = NumNeigh_PeakWidth;
        %------------------------------------
        Data     = equivalentRadius_mtex{MC_Time_Slice,1};
        h1       = histogram(Data, 20);ble = h1.BinEdges(1:end-1); bre = h1.BinEdges(2:end); xpoints = (ble + bre)/2;
        PeakData = peakfit([xpoints' h1.Values'], 0,0,1,PeakFitType_GrainSizes_mtex, 0,1,[0 0 0 0],0,0,0);close
        EqRad_PeakPosition(MC_Time_Slice) = PeakData(2);
        EqRad_PeakHeight(MC_Time_Slice)   = PeakData(3);
        EqRad_PeakWidth(MC_Time_Slice)    = PeakData(4);
        %    -    -    -    -    -    -    -    -
        EqRad_PeakPosition_TRIALS{1,trial_count}    = EqRad_PeakPosition;
        EqRad_PeakHeight_TRIALS{1,trial_count}      = EqRad_PeakHeight;
        EqRad_PeakWidth_TRIALS{1,trial_count}       = EqRad_PeakWidth;
        %------------------------------------
        Data     = equivalentPerimeter_mtex{MC_Time_Slice,1};
        h1       = histogram(Data, 20);ble = h1.BinEdges(1:end-1); bre = h1.BinEdges(2:end); xpoints = (ble + bre)/2;
        PeakData = peakfit([xpoints' h1.Values'], 0,0,1,PeakFitType_GrainSizes_mtex, 0,1,[0 0 0 0],0,0,0);close
        EqPer_PeakPosition(MC_Time_Slice) = PeakData(2);
        EqPer_PeakHeight(MC_Time_Slice)   = PeakData(3);
        EqPer_PeakWidth(MC_Time_Slice)    = PeakData(4);
        %    -    -    -    -    -    -    -    -
        EqPer_PeakPosition_TRIALS{1,trial_count}    = EqPer_PeakPosition;
        EqPer_PeakHeight_TRIALS{1,trial_count}      = EqPer_PeakHeight;
        EqPer_PeakWidth_TRIALS{1,trial_count}       = EqPer_PeakWidth;
        %------------------------------------
        Data     = ShapeFactor_mtex{MC_Time_Slice,1};
        h1       = histogram(Data, 20);ble = h1.BinEdges(1:end-1); bre = h1.BinEdges(2:end); xpoints = (ble + bre)/2;
        PeakData = peakfit([xpoints' h1.Values'], 0,0,1,PeakFitType_GrainSizes_mtex, 0,1,[0 0 0 0],0,0,0);close
        ShFac_PeakPosition(MC_Time_Slice) = PeakData(2);
        ShFac_PeakHeight(MC_Time_Slice)   = PeakData(3);
        ShFac_PeakWidth(MC_Time_Slice)    = PeakData(4);
        %    -    -    -    -    -    -    -    -
        ShFac_PeakPosition_TRIALS{1,trial_count}    = ShFac_PeakPosition;
        ShFac_PeakHeight_TRIALS{1,trial_count}      = ShFac_PeakHeight;
        ShFac_PeakWidth_TRIALS{1,trial_count}       = ShFac_PeakWidth;
        %------------------------------------
        Data     = AspectRatio_mtex{MC_Time_Slice,1};
        h1       = histogram(Data, 20);ble = h1.BinEdges(1:end-1); bre = h1.BinEdges(2:end); xpoints = (ble + bre)/2;
        PeakData = peakfit([xpoints' h1.Values'], 0,0,1,PeakFitType_GrainSizes_mtex, 0,1,[0 0 0 0],0,0,0);close
        AsRat_PeakPosition(MC_Time_Slice) = PeakData(2);
        AsRat_PeakHeight(MC_Time_Slice)   = PeakData(3);
        AsRat_PeakWidth(MC_Time_Slice)    = PeakData(4);
        %    -    -    -    -    -    -    -    -
        AsRat_PeakPosition_TRIALS{1,trial_count}    = AsRat_PeakPosition;
        AsRat_PeakHeight_TRIALS{1,trial_count}      = AsRat_PeakHeight;
        AsRat_PeakWidth_TRIALS{1,trial_count}       = AsRat_PeakWidth;
        %------------------------------------
        pause(0.5)
        %------------------------------------
    end
end