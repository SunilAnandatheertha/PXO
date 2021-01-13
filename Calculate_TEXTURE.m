function [This_Phase__TEXTURE] = Calculate_TEXTURE(Number_of_Phases, Number_of_grains, TimeSlice, Phase_SymmDetails, PhaseDetails__for__TEX)

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
    %---------------------------------------------------------------------
    % Make MTex Orientations
    for TC_ORI_count = 1:Num_TC_Non_Zero_Presence
        TC__nth = TC_Non_Zero_Presence(TC_ORI_count);
        phi_1   = Phase_TCEulerAngles{np}(TC__nth, 1);
        psi     = Phase_TCEulerAngles{np}(TC__nth, 2);
        phi_2   = Phase_TCEulerAngles{np}(TC__nth, 3);
        TC_MTex_Orientations{1,TC_ORI_count} = orientation('Euler', phi_1*degree, psi*degree, phi_2*degree,...
                                                           XTal__SYMM, Samp__SYMM);
    end
    %---------------------------------------------------------------------
    for TC_ORI_count = 1:Num_TC_Non_Zero_Presence
        TC__nth                         = TC_Non_Zero_Presence(TC_ORI_count);
        TC_MTex_UM_CODF{1,TC_ORI_count} = unimodalODF(TC_MTex_Orientations{1,TC_ORI_count},...
                                                      'halfwidth', Phase_halfwidths{np}(TC__nth, 1)*degree,...
                                                      'resolution',Phase_Resolution{np}(TC__nth, 1)*degree);
    end
    %---------------------------------------------------------------------
    for TC_ORI_count = 1:Num_TC_Non_Zero_Presence
        if TC_ORI_count == 1
            ODFunc = Phase_IntMat{np}(TC__nth, 1)*TC_MTex_UM_CODF{1,TC_ORI_count};
        else
            ODFunc = ODFunc + Phase_IntMat{np}(TC__nth, 1)*TC_MTex_UM_CODF{1,TC_ORI_count};
        end
    end
    %---------------------------------------------------------------------
    ODFuncmax = max(ODFunc);
    %---------------------------------------------------------------------
    h              = Miller({1,1,1}, XTal__SYMM, Samp__SYMM);
    ODFunc_PDF     = calcPDF(ODFunc,h);
    ODFunc_PDF_max = max(ODFunc_PDF);
    
%     plotPDF(ODFunc, h, 'COMPLETE', 'lower', 'contourf', linspace(1, ODFunc_PDF_max, 10), 'LineWidth',1, 'minmax', 'ShowText', 'off')
%     CLim(gcm, [1 ODFunc_PDF_max])
%     mtexColorMap LaboTeX
%     mtexColorbar
    %---------------------------------------------------------------------
    NoOri           = Number_of_grains{TimeSlice};
    Dstr_ROI        = ODFunc.calcOrientations(NoOri);
    Dstr_ROI_EA     = [Dstr_ROI.phi1 Dstr_ROI.Phi Dstr_ROI.phi2]*180/pi;
    Dstr_ROI_EA_ori = orientation('euler', Dstr_ROI_EA(:,1)*degree, Dstr_ROI_EA(:,2)*degree, Dstr_ROI_EA(:,3)*degree, XTal__SYMM);
    
    figure
    plotPDF(Dstr_ROI_EA_ori, Miller({1,1,1}, XTal__SYMM), 'points', NoOri, 'complete', 'upper',...
               'MarkerSize', 3, 'LineWidth', 1,...
               'markeredgecolor', 'none', 'MarkerFaceColor', 'k',...
               'alpha', 0.5);
    This_Phase__TEXTURE = {ODFunc, ODFuncmax, Dstr_ROI_EA};
    pause(0.1)
end

end