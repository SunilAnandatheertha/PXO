function [varargout] = SF_CalculateNTBC(varargin)

% THUIS FUNCTION FINDS OUT WHICH NODES ARE TO BE LOADDED 

% [NTBC] = SF_CalculateNTBC(NODALCONSTRAIN_OPTION, NNNCM);


NODALCONSTRAIN_OPTION = varargin{1};
NNNCM                 = varargin{2};

switch NODALCONSTRAIN_OPTION
    case 'yminend.Constrained'
        % Task is to find all nodes in the ymin end and constrain them
        temp = NNNCM(:,3);
        NTBC = find(temp==min(NNNCM(:,3))); % Nodes to be constrained
    case 'ymaxend.Constrained'
        % Task is to find all nodes in the ymin end and constrain them
        temp = NNNCM(:,3);
        NTBC = find(temp==max(NNNCM(:,3)));
    case 'xminend.Constrained'
        % Task is to find all nodes in the xmin end and constrain them
        temp = NNNCM(:,2);
        NTBC = find(temp==min(NNNCM(:,2)));
    case 'xmaxend.Constrained'
        % Task is to find all nodes in the xmax end and constrain them
        temp = NNNCM(:,2);
        NTBC = find(temp==max(NNNCM(:,2)));
end

varargout{1} = NTBC;
end