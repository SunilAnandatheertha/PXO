function [Temporal_Phase_Texture, Number_of_Phases, Phase_SymmDetails, PhaseDetails__for__TEX] = Map__TEX__GRST(GrainData_Matrix_0, Number_of_grains, PHASE, GS)
% [----] = Map__TEX__GRST(-----)
% Internal function calls: (1) EXT: Calculate_TEXTURE
% todo_A [08-09-20]-[08-09-20]: Use set(0,'DefaultFigureWindowStyle','default') at start
%---------------------------------------------------------------------
set(0,'DefaultFigureWindowStyle','normal')
%---------------------------------------------------------------------
min_slice     = min(GrainData_Matrix_0(:,1));
max_slice     = max(GrainData_Matrix_0(:,1));
NoTimeSlices  = numel(min_slice:max_slice);
%---------------------------------------------------------------------
Temporal_Phase_ProcessingDetails = {{PHASE.ProcessingParameters.Process};
                                    {PHASE.ProcessingParameters.Temperature};
                                    {PHASE.ProcessingParameters.Shape};
                                    {PHASE.ProcessingParameters.Reduction}};
Temporal_Phase_TCname            = cell(NoTimeSlices,1);
Temporal_Phase_TCpresence        = cell(NoTimeSlices,1);
Temporal_Phase_TCEulerAngles     = cell(NoTimeSlices,1);
Temporal_Phase_halfwidths        = cell(NoTimeSlices,1);
Temporal_Phase_IntMat            = cell(NoTimeSlices,1);
Temporal_Phase_Resolution        = cell(NoTimeSlices,1);
Temporal_Phase_SymmDetails       = cell(NoTimeSlices,1);
Temporal_Phase_Texture           = cell(NoTimeSlices,1);
%---------------------------------------------------------------------
for TimeSlice = min_slice:max_slice
    Phase_SymmDetails   = cell(PHASE.Num_Phases,1);
    Phase_TCname        = cell(PHASE.Num_Phases,1);
    Phase_TCpresence    = cell(PHASE.Num_Phases,1);
    Phase_TCEulerAngles = cell(PHASE.Num_Phases,1);
    Phase_halfwidths    = cell(PHASE.Num_Phases,1);
    Phase_IntMat        = cell(PHASE.Num_Phases,1);
    Phase_Resolution    = cell(PHASE.Num_Phases,1);
    Phase_Texture       = cell(PHASE.Num_Phases,1);
    %---------------------------------------------------------------------
    switch PHASE.ProcessingParameters.Process
        case 'extruded'
            Number_of_Phases = PHASE.Num_Phases;
            for Phase_count = Number_of_Phases
                if Phase_count == 1
                    
                    Phase_SymmDetails{Phase_count, 1}    = cell(4,1);
                    Phase_SymmDetails{Phase_count, 1}{1} = PHASE.Ph_01.PhaseInformation.Composition;
                    Phase_SymmDetails{Phase_count, 1}{2} = PHASE.Ph_01.PhaseInformation.XTalSymm;
                    Phase_SymmDetails{Phase_count, 1}{3} = PHASE.Ph_01.PhaseInformation.SpecimenSymm;
                    Phase_SymmDetails{Phase_count, 1}{4} = PHASE.Ph_01.PhaseInformation.VolumeFraction;
                    %---------------------------------------------------------------------
                    Phase_TCname{Phase_count, 1}        = cell(size(PHASE.Ph_01.TEX_Model.Comp__Name_Consider_GHW_fg_res));
                    Phase_TCpresence{Phase_count, 1}    = zeros(size(PHASE.Ph_01.TEX_Model.Comp__Name_Consider_GHW_fg_res));
                    Phase_TCEulerAngles{Phase_count, 1} = zeros(size(PHASE.Ph_01.TEX_Model.Comp__Name_Consider_GHW_fg_res,1),3);
                    Phase_halfwidths{Phase_count, 1}    = zeros(size(PHASE.Ph_01.TEX_Model.Comp__Name_Consider_GHW_fg_res));
                    Phase_IntMat{Phase_count, 1}        = zeros(size(PHASE.Ph_01.TEX_Model.Comp__Name_Consider_GHW_fg_res));
                    Phase_Resolution{Phase_count, 1}    = zeros(size(PHASE.Ph_01.TEX_Model.Comp__Name_Consider_GHW_fg_res));
                    %---------------------------------------------------------------------
                    for TCcount = 1:numel(PHASE.Ph_01.TEX_Model.Comp__Name_Consider_GHW_fg_res)
                        Phase_TCname{Phase_count, 1}{TCcount,1}        = PHASE.Ph_01.TEX_Model.Comp__Name_Consider_GHW_fg_res{TCcount}{1};
                        Phase_TCpresence{Phase_count, 1}(TCcount)      = PHASE.Ph_01.TEX_Model.Comp__Name_Consider_GHW_fg_res{TCcount}{2};
                        Phase_TCEulerAngles{Phase_count, 1}(TCcount,:) = PHASE.Ph_01.TEX_Model.Comp__Name_Consider_GHW_fg_res{TCcount}{3};
                        Phase_halfwidths{Phase_count, 1}(TCcount)      = PHASE.Ph_01.TEX_Model.Comp__Name_Consider_GHW_fg_res{TCcount}{4};
                        Phase_IntMat{Phase_count, 1}(TCcount)          = PHASE.Ph_01.TEX_Model.Comp__Name_Consider_GHW_fg_res{TCcount}{5};
                        Phase_Resolution{Phase_count, 1}(TCcount)      = PHASE.Ph_01.TEX_Model.Comp__Name_Consider_GHW_fg_res{TCcount}{6};
                    end
                    %---------------------------------------------------------------------
                    PhaseDetails__for__TEX = {Phase_TCname,...
                                              Phase_TCpresence,...
                                              Phase_TCEulerAngles,...
                                              Phase_halfwidths,...
                                              Phase_IntMat,...
                                              Phase_Resolution};
                    %---------------------------------------------------------------------
                    [This_Phase__TEXTURE]         = Calculate_TEXTURE(Number_of_Phases, Number_of_grains, TimeSlice, Phase_SymmDetails, PhaseDetails__for__TEX);
                    Phase_Texture{Phase_count, 1} = This_Phase__TEXTURE;
                    %---------------------------------------------------------------------
                elseif Phase_count == 2
                end
            end
        case 'rolled'
            % To do
        case 'forged'
            % To do
    end
    Temporal_Phase_TCname{TimeSlice,1}        = Phase_TCname;
    Temporal_Phase_TCpresence{TimeSlice,1}    = Phase_TCpresence;
    Temporal_Phase_TCEulerAngles{TimeSlice,1} = Phase_TCEulerAngles;
    Temporal_Phase_halfwidths{TimeSlice,1}    = Phase_halfwidths;
    Temporal_Phase_IntMat{TimeSlice,1}        = Phase_IntMat;
    Temporal_Phase_Resolution{TimeSlice,1}    = Phase_Resolution;
    Temporal_Phase_SymmDetails{TimeSlice,1}   = Phase_SymmDetails;
    Temporal_Phase_Texture{TimeSlice,1}       = Phase_Texture;
end
end


