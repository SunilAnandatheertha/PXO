function [varargout] = SFABC(varargin)

% SFABC -- Sms Feam Apply boundary Conditions
% SUthor; sunil anandatheertha (sunilanandatheertha@gmail.com)
% created on: 23.02.2014
% [GSMae, Uae, Pae] = SFABC('sf',{''},{GSM, U, P});

switch varargin{1}
    case 'sf'
        switch varargin{2}{1}
            case 'NodalForce'
                switch varargin{2}{2}
                    case 'EliminateRC'
                        GSM = varargin{3}{1};
                        U   = varargin{3}{2};
                        P   = varargin{3}{3};
                        
                        % ELIMINATE ROWS and COLUMNS ---> in:
                        % global stiffness matrix
                        temp = find(U==0); % find all GDOF positoins which are fully constrauined
                        GSMae = GSM; % GSM a.fter e.limination
                        GSMae(:,temp) = [];
                        GSMae(temp,:) = [];
                        % displacemebt matrix
                        Uae = U; % U. a.fter e.limination
                        Uae(temp,:) = [];
                        % load matrix
                        Pae = P; % P. a.fter e.limination
                        Pae(temp,:) = [];

                        varargout{1} = GSMae;
                        varargout{2} = Uae;
                        varargout{3} = Pae;
                    case 'DoNotEliminateRC'
                        
                end
            case 'NodalDisp'
                switch varargin{2}{2}
                    case 'EliminateRC'
                        GSM = varargin{3}{1};
                        U   = varargin{3}{2};
                        P   = varargin{3}{3};
                        
                end
            case 'NodalForceAndNodalDisp'
        end
    case 'sfmd'
end

end