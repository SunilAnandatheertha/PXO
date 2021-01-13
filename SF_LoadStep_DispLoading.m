function [varargout] = SF_LoadStep_DispLoading(varargin)

% CALCULATING THE DISPLACEMENT LOADING PATTERN FOR LOAD STEPS
% AUTHOR: SUNIL ANANDATHEERTHA (sunilanandatheertha@gmail.com)
% THIS FUNCTION WAS CREATED ON 27.02.2014.

NatureOfDispLoading = varargin{2};
LS                  = varargin{3};

switch NatureOfDispLoading{1}
    case {'constant', 'cont', 'c'}
        NdDispLOADING = NatureOfDispLoading{2} * ones(LS,1);
    case {'linearincreasing', 'li'}
        if LS > 1
            StartDispLoad = min([NatureOfDispLoading{2} NatureOfDispLoading{3}]);
            EndDispLoad   = max([NatureOfDispLoading{2} NatureOfDispLoading{3}]);
            NdDispLOADING = linspace(StartDispLoad, EndDispLoad, LS)';
        else
            NdDispLOADING = NatureOfDispLoading{2};
        end
    case {'lineardecreasing','ld'}
        if LS > 1
            StartDispLoad = max([NatureOfDispLoading{2} NatureOfDispLoading{3}]);
            EndDispLoad   = min([NatureOfDispLoading{2} NatureOfDispLoading{3}]);
            NdDispLOADING = linspace(StartDispLoad, EndDispLoad, LS)';
        else
            NdDispLOADING = NatureOfDispLoading{2};
        end
    case {'random', 'rand'}
        NdDispLOADING = NatureOfDispLoading{2} * rand(LS,1);
end

varargout{1} = NdDispLOADING;

end