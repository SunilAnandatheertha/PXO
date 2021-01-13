function FINFO(varargin)
% finfo:: function information
% 8--8--8--8--8--8--8--8--8--8--8--8
if nargin == 0
    FINFO('SMS')
elseif nargin > 0
    switch varargin{1}
            %-------------------------------------------
            % START OF 0TH LEVEL PROGRAMS
            %-------------------------------------------
        case 'SMS'
            clc
            pause(0.25)
            CONSOLE_MESSAGE_DISPLAY('WelcomeWish')
            CONSOLE_MESSAGE_DISPLAY('FINFO.SMS')
        case 'DEV'
            CONSOLE_MESSAGE_DISPLAY('FINFO.DEV')
            %-------------------------------------------
            % START OF 1ST LEVEL PROGRAMS
            %-------------------------------------------
        case 'SMC'
        case 'SFEA'
        case 'SMD'
        case 'AGG'
        case 'SRV'
            %-------------------------------------------
            % START OF 2ND LEVEL PROGRAMS
            %-------------------------------------------
        case 'smc2'
        case 'smc3'
        case 'sfea2'
        case 'sfea3'
            %-------------------------------------------
            % START OF 3ND LEVEL PROGRAMS
            %-------------------------------------------
    end
end
% 8--8--8--8--8--8--8--8--8--8--8--8
end