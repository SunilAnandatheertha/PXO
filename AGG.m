function [varargout] = AGG(varargin)

% ---------------------------------------------------------------------------
% REFER END FOR FUNCTION INFORMATION
% ---------------------------------------------------------------------------
% define CONTROL VARIABLE values
WriteToDisk      = 1; % 1, if data is to be written to disk, else 0
WriteForMATLAB   = 1; % 1, if data is to be written for use by MATLAB, else 0
WriteForFORTRAN  = 1; % 1, if data is to be written for use by FORTRAN, else 0
WriteForC        = 1; % 1, if data is to be written for use by C, else 0
%SCMD('MatrixDateWriteFormat', WriteToDisk, WriteForMATLAB, WriteForFORTRAN, WriteForC);
% ---------------------------------------------------------------------------

switch lower(varargin{1}{1})
    case 'g1'
        %--------------------------------------------------------------------
        % Example calls:
        % 01: AGG('G1','s',[10 0 3 2],'wy','t4','xpy','ypn',1);
        % 02: AGG('G1','s',[5 0 2 2],'wy','t3','xpy','',1);
        % 03: AGG('G1','s',[5 0 2 2],'wy','t3','','',1);
        % 04: AGG('G1','s',[5 0 2 0],'wy','','','',1);
        % 05: AGG('G1','s',[5 0 2 2],'wy','','xpy','ypy',1);
        % 06: AGG('G1','s',[5 0 2 2],'','','','',1);
        % 07: AGG('G1','s',[5 0 2 2],'','','xpy','ypn',1); % here eventhough perturbations are 'yes'
                             %  on x, it wont be considered since warping is not desired (indicated by '')
                             % in the place of 'WarpAtomicGeometry'
        % 08: AGG('G1','s','','','','','',1);
        % 09: AGG('G1','s',[5 0 3],'','','','',1);
        %--------------------------------------------------------------------
        % Example calls: FROM SMS
        % 01: 
        %--------------------------------------------------------------------
        if nargin <= 1
            StaticGrxOrDynamicGrx = 's';
            m = 2;
            n = 0;
            l = 2;
            vdd = 2;
            WTD = 1;
            WarpAtomicGeometry = 'wn';
            WarpFunction       = 't4';
            XPERT              = 'xpn';
            YPERT              = 'ypn';
            AGG('g1', StaticGrxOrDynamicGrx, [m n l vdd], WarpAtomicGeometry, WarpFunction,XPERT,YPERT,WTD);
        else
            AC = 2; % Argument count number. DONT CHANGE THIS
            StaticGrxOrDynamicGrx  = varargin{AC}; AC = AC + 1;    % VALUE -- 's' or 'd'. Here AC = 3
            %-----------------------------------
            %---- HANDLING 'lay up' INPUT
            if ischar(varargin{AC}) == 1
                disp('Taking default graphene Lay-up data')
                layuptemp = SDV('agg','g1.layup');
                m   = layuptemp(1); % 1ST CHIRAL INDEX
                n   = layuptemp(2); % 2ND CHIRAL INDEX
                l   = layuptemp(3); % GRAPHENE LENGTH
                vdd = layuptemp(4); % VACANCY DEFECT DENSITY
            else
                if numel(varargin{AC}) < 4 || numel(varargin{AC}) > 4
                    disp('The graphene sheet lay up parameters are incorrect')
                    disp('Using default values instead')
                    layuptemp = SDV('agg','g1.layup');
                    m   = layuptemp(1);
                    n   = layuptemp(2);
                    l   = layuptemp(3);
                    vdd = layuptemp(4);
                else
                    m   = varargin{AC}(1);
                    n   = varargin{AC}(2);
                    l   = varargin{AC}(3);
                    vdd = varargin{AC}(4);
                end
            end
            AC = AC + 1; % Here AC = 4
            %-----------------------------------
            
            
            
            %---- HANDLING 'WarpAtomicGeometry' INPUT
            WarpAtomicGeometry     = varargin{AC}; AC = AC + 1;    % VALUE: WarpYes or WarpNo % Here AC = 5
            if strcmp(WarpAtomicGeometry,'wy')==1
                WarpAtomicGeometry = 'WarpYes';
            elseif strcmp(WarpAtomicGeometry,'wn')==1
                WarpAtomicGeometry = 'WarpNo';
            end
            %-----------------------------------
            %---- HANDLING 'WarpFunction' INPUT
            DEFAULTWARPFN = SDV('agg','g1.wf'); % <<<------ D E F A U L T    W A R P   F U N C T I O N
            WarpFunction          = varargin{AC}; AC = AC + 1;    % VALUE: STRING: 'trig01' or 'trig05' or 'poly01' % Here AC = 6
            if numel(WarpFunction)==0
                WarpFunction = DEFAULTWARPFN;     % ASSIGN DEFAULT VALUE
            end
            if strcmp(WarpFunction(1),'t')==1     % TRIGNOMETRIC WARP FUNCTION
                if numel(WarpFunction) == 1
                    WarpFunction = DEFAULTWARPFN;    % ASSIGN DEFAULT VALUE
                elseif numel(WarpFunction)==2
                    if ischar(WarpFunction(2))==0
                        WarpFunction = DEFAULTWARPFN;
                    else
                        WarpFunction = strcat('trig','0',WarpFunction(2));
                    end
                elseif numel(WarpFunction)==3
                    if isnan(str2double(strcat(WarpFunction(2),WarpFunction(3))))==0
                        WarpFunction = strcat('trig',strcat(WarpFunction(2),WarpFunction(3)));
                    else
                        if isnan(str2double(WarpFunction(3)))==0
                            WarpFunction = strcat('trig','0',WarpFunction(3));
                        else
                            WarpFunction = DEFAULTWARPFN;
                        end
                    end
                elseif numel(WarpFunction) > 3
                    if isnan(str2double(strcat(WarpFunction(numel(WarpFunction)-1),WarpFunction(numel(WarpFunction)))))==0
                        WarpFunction = strcat('trig',strcat(WarpFunction(numel(WarpFunction)-1),WarpFunction(numel(WarpFunction))));
                    else
                        WarpFunction = DEFAULTWARPFN; % ASSIGN DEFAULT VALUE
                    end
                end
            elseif strcmp(WarpFunction(1),'p')==1 % POLYMOIAL WARP FUNCTOPN
                % handle polynominal inpujts here
            else
                WarpAtomicGeometry = 'WarpNo';
            end
            %-----------------------------------
            % input handling for XPerturbation
            XPERT      = varargin{AC}; AC = AC + 1;    % VALUE: STRING: 'xPerturbYes' or 'xPerturbNo' % Here AC = 7
            if numel(XPERT)==0
                XPERT  = 'xPerturbNo';  % null input (i.e, '') for XPERT introduces no-perturbation on x
            elseif strcmpi(XPERT,'p') == 1
                XPERT  = 'xPerturbYes'; % input 'p' for XPERT introduces yes-perturbation on x
            elseif strcmpi(XPERT, 'xpy') == 1 || strcmpi(XPERT, 'xpyes') == 1
                XPERT  = 'xPerturbYes';
            elseif strcmpi(XPERT, 'xpn') == 1 || strcmpi(XPERT, 'xpno') == 1
                XPERT  = 'xPerturbNo';
            elseif strcmpi(XPERT, 'xpertyes') == 1 || strcmpi(XPERT, 'xperty') == 1
                XPERT  = 'xPerturbYes';
            elseif strcmpi(XPERT, 'xpertno') == 1 || strcmpi(XPERT, 'xpertn') == 1
                XPERT  = 'xPerturbNo';
            else
                XPERT  = 'xPerturbNo';
            end
            %-----------------------------------
            % input handling for YPerturbation
            YPERT      = varargin{AC}; % VALUE: STRING: 'yPerturbYes' or 'yPerturbNo'
            AC = AC + 1;    % Here AC = 8
            if numel(YPERT)==0
                YPERT  = 'yPerturbNo';  % null input (i.e, '') for YPERT introduces no-perturbation on y
            elseif strcmpi(YPERT,'p') == 1
                YPERT  = 'yPerturbYes'; % input 'p' for YPERT introduces yes-perturbation on y
            elseif strcmpi(YPERT, 'ypy') == 1 || strcmpi(YPERT, 'ypyes') == 1
                YPERT  = 'yPerturbYes';
            elseif strcmpi(YPERT, 'ypn') == 1 || strcmpi(YPERT, 'ypno') == 1
                YPERT  = 'yPerturbNo';
            elseif strcmpi(YPERT, 'ypertyes') == 1 || strcmpi(YPERT, 'yperty') == 1    
                YPERT  = 'yPerturbYes';
            elseif strcmpi(YPERT, 'ypertno') == 1 || strcmpi(YPERT, 'ypertn') == 1
                YPERT  = 'yPerturbNo';
            else
                YPERT  = 'yPerturbNo';
            end
            %-----------------------------------
            WTD        = varargin{AC}; % WRITE TO DISK
            %--------------------------------------------------------------------
            CONSOLE_MESSAGE_DISPLAY('AGG.G1', m, n, l, vdd);
            AC = AC + 1;    % Here AC = 9
            cdef = varargin{AC}; % VALUE: theta, clf, ctf, xsgsoffset, ysgsoffset, npcrack
            [xsgs, ysgs, cov_gra, vd1_gra, vd2_gra, ~, ~, cgeom] = AGG_SingleGrapheneSheet(m, n, l, vdd, WTD, cdef);
            PertScaleFactor = 10;
            %--------------------------------------------------------------------
            if strcmp(WarpAtomicGeometry,'WarpYes')==1
                [xsgs, ysgs, zsgs, cov_gra_appended, vd1_gra_appended, vd2_gra_appended] =...
                    AtomicGeometryWarper('G1', WarpFunction, XPERT, YPERT,...
                    xsgs, ysgs, zeros(size(xsgs)), PertScaleFactor, cov_gra, vd1_gra, vd2_gra);
            else
                zsgs = zeros(size(xsgs));
                cov_gra_appended = [cov_gra(:,1:2) xsgs(cov_gra(:,1)) ysgs(cov_gra(:,1)) zsgs(cov_gra(:,1)) xsgs(cov_gra(:,2)) ysgs(cov_gra(:,2)) zsgs(cov_gra(:,2))];
                vd1_gra_appended = [vd1_gra(:,1:2) xsgs(vd1_gra(:,1)) ysgs(vd1_gra(:,1)) zsgs(vd1_gra(:,1)) xsgs(vd1_gra(:,2)) ysgs(vd1_gra(:,2)) zsgs(vd1_gra(:,2))];
                vd2_gra_appended = [vd2_gra(:,1:2) xsgs(vd2_gra(:,1)) ysgs(vd2_gra(:,1)) zsgs(vd2_gra(:,1)) xsgs(vd2_gra(:,2)) ysgs(vd2_gra(:,2)) zsgs(vd2_gra(:,2))];
            end
            %--------------------------------------------------------------------
            % RE-ORDER ATOM NUMBERS - so as to make them start from 1
            atoms = unique( [ cov_gra(:,1); cov_gra(:,2); vd1_gra(:,1); vd1_gra(:,2); vd2_gra(:,1); vd2_gra(:,2); ] );
            % append 'atoms' array with atom numbers starting from 1 and proceeding in steps of 1
            atoms = [(1:numel(atoms))' atoms];
            cov_gra_appended1 = cov_gra_appended;
            for count = 1:size(cov_gra_appended,1)
                cov_gra_appended1(count,1) = atoms(find(cov_gra_appended(count,1) == atoms(:,2)),1);
                cov_gra_appended1(count,2) = atoms(find(cov_gra_appended(count,2) == atoms(:,2)),1);
            end
            vd1_gra_appendeda = vd1_gra_appended;
            for count = 1:size(vd1_gra_appended,1)
                vd1_gra_appendeda(count,1) = atoms(find(vd1_gra_appended(count,1) == atoms(:,2)),1);
                vd1_gra_appendeda(count,2) = atoms(find(vd1_gra_appended(count,2) == atoms(:,2)),1);
            end
            vd2_gra_appendedb = vd2_gra_appended;
            for count = 1:size(vd2_gra_appended,1)
                vd2_gra_appendedb(count,1) = atoms(find(vd2_gra_appended(count,1) == atoms(:,2)),1);
                vd2_gra_appendedb(count,2) = atoms(find(vd2_gra_appended(count,2) == atoms(:,2)),1);
            end
            cov_gra_appended = cov_gra_appended1;
            vd1_gra_appended = vd1_gra_appendeda;
            vd2_gra_appended = vd2_gra_appendedb;
            %--------------------------------------------------------------------
            % GRAB VALUES OF VARGOUT
            if WTD == 1
                varargout{1} = xsgs;
                varargout{2} = ysgs;
                varargout{3} = zsgs;
                varargout{4} = cov_gra_appended;
                varargout{5} = vd1_gra_appended;
                varargout{6} = vd2_gra_appended;
            end
            %--------------------------------------------------------------------
            % WRITE DATA TO GHARD-DISK
            SFFO('sfeam','ag', 'wrtd', 'xsgs',xsgs)
            SFFO('sfeam','ag', 'wrtd', 'ysgs',ysgs)
            SFFO('sfeam','ag', 'wrtd', 'zsgs',zsgs)
            SFFO('sfeam','ag', 'wrtd', 'cov_gra_appended',cov_gra_appended)
            SFFO('sfeam','ag', 'wrtd', 'vd1_gra_appended',vd1_gra_appended)
            SFFO('sfeam','ag', 'wrtd', 'vd2_gra_appended',vd2_gra_appended)
            %--------------------------------------------------------------------
            switch StaticGrxOrDynamicGrx
                case 's'
                    if strcmp(varargin{1}{2},'sfeam')~=1
                        %                     %%IANLF -- INPUT ARGUMENT FOR NEXT LINE FUNCTION
                        IANLF01 = 'ag'; % atomic geometry
                        IANLF02 = 's';  % 's' -- static graphix
                        IANLF03 = lower(varargin{1}{1}); %'g1' --  single graphene sheet
                        IANLF04 = cov_gra_appended; % covalent bond information
                        IANLF05 = vd1_gra_appended; % Vd1 bond information
                        IANLF06 = vd2_gra_appended; % Vd2 bond information
                        IANLF07 = 'CovYes';  % Flag 'to' or 'to not to' plot Cov bonds
                        IANLF08 = 'Vd1No';   % Flag 'to' or 'to not to' plot Vd1 bonds
                        IANLF09 = 'Vd2No';   % Flag 'to' or 'to not to' plot Vd2 bonds
                        IANLF10 = 'AtomsNo'; % Flag 'to' or 'to not to' plot individual Atoms
                        SRV(IANLF01, IANLF02, IANLF03, IANLF04, IANLF05, IANLF06, IANLF07, IANLF08, IANLF09, IANLF10);
                    end
                    %------------------------------------------------------------
                case 'd'
                    % WRITE APPROPRIATE CODE HERE
            end
        end
    case 'gn'
        ReadFromFile  = varargin{2}; % Value: 'RFFyes' or 'RFFno'. Refer SPFGMC.m for usage details
        GrapheneLayUp = varargin{3}; % Value: ex: [0 2 1 5 3 2]. Refer SPGMC.m for finer details
        SortYourLayUp = varargin{4}; % Value: 'SortYes' or 'SortNo'. Refer SPGMC.m for usage details
        [~,~,~,~,~,~,~,GrapheneStackLayUp, InterGSSpacing]...
                      = SPGMC('AGG', 'Gn', ReadFromFile, GrapheneLayUp, SortYourLayUp);
        if nargin == 4
            WTD = 1;
            ISSL = [0.00 0.37];
        else
            WTD           = varargin{5}; % Write to disk. Yes if 1. No if 0
            ISSL          = varargin{6}; % Inter Sheet Spacing limits :: [LowerLimit UpperLimit] (in nm)
        end
        AGG_StackGrapheneSheets(GrapheneStackLayUp, InterGSSpacing, WTD, ISSL);
        %--------------------------------------------------------------------
end
end % <<<<-----< E N D    O F    T H I S    F U N C T I O N
% ---------------------------------------------------------------------------

% AGG     - ATOMIC GEOMETRY GENERATOR
% AUTHOR  - SUNIL ANANDATHEERTHA
% CONTACT - sunilanandatheertha@gmail.com
% VERSION 1.01 -- Started on 17-01-2014
% VERSION 1.00 -- Started on 07-01-2014
% ---------------------------------------------------------------------------
    % EXPLANATION OF FUNCTION INPUT ARGUMENTS:
        % -------------------------------------------------------------------
        % The Number of Inputs vary depending on the atomic system required.
        %       See examples below
        % -------------------------------------------------------------------
        %      INPUT ARGUMENT            ::VALUE : << EXPLANATION >>
        % AS01 - Single Graphene Sheet     ::G1  : SINGLE GRAPH. SHEET 
        % AS02 - Stack of Graphene Sheets  ::Gn  : STACK GRAPH. SHEETS 
        % AS03 - SWCNT                     ::C1  : SWCNT               
        % AS04 - MWCNT                     ::Cn  : MWCNT               
        % AS05 - Crystalline Poly-Ethylene ::P1  : POLYMER 1 - CRYST.PE
        % AS06 - NANO-COMP-Cryst.PE.MATRIX ::NC  : NANO-COMPOSITE
        % NOTE:::: AS -- ATOMIC SYSTEM
% ---------------------------------------------------------------------------
    % EXPLANATION OF FUNCTION OUTPUT ARGUMENTS:
        % NONE - ALL THE GENERATED DATA WILL BE WRITTEN TO HARD DISK
% ---------------------------------------------------------------------------
    % EXAMPLE FORMATS OF THIS FUNCION
        % 01: AGG('G1') :::: ONLY G1
            % 01A: AGG('G1','s',[10 0 3 2],'WarpYes','trig04','xPerturbYes','yPerturbYes',1)
        % 02: AGG('Gn') :::: ONLY Gn
        % 03: AGG('C1') :::: ONLY C1
        % 04: AGG('Cn') :::: ONLY Cn
        % 05: AGG('P1') :::: P1
        % 06: AGG('G1', 'P1') :::: NC: P1 + G1
        % 07: AGG('Gn', 'P1') :::: NC: P1 + Gn
        % 08: AGG('C1', 'P1') :::: NC: P1 + C1
        % 09: AGG('Cn', 'P1') :::: NC: P1 + Cn
        % 10: AGG('C1', 'Cn', 'P1') :::: NC: P1 + C1 + Cn
% ---------------------------------------------------------------------------
    % EXAMPLES
        % ---------------------------------------------------------
        % A : S I N G L E     G R A P H E N E      S H E E T
        %           01      02         03            04       05
        % 01: AGG( 'G1',   's',   [4 0 1.5 2],   'WarpYes',   1  )
        % 02: AGG( 'G1',   's',   [4 0 1.5 2],   'WarpNo',    1  )
        % ---------------------------------------------------------
        % B : S T A C K     O F     G R A P H E N E     S H E E T S
        %           01      02         03            04       05
        % 01: AGG( 'Gn'