function [TEXTURE] = Map__TEX__GRST_BU(GrainData_Matrix_0, PHASE, GS)
%---------------------------------------------------------------------
min_slice = min(GrainData_Matrix_0(:,1));
max_slice = max(GrainData_Matrix_0(:,1));
NoSlices  = numel(min_slice:max_slice);
%---------------------------------------------------------------------
Phase_TCname            = cell(PHASE.Num_Phases,1);
Phase_TCpresence        = cell(PHASE.Num_Phases,1);
Phase_TCEulerAngles     = cell(PHASE.Num_Phases,1);
Phase_halfwidths        = cell(PHASE.Num_Phases,1);
Phase_IntMat            = cell(PHASE.Num_Phases,1);
Phase_Resolution        = cell(PHASE.Num_Phases,1);
Phase_SymmDetails       = cell(PHASE.Num_Phases,1);
%---------------------------------------------------------------------
switch PHASE.ProcessingParameters.Process
    case 'extruded'
        Phase_ProcessingDetails = {{PHASE.ProcessingParameters.Process};
                                   {PHASE.ProcessingParameters.Temperature};
                                   {PHASE.ProcessingParameters.Shape};
                                   {PHASE.ProcessingParameters.Reduction}};
        Number_of_Phases = PHASE.Num_Phases;
        for Phase_count = Number_of_Phases
            if Phase_count == 1
                
                Phase_SymmDetails{Phase_count}    = cell(4,1);
                Phase_SymmDetails{Phase_count}{1} = PHASE.Ph_01.PhaseInformation.Composition;
                Phase_SymmDetails{Phase_count}{2} = PHASE.Ph_01.PhaseInformation.XTalSymm;
                Phase_SymmDetails{Phase_count}{3} = PHASE.Ph_01.PhaseInformation.SpecimenSymm;
                Phase_SymmDetails{Phase_count}{4} = PHASE.Ph_01.PhaseInformation.VolumeFraction;
                
                Phase_TCname{Phase_count}        = cell(size(PHASE.Ph_01.TEX_Model.Comp__Name_Consider_GHW_fg_res));
                Phase_TCpresence{Phase_count}    = zeros(size(PHASE.Ph_01.TEX_Model.Comp__Name_Consider_GHW_fg_res));
                Phase_TCEulerAngles{Phase_count} = zeros(size(PHASE.Ph_01.TEX_Model.Comp__Name_Consider_GHW_fg_res,1),3);
                Phase_halfwidths{Phase_count}    = zeros(size(PHASE.Ph_01.TEX_Model.Comp__Name_Consider_GHW_fg_res));
                Phase_IntMat{Phase_count}        = zeros(size(PHASE.Ph_01.TEX_Model.Comp__Name_Consider_GHW_fg_res));
                Phase_Resolution{Phase_count}    = zeros(size(PHASE.Ph_01.TEX_Model.Comp__Name_Consider_GHW_fg_res));
                 
                for TCcount = 1:numel(PHASE.Ph_01.TEX_Model.Comp__Name_Consider_GHW_fg_res)
                    Phase_TCname{Phase_count}{TCcount,1}        = PHASE.Ph_01.TEX_Model.Comp__Name_Consider_GHW_fg_res{TCcount}{1};
                    Phase_TCpresence{Phase_count}(TCcount)      = PHASE.Ph_01.TEX_Model.Comp__Name_Consider_GHW_fg_res{TCcount}{2};
                    Phase_TCEulerAngles{Phase_count}(TCcount,:) = PHASE.Ph_01.TEX_Model.Comp__Name_Consider_GHW_fg_res{TCcount}{3};
                    Phase_halfwidths{Phase_count}(TCcount)      = PHASE.Ph_01.TEX_Model.Comp__Name_Consider_GHW_fg_res{TCcount}{4};
                    Phase_IntMat{Phase_count}(TCcount)          = PHASE.Ph_01.TEX_Model.Comp__Name_Consider_GHW_fg_res{TCcount}{5};
                    Phase_Resolution{Phase_count}(TCcount)      = PHASE.Ph_01.TEX_Model.Comp__Name_Consider_GHW_fg_res{TCcount}{6};
                end
            elseif Phase_count == 2
            end
        end
        PhaseDetails__for__TEX = {Phase_TCname,...
                                  Phase_TCpresence,...
                                  Phase_TCEulerAngles,...
                                  Phase_halfwidths,...
                                  Phase_IntMat,...
                                  Phase_Resolution};
        [TEXTURE] = Calculate_TEXTURE(Number_of_Phases, Phase_SymmDetails, PhaseDetails__for__TEX);
        
    case 'rolled'
        % To do
    case 'forged'
        % To do
end

end
%---------------------------------------------------------------------
function [TEXTURE] = Calculate_TEXTURE(Number_of_Phases, Phase_SymmDetails, PhaseDetails__for__TEX)

Phase_TCname        = PhaseDetails__for__TEX{1};
Phase_TCpresence    = PhaseDetails__for__TEX{2};
Phase_TCEulerAngles = PhaseDetails__for__TEX{3};
Phase_halfwidths    = PhaseDetails__for__TEX{4};
Phase_IntMat        = PhaseDetails__for__TEX{5};
Phase_Resolution    = PhaseDetails__for__TEX{6};

for np = 1:Number_of_Phases
    %---------------------------------------------------------------------
    XTal__SYMM = crystalSymmetry(Phase_SymmDetails{np}{2});
    Samp__SYMM = specimenSymmetry(Phase_SymmDetails{np}{3});
    %---------------------------------------------------------------------
    TC_Non_Zero_Presence     = find(Phase_TCpresence{np}~=0);
    Num_TC_Non_Zero_Presence = numel(TC_Non_Zero_Presence);
    TC_MTex_Orientations     = cell(1, Num_TC_Non_Zero_Presence);
    TC_MTex_UM_CODF          = cell(1, Num_TC_Non_Zero_Presence);
    % Make MTex Orientations
    for TC_ORI_count = 1:Num_TC_Non_Zero_Presence
        TC__nth = TC_Non_Zero_Presence(TC_ORI_count);
        phi_1   = Phase_TCEulerAngles{np}(TC__nth, 1);
        psi     = Phase_TCEulerAngles{np}(TC__nth, 2);
        phi_2   = Phase_TCEulerAngles{np}(TC__nth, 3);
        TC_MTex_Orientations{1,TC_ORI_count} = orientation('Euler', phi_1*degree, psi*degree, phi_2*degree,...
                                                           XTal__SYMM, Samp__SYMM);
    end
    
    for TC_ORI_count = 1:Num_TC_Non_Zero_Presence
        TC__nth                         = TC_Non_Zero_Presence(TC_ORI_count);
        TC_MTex_UM_CODF{1,TC_ORI_count} = unimodalODF(TC_MTex_Orientations{1,TC_ORI_count},...
                                                      'halfwidth', Phase_halfwidths{np}(TC__nth, 1)*degree,...
                                                      'resolution',Phase_Resolution{np}(TC__nth, 1)*degree);
    end
    for TC_ORI_count = 1:Num_TC_Non_Zero_Presence
        if TC_ORI_count == 1
            ODFunc = Phase_IntMat{np}(TC__nth, 1)*TC_MTex_UM_CODF{1,TC_ORI_count};
        else
            ODFunc = ODFunc + Phase_IntMat{np}(TC__nth, 1)*TC_MTex_UM_CODF{1,TC_ORI_count};
        end
    end
    %---------------------------------------------------------------------
    ODFuncmax = max(ODFunc);
    figure
    h = Miller({1,1,1}, XTal__SYMM, Samp__SYMM);
    ODFunc_PDF = calcPDF(ODFunc,h);
    ODFunc_PDF_max = max(ODFunc_PDF);
    plotPDF(ODFunc,h, 'COMPLETE', 'lower', 'contourf', linspace(1, ODFunc_PDF_max, 10), 'LineWidth',1, 'minmax', 'ShowText', 'off')
    CLim(gcm, [1 ODFunc_PDF_max])
    mtexColorMap LaboTeX
    mtexColorbar
    %---------------------------------------------------------------------
    NoOri = 64;
    Dstr_ROI = ODFunc.calcOrientations(NoOri);
    Dstr_ROI_EA     = [Dstr_ROI.phi1 Dstr_ROI.Phi Dstr_ROI.phi2]*180/pi;
    Dstr_ROI_EA_ori = orientation('euler', Dstr_ROI_EA(:,1)*degree, Dstr_ROI_EA(:,2)*degree, Dstr_ROI_EA(:,3)*degree, XTal__SYMM);
    
    figure
    plotPDF(Dstr_ROI_EA_ori, Miller({1,1,1}, XTal__SYMM), 'points', NoOri, 'complete', 'upper',...
               'MarkerSize', 3, 'LineWidth', 1,...
               'markeredgecolor', 'none', 'MarkerFaceColor', 'k',...
               'alpha', 0.5);
    TEXTURE = {ODFunc};
end

end