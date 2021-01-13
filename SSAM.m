function [varargout] = SSAM(varargin)
% SSAM :: SMS SIMULATED ANNEALING OF MICROSTRUCTURE

% USE:: SSAM()
%       SSAM('2d')
%       SSAM('2d','post')
if nargin == 0
    SSAM('2d'); % <--<< CALL SELF : to start defaulr simulation
    %-----------------------------------------------------------
elseif nargin == 1
    switch varargin{1}
        case '2d'
            smc2(1);
        case '3d'
            smc3();
    end
    %-----------------------------------------------------------
elseif nargin > 1
    switch varargin{1}
        case '2d'
            % VALUES PASSED from 'SSAM' to 'smc2':
               % varargin{1} of SSAM                           :: '2d'
               % varargin{2} of SSAM   =   varargin{1} of smc2 :: 'PostProcessYes' or 'PostProcessNo'
               % varargin{3} of SSAM   =   varargin{2} of SSAM :: NumberOfTrials
            smc2(varargin{2}, varargin{3})
        case '3d'
    end
    %-----------------------------------------------------------
end

end
%-----------------------------------------------------------