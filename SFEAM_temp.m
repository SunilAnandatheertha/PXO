function [varargout] = SFEAM_temp(varargin)

% SFEAM - SMS FINITE ELEMENT ANALYSIS MODULE
% mail him the files that he needs for hjis proj: naveen.venki47@gmail.com
%--------------------------------------------------------------------------
% DEF_IP_ag_g1:::: Default InPut -- Atomic Geometry -- Single graphene sheet
DEF_IP_ag_g1 = {[5 0 4 2];
                'WarpNo';
                't4';
                'xPerturbNo';
                'yPerturbNo';
                1};
%--------------------------------------------------------------------------
                                                    %  WHILE DEVELOPING
% clc;clear all;close all;SFEAM('ag','de','2d','g1',[20 0 6 0]);axis equal;box on;axis square;xlabel('x-axis');ylabel('y-axis')
%--------------------------------------------------------------------------
switch varargin{1}
    case {'AG','ag'} %--------------------------------------\-\-\-\-\-\-\-\-> varagin{1}
        switch varargin{2}
            case {'EqGeomMDNo','eqgeomno','eqgno','egn','eno','en','de'} %------------------------------------\-\-\-\-\-\-\-\-> varagin{2}
                % In above, 'de' means Dont Equalize geometry by MD
                switch varargin{3}
                    case '2d' %-----------------------------------------------\-\-\-\-\-\-\-\-> varagin{3}
                        switch varargin{4}
                            % USAGE: sms('sfea', 'AG', 'EqGeomMDNo', '2d', 'G1')
                            case {'G1','g1'} %---------------------------------------------------\-\-\-\-\-\-\-\-> varagin{4}
                                % sms('sfea', 'AG', 'EqGeomMDNo', '3d', 'G1', [10 0 4 2])
                                if nargin > 3
                                    if nargin < 5
                                        LAYUP  = DEF_IP_ag_g1{1,1};
                                        WARP   = DEF_IP_ag_g1{2,1};
                                        WARPFN = DEF_IP_ag_g1{3,1};
                                        XPERT  = DEF_IP_ag_g1{4,1};
                                        YPERT  = DEF_IP_ag_g1{5,1};
                                        WTD    = DEF_IP_ag_g1{6,1};
                                    else
                                        if varargin{5} == 0
                                            LAYUP = [5 0 2 4]; % ASSIGN A DEFAULT LAYUP if layup info not provided
                                        else
                                            LAYUP  = varargin{5};
                                        end
                                        if nargin < 6
                                            WARP   = DEF_IP_ag_g1{2,1};
                                            WARPFN = DEF_IP_ag_g1{3,1};
                                            XPERT  = DEF_IP_ag_g1{4,1};
                                            YPERT  = DEF_IP_ag_g1{5,1};
                                            WTD    = DEF_IP_ag_g1{6,1};
                                        else
                                            if varargin{6} == 0
                                                WARP   = DEF_IP_ag_g1{2,1};
                                            else
                                                WARP   = varargin{6};
                                            end
                                            if nargin < 7
                                                WARPFN = DEF_IP_ag_g1{3,1};
                                                XPERT  = DEF_IP_ag_g1{4,1};
                                                YPERT  = DEF_IP_ag_g1{5,1};
                                                WTD    = DEF_IP_ag_g1{6,1};
                                            else
                                                if varargin{7} == 0
                                                    WARPFN = DEF_IP_ag_g1{3,1};
                                                else
                                                    WARPFN = varargin{7};
                                                end
                                                %----------
                                                if nargin < 8
                                                    XPERT  = DEF_IP_ag_g1{4,1};
                                                    YPERT  = DEF_IP_ag_g1{5,1};
                                                    WTD    = DEF_IP_ag_g1{6,1};
                                                else
                                                    if varargin{8} == 0
                                                        XPERT  = DEF_IP_ag_g1{4,1};
                                                    else
                                                        XPERT  = varargin{8};
                                                    end
                                                    if nargin < 9
                                                        YPERT  = DEF_IP_ag_g1{5,1};
                                                        WTD    = DEF_IP_ag_g1{6,1};
                                                    else
                                                        if varargin{9} == 0
                                                            YPERT  = DEF_IP_ag_g1{5,1};
                                                        else
                                                            YPERT  = varargin{9};
                                                        end
                                                        if nargin < 10
                                                            WTD    = DEF_IP_ag_g1{6,1};
                                                        else
                                                            if varargin{10} == 0
                                                                WTD    = DEF_IP_ag_g1{6,1};
                                                            else
                                                                WTD    = varargin{10};
                                                            end
                                                        end
                                                    end
                                                end
                                            end
                                        end
                                    end
                                end
                                %WARP   = 'WarpNo'; WARPFN = 'NONE'; XPERT  = 'xPerturbNo'; YPERT  = 'yPerturbNo'; WTD    = 1;
                                %--------------------------------------------------------------------------
                                %000000000000-000000000000-000000000000-000000000000-000000000000
                                %00000-000000000000-000000000000-000000000000-000000000000-000000
                                %     \\\\\\ S T A R T     O F     F E M      C O D E ///////
                                %00000-000000000000-000000000000-000000000000-000000000000-000000
                                %000000000000-000000000000-000000000000-000000000000-000000000000
                                %        I M P O R T A N T     P A R A M E T E R S
                                
                                LS      = 1; % number of Load Steps
                                
                                % Format of "NatureOfLoading":
                                    %  [ type of loading,    first value,    last value ]
                                NatureOfLoading = {'c',5,0.2};
                                
                                thickness = 0.34;
                                
                                NODALCONSTRAIN_OPTION = 'yminend.FullyConstrained'; % RED   COLOR SQUARES
                                NODALLOADING_OPTION   = 'ymaxend.Loaded';           % GREEN COLOR SQUARES
                                
                                plotoriginalgeometry_cov   = 1;
                                plotoriginalgeometry_vd1   = 0;
                                plotoriginalgeometry_vd2   = 0;
                                plotoriginalgeometry_atoms = 0;
                                
                                plotdeformedgeometry_cov   = 1;
                                plotdeformedgeometry_vd1   = 0;
                                plotdeformedgeometry_vd2   = 0;
                                plotdeformedgeometry_atoms = 1;
                                
                                PlotForAllLoadSteps     = 0;
                                PlotOnlyAtFinalLoadStep = 1;
                                
                                PLOT_REACTION_FORCES_IN_GEOMETRY = 0;
                                
                                PauseInBetween = 0; PauseDuration = 0.025;
                                %--------------------------------------------------------------------------
                                % INITIALIZE IMPORTANT VARIABLES
                                NodalReactionForces   = cell(LS, 1);
                                NodalReactionForces_X = cell(LS, 1);
                                NodalReactionForces_Y = cell(LS, 1);
                                
                                LengthOfElements     = cell(LS,1);
                                
                                ElDef = cell(LS,1);
                                %--------------------------------------------------------------------------
                                % CALCULATING THE LOADING PATTERN FOR LOAD STEPS
                                switch NatureOfLoading{1}
                                    case {'constant', 'cont', 'c'}
                                        LOADING = NatureOfLoading{2} * ones(LS,1);
                                    case {'linearincreasing', 'li'}
                                        if LS > 1
                                            StartLoad = min([NatureOfLoading{2} NatureOfLoading{3}]);
                                            EndLoad   = max([NatureOfLoading{2} NatureOfLoading{3}]);
                                            LOADING = linspace(StartLoad, EndLoad, LS)';
                                        else
                                            LOADING = NatureOfLoading{2};
                                        end
                                    case {'lineardecreasing','ld'}
                                        if LS > 1
                                            StartLoad = max([NatureOfLoading{2} NatureOfLoading{3}]);
                                            EndLoad   = min([NatureOfLoading{2} NatureOfLoading{3}]);
                                            LOADING = linspace(StartLoad, EndLoad, LS)';
                                        else
                                            LOADING = NatureOfLoading{2};
                                        end
                                    case {'random', 'rand'}
                                        LOADING = NatureOfLoading{2} * rand(LS,1);
                                end
                                %LOADING
                                %--------------------------------------------------------------------------
                                for lscount = 1:LS
                                    if lscount > 1
                                        fprintf('                                  Starting Load Step No. %d\n', lscount)
                                        SCMD('seperator','type02',6,2);
                                    end
                                    %---------------------------------------------
                                    if lscount == 1
                                        % STEP A : INITIAL STUFF
                                        % STEP 01: SET-UP RESULTS FOLDER FOR THIS RUN
                                        SFFO('sfeam','ag','checkroot');                         % STEP 01
                                        % STEP 02: GENERATE ATOMISTIC GEOMETRY GEOMETRY
                                            SCMD('seperator','type02',4,1);
                                            fprintf('GENERATING GRAPHENE GEOEMTRY [%d %d %d %d]\n',varargin{5}(1), varargin{5}(2), varargin{5}(3), varargin{5}(4))
                                            AGG({'G1','sfeam'}, 's', LAYUP, WARP, WARPFN, XPERT, YPERT, WTD); % STEP 02
                                        % STEP 03: READ GEOMETRY DATA FROM DISK
                                        [ecov, evd1, evd2] = SFFO('sfeam','ag','ragfd','e');    % STEP 03
                                        IndElConn = {'ecov', ecov, 'evd1', evd1, 'evd2', evd2}; % Individual Element Connectivity
                                        
                                        ecov
                                        
                                        % STEP 04: CREATE ELEMENT CONNECTIVITY -- econUA : econ UnArranged & econA  : econ Arranged
                                        % ArrangeBy: According to x-coordinate / y-coordinate / node numbers
                                        ArrangeBy = 'ByNode';
                                        %---------------------------------------------
                                        % E L E M E N T      C O N N E C T I V I T Y
                                        % ESTABLISH ELEMENT CONNECTIVITY FOR THE CURRENT LOAD-STEP
                                        [econUA, econA, Nodes] = SElemConn('ag', '2d', IndElConn, ArrangeBy);% <<<---- FN CALL TO FORM ELEMENT CONNECTIVITY
                                        
                                        % RENUMBER THE NODES AND UPDATE 
                                        
                                        %Nodes
                                        
                                        disp('FINSHED FORMING ELEMENT CONNECTIVITY')
                                        % WRITE ELEMENT CONNECTIVITY DATA TO HARD DISK
                                        SFFO('sfeam','ag', 'wrtd', 'FullElemConnUA_LS', econUA, 'loadstep', lscount);
                                        SFFO('sfeam','ag', 'wrtd', 'FullElemConnA_LS' , econA , 'loadstep', lscount);
                                        if PauseInBetween == 1; pause(PauseDuration); end
                                        %---------------------------------------------
                                    end
                                    figure(1)
                                    hold on
%                                     for ele = 1:size(econA,1)
%                                         if econA(ele, 9) == 1
%                                             plot3([econA(ele, 3) econA(ele, 6)],...
%                                                   [econA(ele, 4) econA(ele, 7)],...
%                                                   [econA(ele, 5) econA(ele, 8)], 'MarkerFaceColor','w', 'LineWidth',2)
%                                         end
%                                         if econA(ele, 9) == 2 || econA(ele, 9) == 3
%                                             plot3([econA(ele, 3) econA(ele, 6)],...
%                                                   [econA(ele, 4) econA(ele, 7)],...
%                                                   [econA(ele, 5) econA(ele, 8)], 'k:', 'LineWidth', 1)
%                                         end
%                                     end
                                    view(30,30), axis square, axis tight, box on
                                    %---------------------------------------------
                                    % CALCULATE NUMBER OF NODES
                                    nNodes = numel(Nodes); % NUMBER OF NODES
                                    %---------------------------------------------
                                    % FORM     N.ODE     N.UMBER     N.ODE     C.O-ORDINATES     M.atrix
                                    NNNCM = unique([ [econA(:,1) econA(:,3) econA(:,4) econA(:,5)]; [econA(:,2) econA(:,6) econA(:,7) econA(:,8)] ], 'rows');
                                    nNodes = numel(Nodes);
                                    U = zeros(nNodes*2,1);
                                    U(:) = NaN;
                                    if plotoriginalgeometry_atoms == 1
                                        plot3(NNNCM(:,2), NNNCM(:,3), oazfc+NNNCM(:,4), 'kx', NNNCM(:,2), NNNCM(:,3), oazfc+NNNCM(:,4), 'ko')
                                    end
                                    if lscount > 1
                                        econA = econAnew; % tHIS STEP PREPARES THE econA FOR NEXT LOAD STEP
                                    end                                    
                                    switch NODALCONSTRAIN_OPTION
                                        case 'yminend.FullyConstrained'
                                            % Task is to find all nodes in the ymin end and constrain them
                                            temp = NNNCM(:,3);
                                            NTBC = NNNCM(find(temp==min(NNNCM(:,3))),1); % Nodes to be constrained
                                        case 'ymaxend.FullyConstrained'
                                            % Task is to find all nodes in the ymin end and constrain them
                                            temp = NNNCM(:,3);
                                            NTBC = NNNCM(find(temp==max(NNNCM(:,3))),1);
                                        case 'xminend.FullyConstrained'
                                            % Task is to find all nodes in the xmin end and constrain them
                                            temp = NNNCM(:,2);
                                            NTBC = NNNCM(find(temp==min(NNNCM(:,2))),1);
                                        case 'xmaxend.FullyConstrained'
                                            % Task is to find all nodes in the xmax end and constrain them
                                            temp = NNNCM(:,2);
                                            NTBC = NNNCM(find(temp==max(NNNCM(:,2))),1);
                                    end
                                    %%% plot the nodes which are constrained
                                    if lscount == 1
                                        mcn = NNNCM(:,1); % my contrained nodes
                                        for count = 1:numel(NTBC)
                                            temp = find(mcn==NTBC(count,1));
                                            plot3(NNNCM(temp,2), NNNCM(temp,3), NNNCM(temp,4), 'ks', 'MarkerFaceColor', 'c', 'MarkerSize',10)
                                            plot3(NNNCM(temp,2), NNNCM(temp,3), NNNCM(temp,4), 'k+', 'LineWidth', 2, 'MarkerSize',10)
                                            plot3(NNNCM(temp,2), NNNCM(temp,3), NNNCM(temp,4), 'bx', 'LineWidth', 2, 'MarkerSize',10)
                                            %text(NNNCM(temp,2), NNNCM(temp,3), NNNCM(temp,4), num2str(NTBC(count)),'FontSize',25)
                                        end
                                    end
                                    DispConsMatrix = [NTBC zeros(size(NTBC)) zeros(size(NTBC)) zeros(size(NTBC))]; % <<<<<--- DISPLACEMENT BOUNMDARY CONDITION
                                    for count = 1:size(DispConsMatrix,1)
                                        U(2*DispConsMatrix(count,1)-1,1) = DispConsMatrix(count,2);
                                        U(2*DispConsMatrix(count,1)  ,1) = DispConsMatrix(count,3);
                                    end
                                    if lscount == 1
                                        P = zeros(nNodes*2,1);
                                    end
                                    temp = NNNCM(:,3);
                                    if lscount == 1
                                        NTBL = NNNCM(find(temp==max(NNNCM(:,3))),1);
                                    end
                                    switch NODALLOADING_OPTION
                                        case 'ymaxend.Loaded'
                                            LoadingMatrix = [ NTBL zeros(size(NTBL)) repmat(LOADING(lscount,1),size(NTBL)) ]; % <<<<<--- DISPLACEMENT BOUNMDARY CONDITION
                                        case 'yminend.Loaded'
                                            LoadingMatrix = [ NTBL zeros(size(NTBL)) repmat(LOADING(lscount,1),size(NTBL)) ]; % <<<<<--- DISPLACEMENT BOUNMDARY CONDITION
                                        case 'xmaxend.Loaded'
                                            LoadingMatrix = [ NTBL repmat(LOADING(lscount,1),size(NTBL)) zeros(size(NTBL)) ]; % <<<<<--- DISPLACEMENT BOUNMDARY CONDITION
                                        case 'xminend.Loaded'
                                    end
                                    if lscount == 1
                                        mln = NNNCM(:,1); % my loaded nodes
                                        for count = 1:numel(NTBL)
                                            temp = find(mln==NTBL(count,1));
                                            plot3(NNNCM(temp,2), NNNCM(temp,3), NNNCM(temp,4), 'ko', 'MarkerFaceColor', 'c', 'MarkerSize',8)
                                            plot3(NNNCM(temp,2), NNNCM(temp,3), NNNCM(temp,4), 'k+', 'LineWidth', 2, 'MarkerSize',8)
                                        end
                                        for count = 1:size(LoadingMatrix,1)
                                            P(2*LoadingMatrix(count,1)-1,1) = LoadingMatrix(count,2);
                                            P(2*LoadingMatrix(count,1)  ,1) = LoadingMatrix(count,3);
                                        end
                                    end
                                    clear IEI
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                    IEI   = [(1:1:size(econA,1))' econA(:,1:2) econA(:,size(econA,2)) zeros(size(econA,1),1) zeros(size(econA,1),1) zeros(size(econA,1),1) zeros(size(econA,1),1) econA(:,3:size(econA,2)-1)];
                                    EleLenM = sqrt( (IEI(:,8) - IEI(:,11)).^2 + (IEI(:,9) - IEI(:,12)).^2 + (IEI(:,10) - IEI(:,13)).^2  ); % E.lement L.ength M.atrix
                                    dcl    = (IEI(:,12) - IEI(:,9) )./EleLenM; % direction coine "l"
                                    dcm    = (IEI(:,13) - IEI(:,10))./EleLenM; % direction coine "m"
                                    dcn    = (IEI(:,14) - IEI(:,11))./EleLenM; % direction coine "n"
                                    IEI(:,6:8) = [dcl dcm dcn];
                                    IEI = [IEI EleLenM];
                                    % At this point, the format of IEI is as follows: 
                                    % [ elenum nodei nodej bondtype stiffness l m n xi yi zi xj yj zj elelength]
                                    if lscount == 1
                                        ElDef{lscount,1} = [IEI(:,1) zeros(size(EleLenM))]; % UNITS: nm
                                    else
                                        ElDef{lscount,1} = [IEI(:,1) LengthOfElements{lscount,1}(:,2) - LengthOfElements{lscount-1,1}(:,2)]; % UNITS: nm
                                    end
                                    
                                    
                                    
                                    
                                    
                                    
                                    MP_beta = 26.25;
                                    MP_De   = 0.603105;
                                    LJ_eps = 3.825*10^-4;
                                    LJ_sig = 0.34;
                                    ESsz1 = size(IEI,1);
                                    ESsz2 = size(IEI,2);
                                    if lscount == 1
                                        for count = 1:ESsz1
                                            delr = ElDef{lscount,1}(count,2);
                                            if IEI(count, 4) == 1
                                                %IEI(count, ESsz2) = km;   % USE MORSE POTENTIAL HERE.
                                                IEI(count, 5) = 2 * MP_beta^2 * MP_De * (2*exp(-2*MP_beta * delr) - exp(-2*MP_beta * delr) );
                                            elseif IEI(count, 4) == 2
                                                a = 24*(3.825*10^-4 / (0.34^2)) * ( 26*( 0.34/(EleLenM(count,1) + delr) )^14 - 7*( 0.34/(EleLenM(count,1) + delr) )^8 );
                                                IEI(count, 5) = a;
                                                %IEI(count, ESsz2) = kvd1; % USE LENNARD JONES HERE.
                                            elseif IEI(count, 4) == 3
                                                a = 24*(3.825*10^-4 / (0.34^2)) * ( 26*( 0.34/(EleLenM(count,1) + delr) )^14 - 7*( 0.34/(EleLenM(count,1) + delr) )^8 );
                                                IEI(count, 5) = 0.75*a;
                                                %IEI(count, ESsz2) = kvd2; % USE LENNARD JONES HERE.
                                            end
                                        end
                                    else
                                        for count = 1:ESsz1
                                            delr = ElDef{lscount,1}(count,2);
                                            if IEI(count, ESsz2-1) == 1
                                                %IEI(count, ESsz2) = km;
                                                IEI(count, ESsz2) = 2 * MP_beta^2 * MP_De * (2*exp(-2*MP_beta * delr) - exp(-2*MP_beta * delr) );
                                            elseif IEI(count, ESsz2-1) == 2
                                                a = 24*(LJ_eps / (LJ_sig^2)) * ( 26*( LJ_sig/(EleLenM(count,1) + delr) )^14 - 7*( LJ_sig/(EleLenM(count,1) + delr) )^8 );
                                                IEI(count, ESsz2) = a;
                                                %IEI(count, ESsz2) = kvd1;
                                            elseif IEI(count, ESsz2-1) == 3
                                                a = 24*(LJ_eps / (LJ_sig^2)) * ( 26*( LJ_sig/(EleLenM(count,1) + delr) )^14 - 7*( LJ_sig/(EleLenM(count,1) + delr) )^8 );
                                                IEI(count, ESsz2) = a;
                                                %IEI(count, ESsz2) = kvd2;
                                            end
                                        end
                                    end
                                    nEle = size(IEI,1); % NUMBER OF ELEMENTS
                                    kil  = IEI(:,5);      % k.         of i.ndividual in l.ocal co. sys.
                                    kmil = zeros(2*nEle,3); % k. m.atrix of i.ndividual in l.ocal co. sys.
                                    for count = 1:nEle
                                        temp  = kil(count,1) * [ +1 -1;
                                            -1 +1; ];
                                        kmil_count = 2*count;
                                        kmil(kmil_count-1:kmil_count,:) = [repmat(IEI(count,1),2,1) temp];
                                    end
                                    
                                    
                                    IEI
                                    nNodes
                                    GDOF = zeros(nNodes,3);
                                    for count = 1:nNodes
                                        GDOF(count,:) = [Nodes(count) 2*count-1 2*count];
                                        GDOF1(count,:) = [Nodes(count) 2*Nodes(count)-1 2*Nodes(count)];
                                    end
                                    kmig = zeros(nEle*4, 7); % k. m.atrix of i.ndividual in g.lobal co. sys.
                                    for count = 1:nEle
                                        TransMat = [ IEI(count,6) IEI(count,7) 0            0            ;
                                            0            0            IEI(count,6) IEI(count,7) ]; % TRANSFORMATION MATRIX
                                        kmil_count = 2*count;
                                        kmig_count = 4*count;
                                        kmig(kmig_count-3:kmig_count,:) = [ repmat(IEI(count,1),4,1) repmat(IEI(count,2),4,1) repmat(IEI(count,3),4,1) TransMat'*kmil(kmil_count-1:kmil_count,size(kmil,2)-1:size(kmil,2))*TransMat ];
                                        % the repmat stuff in above line is to write the elem number insoide kmig
                                    end
                                    exkmig = zeros(5*nEle,6); % ex.tended kmig
                                    GDOF
                                    
                                    
                                    
                                    
                                    for count = 1:nEle
                                        element     = IEI(count,1);
                                        kmigcount   = 4*count;
                                        k           = kmig(kmigcount-3:kmigcount, size(kmig,2)-3:size(kmig,2));
                                        temp        = [GDOF(IEI(element,2),2:3) GDOF(IEI(element,3),2:3)];
                                        %count
%                                         pause
                                        
                                        k_with_gdof = [ [NaN; temp'] [temp; k] ];
                                        exkmigcount = 5 * count;
                                        exkmig(exkmigcount-4:exkmigcount,:) = [repmat(IEI(count,1),5,1) k_with_gdof];
                                    end
                                    
                                            GSM = zeros(nNodes * 2);
                                            [x,y]   = meshgrid(1:size(GSM,1), size(GSM,2):-1:1);
                                            for count = 1:nEle
                                                exkmigcount = 5 * count;
                                                exk   = exkmig(exkmigcount-3:exkmigcount, size(exkmig,2)-3:size(exkmig,2)); % extended stiffness matrix
                                                gdofe = exkmig(exkmigcount-3:exkmigcount,2); % gdof of this element
                                                
                                                GSM(gdofe(1), gdofe(1))  =  GSM(gdofe(1), gdofe(1))  +  exk(1,1);
                                                GSM(gdofe(1), gdofe(2))  =  GSM(gdofe(1), gdofe(2))  +  exk(1,2);
                                                GSM(gdofe(1), gdofe(3))  =  GSM(gdofe(1), gdofe(3))  +  exk(1,3);
                                                GSM(gdofe(1), gdofe(4))  =  GSM(gdofe(1), gdofe(4))  +  exk(1,4);
                                                
                                                GSM(gdofe(2), gdofe(1))  =  GSM(gdofe(2), gdofe(1))  +  exk(2,1);
                                                GSM(gdofe(2), gdofe(2))  =  GSM(gdofe(2), gdofe(2))  +  exk(2,2);
                                                GSM(gdofe(2), gdofe(3))  =  GSM(gdofe(2), gdofe(3))  +  exk(2,3);
                                                GSM(gdofe(2), gdofe(4))  =  GSM(gdofe(2), gdofe(4))  +  exk(2,4);
                                                
                                                GSM(gdofe(3), gdofe(1))  =  GSM(gdofe(3), gdofe(1))  +  exk(3,1);
                                                GSM(gdofe(3), gdofe(2))  =  GSM(gdofe(3), gdofe(2))  +  exk(3,2);
                                                GSM(gdofe(3), gdofe(3))  =  GSM(gdofe(3), gdofe(3))  +  exk(3,3);
                                                GSM(gdofe(3), gdofe(4))  =  GSM(gdofe(3), gdofe(4))  +  exk(3,4);
                                                
                                                GSM(gdofe(4), gdofe(1))  =  GSM(gdofe(4), gdofe(1))  +  exk(4,1);
                                                GSM(gdofe(4), gdofe(2))  =  GSM(gdofe(4), gdofe(2))  +  exk(4,2);
                                                GSM(gdofe(4), gdofe(3))  =  GSM(gdofe(4), gdofe(3))  +  exk(4,3);
                                                GSM(gdofe(4), gdofe(4))  =  GSM(gdofe(4), gdofe(4))  +  exk(4,4);
                                                
                                                PlotGSM = 0;
                                                PrintPlots = 0;
                                                if PlotGSM == 1;
                                                    [fh1] = SPlotMyGSM(GSM, x, y);
                                                    if PrintPlots == 1
                                                        if count == 1
                                                            mkdir(strcat(pwd,'\results\sfeam\GSM_plots'))
                                                        end
                                                        if nEle < 100
                                                            if count < 10
                                                                print('-djpeg100',strcat(pwd,'\results\sfeam\GSM_plots\GSM_Sparsity_At_EleNum.0',num2str(count),'.jpeg'))
                                                            else
                                                                print('-djpeg100',strcat(pwd,'\results\sfeam\GSM_plots\GSM_Sparsity_At_EleNum.',num2str(count),'.jpeg'))
                                                            end
                                                        elseif nEle >= 100 && nEle < 1000
                                                            if count < 10
                                                                print('-djpeg100',strcat(pwd,'\results\sfeam\GSM_plots\GSM_Sparsity_At_EleNum.00',num2str(count),'.jpeg'))
                                                            elseif count >= 10 && count < 100
                                                                print('-djpeg100',strcat(pwd,'\results\sfeam\GSM_plots\GSM_Sparsity_At_EleNum.0',num2str(count),'.jpeg'))
                                                            elseif count >= 100 && count < 1000
                                                                print('-djpeg100',strcat(pwd,'\results\sfeam\GSM_plots\GSM_Sparsity_At_EleNum.',num2str(count),'.jpeg'))
                                                            end
                                                        end
                                                        if count < nEle
                                                            delete(fh1);
                                                        end
                                                    end
                                                end
                                            end

                                            
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
                                            %---------------------------------------------
                                            % S O L V E    T H E    S Y S T E M     O F     E Q U A T I O N S
                                            SCMD('seperator','type02',4,1);
                                            disp('........... S O L V I N G ...........')
                                                % Solve for displacements
                                                    %\\\\\\\\\\\\\\\\\\\\\\\\\\
                                                    %det(GSMae)
                                                    DISPLACEMENTS = Pae'/GSMae;
                                                    %\\\\\\\\\\\\\\\\\\\\\\\\\\
                                                    DISPLACEMENTS = DISPLACEMENTS';
                                                % Solve for forces
                                                    Forces        = GSMae * DISPLACEMENTS;
                                                % Introduce some rounding stuff... TO BE REMOVED !!!!
                                                    for count = 1:numel(Forces)
                                                        if ( round(abs(Forces(count))) -  abs(Forces(count)) ) < 1E-6
                                                            Forces(count) = round(Forces(count));
                                                        end
                                                    end
                                                    if PauseInBetween == 1; pause(PauseDuration); end
                                            %---------------------------------------------
                                            % WRITE DISPLACEMENT VALUES INTO ----->>>>  " U "
                                            NaN_inU = find(isnan(U)==1);
                                            for count = 1:numel(NaN_inU)
                                                U(NaN_inU(count,1)) = DISPLACEMENTS(count);
                                            end
                                            % vasudeva2
                                            %---------------------------------------------
                                            % CALCULATE   S U P P O R T    R E A C T I O N     ON   CONSTRAINED NODES ONLY
                                            SCMD('seperator','type02',4,1);
                                            disp('CALCULATING REACTION FORCES')
                                            switch NODALCONSTRAIN_OPTION
                                                case 'yminend.FullyConstrained'
                                                    GSMextract = zeros(numel(NTBC),size(GSM,1));
                                                    for count = 1:numel(NTBC)
                                                        GSMextract(count, :) = GSM(NTBC(count,1),:);
                                                    end
                                            end
                                            SupportReactionsAtDOF = zeros(numel(find(isfinite(DispConsMatrix(:,2:3))==1)),1);
                                            GoBack = 0;
                                            for count = 1:numel(DispConsMatrix(:,1))
                                                if isnan(DispConsMatrix(count,2)) ~= 1
                                                    SupportReactionsAtDOF(2*count-1-GoBack,1) = 2*DispConsMatrix(count)-1;
                                                else
                                                    GoBack = GoBack + 1;
                                                end
                                                if isnan(DispConsMatrix(count,3)) ~= 1
                                                    SupportReactionsAtDOF(2*count-GoBack,1) = 2*DispConsMatrix(count);
                                                else
                                                    GoBack = GoBack + 1;
                                                end
                                            end
                                            SupportReactionsAtDOF = sort(SupportReactionsAtDOF);
                                            
                                            K_To_Find_Reactions = zeros(numel(SupportReactionsAtDOF), size(GSM,2));
                                            for count = 1:numel(SupportReactionsAtDOF)
                                                K_To_Find_Reactions(count,:) = GSM(SupportReactionsAtDOF(count),:);
                                            end
                                            % SUPPORT REACTIONS: R = KQ-F (Refer chandrupatla. pg. 111)
                                            REACTION = K_To_Find_Reactions * U; % These occur at DOFs SupportReactionsAtDOF, as defined in DispConsMatrix
                                            REACTION = [SupportReactionsAtDOF REACTION];
                                            temp = zeros(size(REACTION,1),1);
                                            for count = 1:size(REACTION)
                                                if mod(REACTION(count,1),2)==1
                                                    temp(count,1) = floor(REACTION(count,1)/2) + 1;
                                                elseif mod(REACTION(count,1),2)==0
                                                    temp(count,1) = REACTION(count,1)/2;
                                                end
                                            end
                                            REACTION = [temp REACTION];
                                            % Store "REACTION" of this load step in NodalReactionForces{lscount, 1}: next line
                                            NodalReactionForces{lscount,1} = REACTION;
                                            SFFO('sfeam','ag', 'wrtd', 'Reaction_OnConstrainedNodes_LS=', REACTION, 'loadstep', lscount);
                                            if PauseInBetween == 1; pause(PauseDuration); end
                                            %---------------------------------------------
                                            % CALCULATE AND WRITE THE   " REACTION_X "   &   " REACTION_Y " 
                                            % and WRITE THEM TO HARD DISK
                                            REACTION_X = [ REACTION(1:2:size(REACTION,1),1) REACTION(1:2:size(REACTION,1),3)];
                                            REACTION_Y = [ REACTION(2:2:size(REACTION,1),1) REACTION(2:2:size(REACTION,1),3)];
                                            SFFO('sfeam','ag', 'wrtd', 'ReactionX_OnConstrainedNodes_LS=', REACTION_X, 'loadstep', lscount);
                                            SFFO('sfeam','ag', 'wrtd', 'ReactionY_OnConstrainedNodes_LS=', REACTION_Y, 'loadstep', lscount);
                                            %---------------------------------------------
                                            % SUM THE NODAL FORCES
                                            REACTION_X_SUM = sum(REACTION_X(:,2));
                                            REACTION_y_SUM = sum(REACTION_Y(:,2));
                                            %---------------------------------------------
                                            % CALCULATE THE NEW NODAL POSITIONS
                                            SCMD('seperator','type02',4,1);
                                            disp('CALCULATING THE NEW NODAL POSITIONS')
                                            NNNCMnew  = zeros(size(NNNCM));
                                            NNNCMnew(:,1) = NNNCM(:,1);
                                            for count = 1:size(NNNCM, 1)
                                                delx  = U(2*count-1, 1);
                                                dely  = U(2*count  , 1);
                                                NNNCMnew(count, 2) = NNNCM(count, 2) + delx;
                                                NNNCMnew(count, 3) = NNNCM(count, 3) + dely;
                                            end
                                            if PauseInBetween == 1; pause(PauseDuration); end
                                            %---------------------------------------------
                                            % PLOT THE LOADED ATOMS
                                            %NNNCMnew
                                            %NTBL
                                            if lscount == LS
                                                plot3(NNNCMnew(NTBL,2), NNNCMnew(NTBL,3), NNNCMnew(NTBL,4), 'bo', 'MarkerSize',10)
                                                plot3(NNNCMnew(NTBL,2), NNNCMnew(NTBL,3), NNNCMnew(NTBL,4), 'kx', 'MarkerSize',10)
                                                plot3(NNNCMnew(NTBL,2), NNNCMnew(NTBL,3), NNNCMnew(NTBL,4), 'k+', 'MarkerSize',10)
                                            end
                                            %---------------------------------------------
                                            % CALCULATE DISPLACEMENTS ALONG "NTBL"
                                            if lscount == 1
                                                NNNCM_FirstLoadStep = NNNCM;
                                            end
                                            Displacement_NTBL_x = NNNCMnew(NTBL,2) - NNNCM_FirstLoadStep(NTBL,2);
                                            Displacement_NTBL_y = NNNCMnew(NTBL,3) - NNNCM_FirstLoadStep(NTBL,3);
                                            Displacement_NTBL_VecSum = sqrt(Displacement_NTBL_x.^2 + Displacement_NTBL_y.^2);
                                            
                                            Displacement_NTBL_x_mean = sum(Displacement_NTBL_x)/size(Displacement_NTBL_x,1);
                                            Displacement_NTBL_y_mean = sum(Displacement_NTBL_y)/size(Displacement_NTBL_y,1)
                                            SFFO('sfeam','ag', 'wrtd', 'Displacement_NTBL_x_LS=', Displacement_NTBL_x, 'loadstep', lscount);
                                            SFFO('sfeam','ag', 'wrtd', 'Displacement_NTBL_y_LS=', Displacement_NTBL_y, 'loadstep', lscount);
                                            SFFO('sfeam','ag', 'wrtd', 'Displacement_NTBL_VecSum_LS=', Displacement_NTBL_VecSum, 'loadstep', lscount);
                                            %---------------------------------------------
                                            % CALCULATE INITIAL MODULUS
                                            % NTBC
                                            % NNNCM
                                            ExtremePoints_x = [min(NNNCM(NNNCM(NTBC,1),2)) max(NNNCM(NNNCM(NTBC,1),2))];
                                            ExtremePoints_y = [min(NNNCM(NNNCM(NTBC,1),3)) max(NNNCM(NNNCM(NTBC,1),3))];
                                            Length_AlongNTBC = sqrt( ( ExtremePoints_x(2) - ExtremePoints_x(1) )^2 + ( ExtremePoints_y(2) - ExtremePoints_y(1) )^2 );
                                            Length_AlongLoadingAxis = abs(min(NNNCMnew(NNNCMnew(NTBC,1),3)) - min(NNNCMnew(NNNCMnew(NTBL,1),3)));
                                            AreaAlongConstrainedEdge = Length_AlongNTBC * thickness
                                            TotalStrain = Displacement_NTBL_y_mean / Length_AlongLoadingAxis
                                            REACTION_y_SUM
                                            forceforstresscalc(lscount,1) = REACTION_y_SUM;
                                            INITIALMODULUS = abs(REACTION_y_SUM) / (AreaAlongConstrainedEdge * TotalStrain)
                                            
                                            totalstrainvalue(lscount,1) = TotalStrain
                                            initialmodulusvalue(lscount,1) = INITIALMODULUS
                                            %---------------------------------------------
                                            % CALCULATE STRESS
                                            AXIALSTRESS = sum(abs(forceforstresscalc)) / AreaAlongConstrainedEdge
                                            %---------------------------------------------
                                            % UPDATE ELEMENT CONNECTIVITY WITH NEW CO-ORDINATES
                                            SCMD('seperator','type02',4,1);
                                            disp('UPDATING ELEMENT CONNECTIVITY INFORMATION')
                                            econAnew = zeros(size(econA));
                                            econAnew(:,1:2) = econA(:,1:2);
                                            NdNum = NNNCMnew(:,1); % node numbers
                                            for count = 1:size(econAnew,1)
                                                econAnew(count,3) = NNNCMnew(NNNCMnew(econAnew(count,1)),2); % x-co-ordinate node i
                                                econAnew(count,4) = NNNCMnew(NNNCMnew(econAnew(count,1)),3); % y-co-ordinate node i
                                                econAnew(count,5) = NNNCMnew(NNNCMnew(econAnew(count,1)),4); % z-co-ordinate node i
                                                econAnew(count,6) = NNNCMnew(NNNCMnew(econAnew(count,2)),2); % x-co-ordinate node j
                                                econAnew(count,7) = NNNCMnew(NNNCMnew(econAnew(count,2)),3); % y-co-ordinate node j
                                                econAnew(count,8) = NNNCMnew(NNNCMnew(econAnew(count,2)),4); % z-co-ordinate node j
                                            end
                                            econAnew(:,9) = econA(:,9);
                                            if PauseInBetween == 1; pause(PauseDuration); end
                                            %---------------------------------------------
                                            % OVERLAY PLOT THE NEW GEOMETRY
%                                             PlotForAllLoadSteps = 1;
%                                             PlotOnlyAtFinalLoadStep = 1; % <<<<<<<< --------- <<<<<<<<<<<<<<<<
                                            if PlotOnlyAtFinalLoadStep == 1
                                                PlotForAllLoadSteps = 0;
                                            end
                                            if PlotForAllLoadSteps == 1
                                                if lscount <= LS
                                                    for count = 1:size(econAnew)
                                                        % PLot only covalent bonds:
                                                        if plotdeformedgeometry_cov == 1
                                                            if econAnew(count,9)==1
                                                                plot3([ econAnew(count,3) econAnew(count,6) ],...
                                                                    [ econAnew(count,4) econAnew(count,7) ],...
                                                                    [ econAnew(count,5) econAnew(count,8) ],'r','LineWidth',3)
                                                            end
                                                        end
                                                        if plotdeformedgeometry_vd1 == 1
                                                            if econAnew(count,9)==2
                                                                plot3([ econAnew(count,3) econAnew(count,6) ],...
                                                                    [ econAnew(count,4) econAnew(count,7) ],...
                                                                    [ econAnew(count,5) econAnew(count,8) ],'c:','LineWidth',2)
                                                            end
                                                        end
                                                        if plotdeformedgeometry_vd2 == 1
                                                            if econAnew(count,9)==3
                                                                plot3([ econAnew(count,3) econAnew(count,6) ],...
                                                                    [ econAnew(count,4) econAnew(count,7) ],...
                                                                    [ econAnew(count,5) econAnew(count,8) ],'m:','LineWidth',2)
                                                            end
                                                        end
                                                    end
                                                    if plotdeformedgeometry_atoms ~= 1
                                                        for count = 1:size(NNNCMnew,1)
                                                            plot3(NNNCMnew(count,2), NNNCMnew(count,3), NNNCMnew(count,4),...
                                                                'ko','MarkerFaceColor', 'k', 'MarkerSize',2)
                                                        end
                                                    end
                                                    if PlotOnlyAtFinalLoadStep == 0
                                                        axis equal; box on
                                                        if PauseInBetween == 1; pause(PauseDuration); end
                                                    end
                                                end
                                            elseif PlotOnlyAtFinalLoadStep == 1
                                                if lscount == LS
                                                for count = 1:size(econAnew)
                                                    % PLot only covalent bonds:
                                                    if plotdeformedgeometry_cov == 1
                                                        if econAnew(count,9)==1
                                                            plot3([ econAnew(count,3) econAnew(count,6) ],...
                                                                  [ econAnew(count,4) econAnew(count,7) ],...
                                                                  [ econAnew(count,5) econAnew(count,8) ],'r','LineWidth',2)
                                                        end
                                                    end
                                                    if plotdeformedgeometry_vd1 == 1
                                                        if econAnew(count,9)==2
                                                            plot3([ econAnew(count,3) econAnew(count,6) ],...
                                                                  [ econAnew(count,4) econAnew(count,7) ],...
                                                                  [ econAnew(count,5) econAnew(count,8) ],'c:','LineWidth',2)
                                                        end
                                                    end
                                                    if plotdeformedgeometry_vd2 == 1
                                                        if econAnew(count,9)==3
                                                            plot3([ econAnew(count,3) econAnew(count,6) ],...
                                                                  [ econAnew(count,4) econAnew(count,7) ],...
                                                                  [ econAnew(count,5) econAnew(count,8) ],'m:','LineWidth',2)
                                                        end
                                                    end
                                                end
                                                if plotdeformedgeometry_atoms ~= 0
                                                    for count = 1:size(NNNCMnew,1)
                                                        plot3(NNNCMnew(count,2), NNNCMnew(count,3), NNNCMnew(count,4),...
                                                            'ko','MarkerFaceColor', 'k', 'MarkerSize',2)
                                                    end
                                                end
                                                end
                                            end
                                            axis tight;
                                            print('-djpeg100',strcat(pwd,'\DeformationPlot.jpeg'))
                                            %---------------------------------------------
                                            % PLOT NODAL REACTION FORCE GRAPHS ALONG Z-AXIS, ON CONSTRAINED NODES
                                            % Fx --- 'r' color '-' lines
                                            % Fy --- 'b' color '--' lines
                                            % Fz --- 'k' color ':' lines
                                                % FORMAT OF REACTION_X AND REACTION_Y
                                                % [  NODE    NodalReactionForce  ]
                                            if PLOT_REACTION_FORCES_IN_GEOMETRY == 1
                                                REACTION_X_NORMALIZED      = zeros(size(REACTION_X));
                                                REACTION_X_NORMALIZED(:,1) = REACTION_X(:,1);
                                                REACTION_X_NORMALIZED_SCALED      = zeros(size(REACTION_X));
                                                REACTION_X_NORMALIZED_SCALED(:,1) = REACTION_X(:,1);
                                                SCALEFACTOR = max(abs(unique([NNNCM(:,2); NNNCM(:,3)])));
                                                Rx_NORMALIZATION_FACTOR = max(abs(REACTION_X(:,2)));
                                                for count = 1:size(REACTION_X,1)
                                                    tempx = NNNCM(NNNCM(:,1)==REACTION_X(count,1),2);
                                                    tempy = NNNCM(NNNCM(:,1)==REACTION_X(count,1),3);
                                                    REACTION_X_NORMALIZED(count,2) = REACTION_X(count,2)/Rx_NORMALIZATION_FACTOR;
                                                    if SCALEFACTOR < 1
                                                        REACTION_X_NORMALIZED_SCALED(count,2)  = REACTION_X_NORMALIZED(count,2)*SCALEFACTOR;
                                                    else
                                                        REACTION_X_NORMALIZED_SCALED(count,2)  = REACTION_X_NORMALIZED(count,2)/SCALEFACTOR;
                                                    end
                                                    plot3(tempx, tempy, REACTION_X_NORMALIZED_SCALED(count,2),'ko')
                                                end
                                                REACTION_Y_NORMALIZED      = zeros(size(REACTION_Y));
                                                REACTION_Y_NORMALIZED(:,1) = REACTION_Y(:,1);
                                                REACTION_Y_NORMALIZED_SCALED      = zeros(size(REACTION_Y));
                                                REACTION_Y_NORMALIZED_SCALED(:,1) = REACTION_Y(:,1);
                                                SCALEFACTOR = max(abs(unique([NNNCM(:,2); NNNCM(:,3)])));
                                                Ry_NORMALIZATION_FACTOR = max(abs(REACTION_Y(:,2)));
                                                for count = 1:size(REACTION_Y,1)
                                                    tempx = NNNCM(NNNCM(:,1)==REACTION_Y(count,1),2);
                                                    TEMPPX(count,1) = tempx;
                                                    tempy = NNNCM(NNNCM(:,1)==REACTION_Y(count,1),3);
                                                    TEMPPY(count,1) = tempy;
                                                    REACTION_Y_NORMALIZED(count,2) = REACTION_Y(count,2)/Ry_NORMALIZATION_FACTOR;
                                                    if SCALEFACTOR < 1
                                                        REACTION_Y_NORMALIZED_SCALED(count,2)  = REACTION_Y_NORMALIZED(count,2)*SCALEFACTOR;
                                                    else
                                                        REACTION_Y_NORMALIZED_SCALED(count,2)  = REACTION_Y_NORMALIZED(count,2)/SCALEFACTOR;
                                                    end
                                                    plot3(tempx, tempy, REACTION_Y_NORMALIZED_SCALED(count,2),'ks')
                                                end
                                                %figure(2)
                                                %plot((1:size(REACTION_X_NORMALIZED_SCALED,1))', REACTION_X_NORMALIZED_SCALED(:,2), 'r');
                                                %view(0,90)
                                                %figure(3)
                                                %plot((1:size(REACTION_Y_NORMALIZED_SCALED,1))', REACTION_Y_NORMALIZED_SCALED(:,2), 'r');
                                                %view(0,90)
                                                figure(1)
                                                plot3(TEMPPX, TEMPPY, REACTION_X_NORMALIZED_SCALED(:,2),'r-','LineWidth',1)
                                                plot3(TEMPPX, TEMPPY, REACTION_Y_NORMALIZED_SCALED(:,2),'b--','LineWidth',1)
                                            end
                                            %---------------------------------------------
                                            % PLOT THE END NODE Displacements
                                            if lscount == LS
                                                figure(2)
                                                plot(1:numel(Displacement_NTBL_x),Displacement_NTBL_x,'sk-','LineWidth',2);hold on
                                                plot(1:numel(Displacement_NTBL_y),Displacement_NTBL_y,'ob-','LineWidth',2)
                                                plot(1:numel(Displacement_NTBL_VecSum),Displacement_NTBL_VecSum,'^r-','LineWidth',2)
                                                legend('Displacement-NTBL-x', 'Displacement-NTBL-y', 'Displacement-NTBL-vecSum', 'Location', 'Best')
                                                pause(0.1)
                                                axis square
                                                print('-djpeg100',strcat(pwd,'\DisplacementsOfLoadedEdge.jpeg'))
                                            end
                                            %---------------------------------------------
                                            % CALCULATE AND PLOT BOUNDING BOX
                                            %---------------------------------------------
                                            %---------------------------------------------
                                            SCMD('seperator','type02',6,2);
                                            fprintf('                                   Finished Load Step No. %d\n', lscount)
                                            disp(' ')
                                            disp(' ')
                                            
                                            
                                            
                                            
                                            
                                end
                                %--------------------------------------------------------------------------
                            case {'GN','gn'}
                                
                        end
                end
            case {'EqGeomMDYes', 'eqgeomyes', 'eqgyes', 'egy', 'eyes', 'ey'} %-----------------------------------\-\-\-\-\-\-\-\-> varagin{2}
        end
    case 'C' %                                       \-\-\-\-\-\-\-\-> varagin{1}
end

end