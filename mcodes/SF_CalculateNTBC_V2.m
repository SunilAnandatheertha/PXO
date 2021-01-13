function [varargout] = SF_CalculateNTBC_V2(varargin)


% THUIS FUNCTION FINDS OUT WHICH NODES ARE TO BE LOADDED 

% [NTBC] = SF_CalculateNTBC_V2(NODALCONSTRAIN_OPTION, NNNCM); -- < VERSION 2


[NTBC]  = SF_CalculateNTBC_V2({NODALCONSTRAIN_OPTION, NODALDISP_OPTION, NODALLOADING_OPTION}, NNNCM); % Find the NODES TO BE CONSTRAINED

NODALCONSTRAIN_OPTION = varargin{1}{1};
NODALDISP_OPTION      = varargin{1}{2};
NODALLOADING_OPTION   = varargin{1}{3};

NNNCM                 = varargin{2};

NODALCONSTRAIN_OPTION      = 'yminend.FullyConstrained'; % RED   COLOR SQUARES
NODALLOADING_OPTION        = 'ymaxend.Loaded';           % GREEN COLOR SQUARES
NODALDISP_OPTION           = 'ymaxend.Displaced';        % GREEN COLOR SQUARES


switch NODALCONSTRAIN_OPTION
    case 'yminend.FullyConstrained'
        % Task is to find all nodes in the ymin end and constrain them
        if strcmp(NODALLOADING_OPTION, 'yminend.Loaded') == 1
        end
        temp = NNNCM(:,3);
        NTBC = find(temp==min(NNNCM(:,3))); % Nodes to be constrained
    case 'ymaxend.FullyConstrained'
        % Task is to find all nodes in the ymin end and constrain them
        temp = NNNCM(:,3);
        NTBC = find(temp==max(NNNCM(:,3)));
    case 'xminend.FullyConstrained'
        % Task is to find all nodes in the xmin end and constrain them
        temp = NNNCM(:,2);
        NTBC = find(temp==min(NNNCM(:,2)));
    case 'xmaxend.FullyConstrained'
        % Task is to find all nodes in the xmax end and constrain them
        temp = NNNCM(:,2);
        NTBC = find(temp==max(NNNCM(:,2)));
end

varargout{1} = NTBC;
end