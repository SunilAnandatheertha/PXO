function [GrainSizes_mtex, numNeighbors_mtex,...
          equivalentRadius_mtex, equivalentPerimeter_mtex,...
          ShapeFactor_mtex, AspectRatio_mtex] = Calculate_GS_Data_using_mtex_v2(trial_count, GS_Plot_Options)

global MC_Param MC_Loop
%---------------------------------------------------------
% rset = 4;
%------------------------------------------------------
m            = MC_Param.Num_MC_Steps;
txtwriteint  = MC_Loop.DataOperation.txtwriteint;
%---------------------------------------------------------
TimeSteps    = txtwriteint:txtwriteint:m;
N_Time_Slices = numel(TimeSteps);
%---------------------------------------------------------
CTF_FOLDER = [pwd filesep 'results\datafiles' filesep 'CTF_FILES_MCSTIME_SLICES'];
%---------------------------------------------------------
%---------------------------------------------------------
if ~exist(CTF_FOLDER, 'dir')
    mkdir(CTF_FOLDER)
end
%---------------------------------------------------------
GrainSizes_mtex          = cell(N_Time_Slices,1);
numNeighbors_mtex        = cell(N_Time_Slices,1);
equivalentRadius_mtex    = cell(N_Time_Slices,1);
equivalentPerimeter_mtex = cell(N_Time_Slices,1);
ShapeFactor_mtex         = cell(N_Time_Slices,1);
AspectRatio_mtex         = cell(N_Time_Slices,1);
%---------------------------------------------------------
for rset = 1:N_Time_Slices % Time slice level
    disp('---------------------------------------------------------')
    fprintf(['Working on trial # ' num2str(trial_count) '--> MC time slice # ' num2str(TimeSteps(rset)) '\n'])
    %---------------------------------------------------------
    % LOAD THE STATE MATRIX IN THIS TIME SLICE
    statematrix = dlmread([pwd filesep 'results\datafiles\statematrices' filesep 's' num2str(TimeSteps(rset)) 'mcs1' '.txt']);
    %---------------------------------------------------------
    % MAKE THE CTF FILE FOR THIS TIME SLICE
    disp('Building CTF file')
    [phi1, psi, phi2, PHASEMATRIX] = Associate_EA_all_sites_ARTIFICIAL('2d', statematrix);
    CTF_FILENAME = [CTF_FOLDER filesep 'CTF_MCS_' num2str(TimeSteps(rset)) '.ctf'];
    Build__CTF__ARTIFICIAL(phi1, psi, phi2, PHASEMATRIX, CTF_FILENAME)
    %---------------------------------------------------------
    %---------------------------------------------------------
    %---------------------------------------------------------
    %---------------------------------------------------------
    % USE MTEX TO MAKE GRAIN STRUCTURE ANALYSIS
    disp('Loading CTF file from mtex')
    ebsd_Gr_STR = loadEBSD_ctf(CTF_FILENAME,'convertSpatial2EulerReferenceFrame');
    ebsd_Gr_STR('PARTICLES').color = [1 0 0];
    % + + + + + + + + + + + + + + + 
    disp('Calculating grains and properties')
    grains = calcGrains(ebsd_Gr_STR('Aluminium'),'angle',0.1*degree);
    number_of_grains = size(grains,1);
    % + + + + + + + + + + + + + + + 
    switch GS_Plot_Options{1}
        case 'DontPLotAnything'
            % Nothing to do here
        case 'Grains,GB,Phases'
            figure; hold on
            plot(grains,'translucent',1,'micronbar', 'off', 'coordinates','off'); hold on
            plot(ebsd_Gr_STR('PARTICLES'),'coordinates','off'); hold on; legend off
        case 'Grains,GB,Phases,TriPntJunc'
            figure; hold on
            plot(grains,'translucent',1,'micronbar', 'off', 'coordinates','off'); hold on
            plot(ebsd_Gr_STR('PARTICLES'),'coordinates','off'); hold on; legend off
            tP = grains.triplePoints; plot(tP,'color','b','linewidth',1, 'markersize', 4)
        case 'Orientations'
        case 'Orientations,GB'
            %plot(grains.boundary,'color','k','linewidth',1.5)
        case 'Orientations,GB,Phases'
        case 'OrientationsIPFColorKeyed'
        case 'OrientationsIPFColorKeyed,GB'
        case 'OrientationsIPFColorKeyed,GB,Phases'
    end


    % + + + + + + + + + + + + + + +
%     figure
%     plot(ebsd_Gr_STR('Aluminium'),ebsd_Gr_STR('Aluminium').orientations.angle./degree)
%     mtexColorbar
%     hold on
%     plot(ebsd_Gr_STR('PARTICLES'),'coordinates','off'); hold on
    % + + + + + + + + + + + + + + + 
%     figure
%     ipfKey = ipfHSVKey(ebsd_Gr_STR('Aluminium'));
%     color = ipfKey.orientation2color(ebsd_Gr_STR('Aluminium').orientations);
%     plot(ebsd_Gr_STR('Aluminium'),color, 'micronbar','off'); hold on
%     ebsd_Gr_STR('PARTICLES').color = [0 0 0];
%     plot(ebsd_Gr_STR('PARTICLES'),'coordinates','off'); hold on
%     plot(grains.boundary,'color','k','linewidth',1.5)
%     legend off
    % + + + + + + + + + + + + + + + 
    disp('+ + + + + + + + + + + + + + + ')
    GrainSizes_mtex_rset          = zeros(number_of_grains,1);
    numNeighbors_mtex_rset        = zeros(number_of_grains,1);
    equivalentRadius_mtex_rset    = zeros(number_of_grains,1);
    equivalentPerimeter_mtex_rset = zeros(number_of_grains,1);
    ShapeFactor_mtex_rset         = zeros(number_of_grains,1);
    AspectRatio_mtex_rset         = zeros(number_of_grains,1);
    for graincount = 1:size(grains,1)
        GrainSizes_mtex_rset(graincount)          = grains(graincount).grainSize;
        numNeighbors_mtex_rset(graincount)        = grains(graincount).numNeighbors;
        equivalentRadius_mtex_rset(graincount)    = grains(graincount).equivalentRadius;
        equivalentPerimeter_mtex_rset(graincount) = grains(graincount).equivalentPerimeter;
        ShapeFactor_mtex_rset(graincount)         = grains(graincount).shapeFactor;
        AspectRatio_mtex_rset(graincount)         = grains(graincount).aspectRatio;
        if mod(graincount,100)==0
            fprintf(['Extracting Grain Structure Data. Grain #- ' num2str(graincount) '\n'])
        end
        if graincount==size(grains,1)
            fprintf(['Extracting Grain Structure Data. Grain #- ' num2str(graincount) '\n'])
        end
    end
    GrainSizes_mtex{rset,1}          = GrainSizes_mtex_rset;
    numNeighbors_mtex{rset,1}        = numNeighbors_mtex_rset;
    equivalentRadius_mtex{rset,1}    = equivalentRadius_mtex_rset;
    equivalentPerimeter_mtex{rset,1} = equivalentPerimeter_mtex_rset;
    ShapeFactor_mtex{rset,1}         = ShapeFactor_mtex_rset;
    AspectRatio_mtex{rset,1}         = AspectRatio_mtex_rset;
    % + + + + + + + + + + + + + + + 
    % + + + + + + + + + + + + + + + 
    %---------------------------------------------------------
    %---------------------------------------------------------
    %---------------------------------------------------------
    %---------------------------------------------------------
end