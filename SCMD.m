function SCMD(IDENTIFIER,  varargin)

devFN  = 's u n i l';                   % developer first name
devLN  = 'a n a n d a t h e e r t h a'; % developer last name
smsVER = '2.01';                        % CURRENT VERSION OF sms
switch IDENTIFIER
    case 'misc'
        switch varargin{1}
            case 'PressToConti'
                disp('Press any key to continue..'); pause
        end
    case 'sfeam.ag'
        switch varargin{1}
            case 'LoadStepStart'
                lscount = varargin{2};
                SCMD('seperator','type02',8,1);
                fprintf('                                                        Starting Load Step No. %d\n', lscount)
                SCMD('seperator','type02',8,1);
                disp(' ')
                disp(' ')
                disp(' ')
            case 'LoadStepEnd'
                lscount = varargin{3}{1};
                SCMD('seperator','type02',6,2);
                fprintf('                                   Finished Load Step No. %d\n', lscount)
                disp(' ')
            case 'DispG1Info'
                SCMD('seperator','type02',4,1);
                fprintf('GENERATING GRAPHENE GEOEMTRY [%d %d %d %d]\n',varargin{2}{1}, varargin{2}{2}, varargin{2}{3}, varargin{2}{4} )
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
        SCMD('seperator','type03',6,2)
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
        SCMD('seperator','type02',6,2);
        pause(0.10)
    case 'ssam.batch'
        switch varargin{1}
            case 'BatchNo'
                SCMD('seperator','type02',6,2);
                fprintf('ENTERING Batch Run. No. %d\n', varargin{2})
                SCMD('seperator','type02',6,2);
            case 'BatchFFMove'
                SCMD('seperator','type02',6,2);
                message = strcat('Moving results to "', pwd, '\Run', num2str(varargin{2}));
                fprintf('%s \n',message)
                SCMD('seperator','type02',6,2);
        end
    case 'ssam.pi'
        switch varargin{1}
            case 'simpar01'
                disp('BASIC SIMULATION PARAMETERS')
            case 'simpar02'
        end
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
                % DO NOTHING.
            end
        else
            % DO NOTHING.
        end
        % \\\\\\\\\\\\\\\\\\\\\\\\
        % \\\\\\\\\\\\\\\\\\\\\\\\
    case 'fi' % FUnction information
        switch varargin{1}
            case 'agg'   % usage: SCMD('fi','agg')
            case 'sfeam' % usage: SCMD('fi','sfeam')
            case 'ssam'  % usage: SCMD('fi','ssam')
        end
    case 'eu' % Example usages
        if nargin == 2 % NOTE: INCLUDING IDENTIFIER
        switch varargin{1}
            case 'g1' % usage :    SCMD('eu','g1')
                SCMD('seperator', 'type02', 8, 1)
                disp('E X A M P L E    U S A G E S---- FOR SINGLE GRAPHENE SHEET')
                disp(' format:   AGG(G1, s, [m n l vdd], wy, t4, xpy, ypn, 1)')
                SCMD('seperator', 'type03', 5, 1)
                disp('NOTE: ALL STRING & NULL ENTRIES MUST BE INSIDE single QUOTES ')
                SCMD('seperator', 'type02', 2, 1)
                disp('THROUGH: AGG')
                disp('01: AGG(G1,s,[10 0 3 2],wy,t4,xpy,ypn,1)');
                disp('02: AGG(G1,s,[5 0 2 2],wy,t3,xpy,,1)');
                disp('03: AGG(G1,s,[5 0 2 2],wy,t3,,,1)');
                disp('04: AGG(G1,s,[5 0 2 0],wy,,,'',1)');
                disp('05: AGG(G1,s,[5 0 2 2],wy,'',xpy,ypy,1)');
                disp('06: AGG(G1,s,[5 0 2 2],'','','','',1)');
                disp('07: AGG(G1,s,[5 0 2 2],'','',xpy,ypn,1)'); 
                    disp('        here eventhough perturbations are yes')
                    disp('        on x, it wont be considered since warping')
                    disp('        is not desired (indicated by')
                    disp('        in the place of WarpAtomicGeometry')
                disp('08: AGG(G1,s,'','','','','',1)');
                disp('09: AGG(G1,s,[5 0 3],'','','','',1)');
                SCMD('seperator', 'type02', 2, 1)
                disp('THROUGH: sms')
                disp(' HELP NOT WRITTEN YET')
                SCMD('seperator', 'type04', 5, 1)
                disp('ALL the ABOVE HAVE BEEN TESTED ON:')
                disp('         SMS. V. 2.01, as on 23 Jan 2014, 01:30 A.M')
                SCMD('seperator', 'type02', 8, 1)
            case 'gn'
                SCMD('seperator', 'type02', 8, 2)
                disp('E X A M P L E    U S A G E S---- FOR STACK OF GRAPHENE SHEETS')
                disp('AGG(Gn, RFFYes, STACKLAYUPSEQUENCE, LayerSort, WTD, ISSLim)')
                SCMD('seperator', 'type03', 5, 1)
                disp('NOTE: ALL STRING & NULL ENTRIES MUST BE INSIDE single QUOTES ')
                SCMD('seperator', 'type02', 2, 1)
                disp('AGG(Gn, RFFYes, [0 1 3], SortNo, 1, [0.30 0.34])')
                disp('AGG(Gn, RFFYes, [1 1 3], SortNo, 1, [0.30 0.34])')
                disp('AGG(Gn, RFFYes, [0 1 3 4], SortNo, 1, [0.30 0.34])')
                disp('AGG(Gn, RFFYes, [0 6 3 4], SortNo, 1, [0.30 0.34])')
                disp('AGG(Gn, RFFYes, [0 6 3 4], SortYes, 1, [0.30 0.34])')
                SCMD('seperator', 'type02', 8, 2)
        end
        else
            for count = 1:nargin-1
                SCMD('eu',varargin{count})
                if count < nargin-1
                    disp('PRESS A KEY TO CONTINUE')
                    pause()
                end
            end
        end
    case 'if' % Input Format
        if nargin == 2 % NOTE: Inlcuding IDENTIFIER !!
        switch varargin{1}
            case 'g1'  % usage :    SCMD('if','g1') 
                SCMD('seperator', 'type02', 8, 2)
                disp('I N P U T     F O R M A T---- FOR SINGLE GRAPHENE SHEET')
                disp(' AGG(G1, s, [m n l vdd], wy, t4, xpy, ypn, 1)')
                SCMD('seperator', 'type03', 5, 1)
                disp('        Where, ')
                disp('               G1  : use as it is. Represents single graphene sheet')
                disp('               s   : represents static. Use as it is')
                disp('               m   : 1st chiral index. Positive integer number input')
                disp('               n   : 2nd chiral index. Positive integer number input')
                disp('               l   : length factor. Positive real number input')
                disp('               vdd : vacancy defect density. Positive real number input')
                disp('               wy  : Warp yes. wn - warp no. even null entry works')
                disp('               t4  : warping function. even null entry works')
                disp('               xpy : x perturb yes. xpn - x perturb no. even null entry works')
                disp('               ypy : y perturb yes. ypn - y perturb no. even null entry works')
                disp('               WTD : Write To Disk. values - 1 (write) and 0 (dont write)')
                SCMD('seperator', 'type04', 5, 1)
                disp('Use :: SCMD("fi", FUNCION_NAME) to display Function Information')
                SCMD('seperator', 'type02', 8, 2)
            case 'gn'  % usage: SCMD('if','gn')
                SCMD('seperator', 'type02', 8, 2)
                disp('I N P U T     F O R M A T---- FOR A STACK OF GRAPHENE SHEETS')
                disp(' AGG(G1, s, [m n l vdd], wy, t4, xpy, ypn, 1)')
                SCMD('seperator', 'type03', 5, 1)
            case 'mc2'
        end
        else
            for count = 1:nargin-1
                SCMD('if',varargin{count})
                if count < nargin-1
                    disp('PRESS A KEY TO CONTINUE')
                    pause()
                end
            end
        end
end
%     F U N C T I O N     E N D
end
%\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
%\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
%     S U B - F U N C T I O N
function [WestMsg] = CustomConcatenate(WestMsg, varargin)
% THIS FUNCTION CONCATENATES THE DIFFERENT PARTS OF A MESSAGE

WestMsg = strcat(WestMsg, '..<-&->..', varargin{1,1});
end
%\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
%\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\