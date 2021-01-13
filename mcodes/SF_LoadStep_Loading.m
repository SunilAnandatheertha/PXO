function [varargout] = SF_LoadStep_Loading(varargin)
% CALCULATING THE LOADING PATTERN FOR LOAD STEPS
% AUTHOR: SUNIL ANANDATHEERTHA (sunilanandatheertha@gmail.com)
% THIS FUNCTION WAS CREATED ON 22.02.2014.

NatureOfLoading = varargin{1};
LS              = varargin{2};

switch NatureOfLoading{1}
    case {'constant', 'cont', 'c'}
        LOADING = NatureOfLoading{2} * ones(LS,1);
    case {'linearincreasing', 'li'}
        if LS > 1
            StartLoad = min([NatureOfLoading{2} NatureOfLoading{3}]);
            EndLoad   = max([NatureOfLoading{2} NatureOfLoading{3}]);
            LOADING = linspace(StartLoad, EndLoad, LS)';
        else
            LOADING = NatureOfLoading{2};
        end
    case {'lineardecreasing','ld'}
        if LS > 1
            StartLoad = max([NatureOfLoading{2} NatureOfLoading{3}]);
            EndLoad   = min([NatureOfLoading{2} NatureOfLoading{3}]);
            LOADING = linspace(StartLoad, EndLoad, LS)';
        else
            LOADING = NatureOfLoading{2};
        end
    case {'random', 'rand'}
        LOADING = NatureOfLoading{2} * rand(LS,1);
end

varargout{1} = LOADING;

end