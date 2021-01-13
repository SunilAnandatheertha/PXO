function [varargout] = SFEA(varargin)


switch varargin{1}
    case 'basic'
        sfea2('basic','FEANL1DB')
    case 'a'
        switch varargin{2}
            case 'g1'
                
            case 'gn'
        end
end

end