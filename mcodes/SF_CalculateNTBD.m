function [varargout] = SF_CalculateNTBD(varargin)

% SF_CalculateNTBD: Sms Feam Claculate Nodes To Be Displaced

NODALDISP_OPTION = varargin{1};
NNNCM            = varargin{2};

switch NODALDISP_OPTION
    case 'yminend.Displaced'
        % Task is to find all nodes in the ymin end and constrain them
        temp = NNNCM(:,3);
        NTBD = find(temp==min(NNNCM(:,3))); % Nodes to be constrained
    case 'ymaxend.Displaced'
        % Task is to find all nodes in the ymin end and constrain them
        temp = NNNCM(:,3);
        NTBD = find(temp==max(NNNCM(:,3)));
    case 'xminend.Displaced'
        % Task is to find all nodes in the xmin end and constrain them
        temp = NNNCM(:,2);
        NTBD = find(temp==min(NNNCM(:,2)));
    case 'xmaxend.Displaced'
        % Task is to find all nodes in the xmax end and constrain them
        temp = NNNCM(:,2);
        NTBD = find(temp==max(NNNCM(:,2)));
end

varargout{1} = NTBD;

end