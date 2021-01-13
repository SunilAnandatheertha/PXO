function STODO(varargin)
% STODO - Sms TO DO

switch varargin{1}
    case {'proj','p'}
        switch varargin{2}
            case {'f','fem'}
                switch varargin{3}
                    case {'mar', 'march'}
                        disp('01. Include torsional spring')
                        disp('02. ')
                    case {'apr', 'april'}
                    case {'may'}
                    case {'jun', 'june'}
                end
            case {'s', 'sa'}
                switch varargin{3}
                    case {'mar', 'march'}
                    case {'apr', 'april'}
                    case {'may'}
                    case {'jun', 'june'}
                end
            case {'a', 'analytical'}
                switch varargin{3}
                    case {'mar', 'march'}
                    case {'apr', 'april'}
                    case {'may'}
                    case {'jun', 'june'}
                end
            case {'r', 'report'}
                switch varargin{3}
                    case {'mar', 'march'}
                    case {'apr', 'april'}
                    case {'may'}
                    case {'jun', 'june'}
                end
            case {'jp', 'journalpaper'}
                switch varargin{3}
                    case {'mar', 'march'}
                    case {'apr', 'april'}
                    case {'may'}
                    case {'jun', 'june'}
                end
            case {'cp', 'conferencepaper'}
                switch varargin{3}
                    case {'mar', 'march'}
                    case {'apr', 'april'}
                    case {'may'}
                    case {'jun', 'june'}
                end
        end
end

end