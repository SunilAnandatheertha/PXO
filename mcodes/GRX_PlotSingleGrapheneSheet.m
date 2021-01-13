function [varargout] = GRX_PlotSingleGrapheneSheet(varargin)
%  THIS FUNCTION PLOTS THE SINGLE GRAPHENE SHEET
% VERSION 1.00 STARTED ON 14-01-2014

% varargin{1} -- 's'. To know whether being used...
%                                in static situation or dynamic situation.
% varargin{2} -- cov_gra_appended
% varargin{3} -- vd1_gra_appended
% varargin{4} -- vd2_gra_appended
% varargin{5} -- 'CovYes' or 'CovNo'
% varargin{6} -- 'Vd1Yes' or 'Vd1No'
% varargin{7} -- 'Vd2Yes' or 'Vd2No'
% varargin{8} -- 'AtomYes' or 'AtomNo'

StaticOrDynamic  = varargin{1};
cov_gra_appended = varargin{2};
vd1_gra_appended = varargin{3};
vd2_gra_appended = varargin{4};
PlotCovYesNo     = varargin{5};
PlotVd1YesNo     = varargin{6};
PlotVd2YesNo     = varargin{7};
PlotAtomYesNo    = varargin{8};

switch StaticOrDynamic
    case 's' % STATIC
        set(0, 'DefaultFigureWindowStyle', 'docked')
        fh1 = figure;
        hold on
        PlotAtomsMust = 0; % This becomes TRUE only if any of the other grx are not processed
        if strcmp(PlotCovYesNo,'CovYes')
            for count = 1:size(cov_gra_appended,1)
                % cov_gra = [ct1 ct2 xsgs(ct1) ysgs(ct1) xsgs(ct2) ysgs(ct2)];
                plot3([cov_gra_appended(count,3) cov_gra_appended(count,6)],...
                      [cov_gra_appended(count,4) cov_gra_appended(count,7)],...
                      [cov_gra_appended(count,5) cov_gra_appended(count,8)],'k')
            end
        end
        if strcmp(PlotVd1YesNo,'Vd1Yes')
            for count = 1:size(vd1_gra_appended,1)
                % cov_gra = [ct1 ct2 xsgs(ct1) ysgs(ct1) xsgs(ct2) ysgs(ct2)];
                plot3([vd1_gra_appended(count,3) vd1_gra_appended(count,6)],...
                      [vd1_gra_appended(count,4) vd1_gra_appended(count,7)],...
                      [vd1_gra_appended(count,5) vd1_gra_appended(count,8)],'k')
            end
        end
        if strcmp(PlotVd2YesNo,'Vd2Yes')
            for count = 1:size(vd2_gra_appended,1)
                % cov_gra = [ct1 ct2 xsgs(ct1) ysgs(ct1) xsgs(ct2) ysgs(ct2)];
                plot3([vd2_gra_appended(count,3) vd2_gra_appended(count,6)],...
                      [vd2_gra_appended(count,4) vd2_gra_appended(count,7)],...
                      [vd2_gra_appended(count,5) vd2_gra_appended(count,8)],'k')
            end
        end
    case 'd' % DYNAMIC, like in say, middle of Molecular Dynamics simulation
end

end