function CONSOLE_MESSAGE_DISPLAY(IDENTIFIER,  varargin)
% ------------------------------------------------------------------------------------
% ------------------------------------------------------------------------------------
% THIS FUNCTION IS NO LONGER USED..
% USE SCMD(..) INSTEAD... 
% REPLACE ALL EXIXTING INSTANCES OF USAGE OF CONSOLE_MESSAGE_DISPLAY(..)( WITH SCMD(..)
% ------------------------------------------------------------------------------------
% ------------------------------------------------------------------------------------
devFN  = 's u n i l';                   % developer first name
devLN  = 'a n a n d a t h e e r t h a'; % developer last name
smsVER = '2.01';                        % CURRENT VERSION OF sms
switch IDENTIFIER
    case 'misc'
        switch varargin{1}
            case 'PressToConti'
                disp('Press any key to continue..'); pause
        end
    case 'WelcomeWish'
        VD = clock;
        if VD(4) >= 4 && VD(4) < 12 % According to indian system
            wish = 'Good Morning';
        elseif VD(4) >= 12 && VD(4) < 15
            wish = 'Good Noon';
        elseif VD(4) >= 15 && VD(4) < 4
            wish = 'Good evening';
        else
            wish = '';
        end
        CONSOLE_MESSAGE_DISPLAY('seperator','type03',6,2)
        fprintf('%s    %s    %s\n', wish, devFN, devLN)
        if VD(4) >= 6 && VD(4) <= 8
            fprintf('You are early today\n')
            fprintf('Have a great day %s\n', devFN)
        elseif VD(4) >= 23 && VD(4) < 4
            fprintf('Go get some rest %s. Its late hours\n', devFN)
        end
        CONSOLE_MESSAGE_DISPLAY('seperator','type04',6,2);
        pause(0.10)
        fprintf('samaya: %2.2f muhurta :--: %3.2f laghu   :--: %2.2f kshaNa \n', VD(4)*(30/24), VD(5)*(15/1.6), VD(6)*(5/6.4))
        fprintf('Time:   %d    hours   :--: %d     minutes :--: %2.0f    seconds \n', VD(4), VD(5), VD(6))
        CONSOLE_MESSAGE_DISPLAY('seperator','type02',6,2);
        pause(0.10)
    case 'FINFO.SMS'
        disp(   'SMS             :: Saraswati Mech Solver')
        fprintf('Current version :: %s \n', smsVER)
        %CONSOLE_MESSAGE_DISPLAY('seperator','type02',2,1)
        devFNtemp = devFN;
        devLNtemp = devLN;
        devFNtemp(ismember(devFNtemp,' '))=[]; % REMOVE WHITE SPACES
        devLNtemp(ismember(devLNtemp,' '))=[]; % REMOVE WHITE SPACES
        fprintf('DEVELOPER       :: %s %s\n', strcat(upper(devFNtemp(1)),devFNtemp(2:numel(devFNtemp))),...
                                              strcat(upper(devLNtemp(1)),devLNtemp(2:numel(devLNtemp))))
        %disp('Use --> finf( `dev` ) for: about developer')
        %disp('INPUTS: simulation to be performed')
        %disp('OUTPUTS: will be written to disk')
        CONSOLE_MESSAGE_DISPLAY('seperator','type02',6,2)
    case 'FINFO.DEV'
        if exist(strcat(pwd,'\devinfo.txt'),'file')==2
            FileID = fopen(strcat(pwd,'\devinfo.txt'));
            devinfo = textscan(FileID,'%s','whitespace','\n');
            for count = 1:size(devinfo,1)
                disp(devinfo{count,1})
            end
        else
            disp('The developer information file inexists..')
        end
        CONSOLE_MESSAGE_DISPLAY('seperator','type02',5,2)
    case 'seperator'
        % ex. usages:
        % CONSOLE_MESSAGE_DISPLAY('seperator')
        % CONSOLE_MESSAGE_DISPLAY('seperator','type01')
        % CONSOLE_MESSAGE_DISPLAY('seperator','type02',4)
        % CONSOLE_MESSAGE_DISPLAY('seperator','type01',5,3)
        if numel(varargin) == 0
            UnitSepString = '8--8--8--8';
        elseif numel(varargin) > 0
            switch varargin{1}
                case 'type01'
                    UnitSepString = '--8--8--8';
                case 'type02'
                    UnitSepString = '----------';
                case 'type03'
                    UnitSepString = '\\\\\\\\\\';
                case 'type04'
                    UnitSepString = '//////////';
                case 'type05'
                    UnitSepString = '--0--0--0';
                case 'type06'
                    UnitSepString = '--01--01--01';
                case 'type07'
                    UnitSepString = '**********';
                case 'type08'
                    UnitSepString = '--*--*--*';
                case 'type09'
                    UnitSepString = '-*-|-*-|-*-|';
            end
        end
        SepString = [];
        if numel(varargin) == 0 || numel(varargin) == 1
            for count = 1:4
                SepString = strcat(SepString,UnitSepString);
            end
        elseif numel(varargin) > 1
            Repetions = floor(varargin{2});
            for count = 1:Repetions
                SepString = strcat(SepString,UnitSepString);
            end
        end
        if numel(varargin) == 3
            Repetitions = floor(varargin{3});
        elseif numel(varargin) < 3
            Repetitions = 1;
        end
        for count = 1:Repetitions
            disp(SepString)
        end
    case 'AGG.G1'
        EastMsg = 'G1:: m, n, l(nm) & vdd (%) are -- ';
        WestMsg = [];
        for count = 1:numel(varargin)
            [WestMsg] = CustomConcatenate(WestMsg, num2str(varargin{1, count}));
        end
        disp(strcat(EastMsg,WestMsg))
        %\\\\\\\\\\\\\\\\\\\\\\\\
        %\\\\\\\\\\\\\\\\\\\\\\\\
    case 'AGG.G1.P1'
        EastMsg = 'NANOC -- Reinf & Matrix are ::';
        % This fo loop automatically appends the display message as required
        for count = 1:numel(varargin)
            if count == 1
                WestMsg = strcat(varargin{1, 1});
            else
                [WestMsg] = CustomConcatenate(WestMsg, varargin{1, 2});
            end
        end
        disp(strcat(EastMsg, WestMsg))
        %\\\\\\\\\\\\\\\\\\\\\\\\
        %\\\\\\\\\\\\\\\\\\\\\\\\
    case 'AGG.Gn.P1'
        EastMsg = 'NANOC -- Reinf & Matrix are ::';
        % This for loop automatically appends the display message as required
        for count = 1:numel(varargin)
            if count == 1
                WestMsg = strcat(varargin{1, 1});
            else
                [WestMsg] = CustomConcatenate(WestMsg, varargin{1, 2}); % SUB-FUNCTIONAL CALL
            end
        end
        disp(strcat(EastMsg, WestMsg))
        %\\\\\\\\\\\\\\\\\\\\\\\\
        %\\\\\\\\\\\\\\\\\\\\\\\\
    case 'MatrixDateWriteFormat'
        WriteToDisk         = varargin{1,1};
        if WriteToDisk == 1
            WriteForMATLAB  = varargin{1,2};
            WriteForFORTRAN = varargin{1,3};
            WriteForC       = varargin{1,4};
            if WriteForMATLAB + WriteForFORTRAN + WriteForC ~= 0
                WriteInTheseFormats = [WriteForMATLAB WriteForFORTRAN WriteForC];
                TEMP = cell(1,3);   TEMP{1,1} = 'WriteForMATLAB';
                                    TEMP{1,2} = 'WriteForFORTRAN';
                                    TEMP{1,3} = 'WriteForC';
                EastMsg = 'Data write formats:';
                WestMsg = '';
                for count = 1:numel(WriteInTheseFormats)
                    if WriteInTheseFormats(count) == 1
                        WestMsg = CustomConcatenate(WestMsg, TEMP{1,count}); % SUB-FUNCTIONAL CALL
                    end
                end
                disp(strcat(EastMsg,WestMsg))
            else
                % DO NOTHING. END THIS FUNCTION CALL
            end
        else
            % DO NOTHING. END THIS FUNCTION CALL
        end
        % \\\\\\\\\\\\\\\\\\\\\\\\
        % \\\\\\\\\\\\\\\\\\\\\\\\
end
%     F U N C T I O N     E N D
end
%\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
%\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
%     S U B - F U N C T I O N     C A L L
function [WestMsg] = CustomConcatenate(WestMsg, varargin)
% THIS FUNCTION CONCATENATES THE DIFFERENT PARTS OF A MESSAGE

WestMsg = strcat(WestMsg, '..<-&->..', varargin{1,1});
end
%\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
%\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\