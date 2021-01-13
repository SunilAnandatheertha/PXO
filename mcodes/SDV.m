function [varargout] = SDV(varargin)
% SDV:: SMS DEFAULT VALUES
% A function which returns default values

switch varargin{1}
    case 'agg'
        switch varargin{2}
            case 'g1'
                LAYUP = [4 0 2 2];
                WARP   = 'WarpNo';
                WARPFN = 'NONE'; % WARPING FUNCTION: WF
                XPERT  = 'xPerturbNo';
                YPERT  = 'yPerturbNo';
                WTD    = 1; % DEFAULT VALUE -- MUST BE WRITTEN TO DISK !! DO NOT CHANGE
                varargout{1} = LAYUP;
                varargout{2} = WARP;
                varargout{3} = WARPFN;
                varargout{4} = XPERT;
                varargout{5} = YPERT;
                varargout{6} = WTD;
                % USAGE: 
                % [LAYUP, WARP, WARPFN, XPERT, YPERT, WTD] = SDV('agg', 'g1');
            case 'g1.wf' % Warping Function
                WARPFN = 'trig03';
                varargout{1} = WARPFN;
            case 'g1.layup' % Warping Function
                LAYUP = [5 0 2 2];
                varargout{1} = LAYUP;
            case 'gn.def'
                ReadFromFile = 'RFFNo';
                GrapheneStackLayUp = [10 0 2.0000 floor(rand*10);
                                      10 0 2.0000 floor(rand*10);
                                      10 0 2.0000 floor(rand*10);
                                      10 0 2.0000 floor(rand*10);
                                      10 0 2.0000 floor(rand*10);
                                      10 0 2.0000 floor(rand*10);];
                SortYourLayUp = 'SortNo';
                varargout{1} = ReadFromFile;
                varargout{2} = GrapheneStackLayUp;
                varargout{3} = SortYourLayUp;
            case 'c1'
            case 'cn'
        end
end

end