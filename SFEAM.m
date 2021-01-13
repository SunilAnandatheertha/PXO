 function [varargout] = SFEAM(varargin)
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
hold on
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
                      %  E X A M P L E    U S A G E    : 
% format short;clc;clear all;close all;SFEAM('ag','de','2d',{'g1','nd.and.nf'},[5 0 2 0]);
% clc;close all;clear all;AGG({'G1',''}, 's', [10 0 2.5 0], 'WarpNo', '', '', '', 1);axis equal;axis tight
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
switch varargin{1}
    case {'AG','ag'} %--------------------------------------\-\-\-\-\-\-\-\-> varagin{1}
        switch varargin{2}
            case {'EqGeomMDNo','eqgeomno','eqgno','egn','eno','en','de'} %------------------------------------\-\-\-\-\-\-\-\-> varagin{2}
                % In above, 'de' means Don't Equalize geometry by MD
                switch varargin{3}
                    case '2d' %-----------------------------------------------\-\-\-\-\-\-\-\-> varagin{3}
                        switch varargin{4}{1}
                            % USAGE: sms('sfea', 'AG', 'EqGeomMDNo', '2d', 'G1')
                            case {'G1', 'g1'} %---------------------------------------------------\-\-\-\-\-\-\-\-> varagin{4}
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
                                %-----------------------------------------------------------------
                                % PARAMETERS RELATED TO BOND POTENTIAL
                                    % MORSE POTENTIAL
                                        MP_beta  = 26.25;       %
                                        MP_De    = 0.603105;    %
                                        Csp2Csp2 = 0.1421;      % nm
                                        LJ_eps   = 3.825*10^-4; %
                                        LJ_sig   = 0.34;        % nm
                                        BP_Morse = { MP_beta, MP_De, Csp2Csp2 };
                                        BP_LJ    = { LJ_eps,  LJ_sig          };
                                    % TERSOFF-BRENNER POTENTIAL
                                        % . . .
                                %-----------------------------------------------------------------
                                % LOAD STEP AND SUB-STEP PARAMETERS
                                    %----------------------------------------------
                                    LS                  = 1; % Number of Load Steps
                                    %----------------------------------------------
                                    EqualizingAlgorithm = {{'NewtonRaphson'        , 1},...
                                                           {'ModifiedNewtonRaphson', 0}}; % 1:use. 0:do not use.
                                %-----------------------------------------------------------------
                                % PARAMETERS CONTROLLING properties to be calculated during post-processing
                                % First  entry in each of the below cells:   Mechanical Property to calculate
                                % Second entry in each of the below cells:   1 - Calculate     0 - Do Not Calculate
                                Find_MechProp = { { 'Initial_Tensile_Modulus'    , 0, 0.01 },...
                                                  { 'Initial_Compressive_Modulus', 0, 0.01 },...
                                                  { 'Initial_Shear_Modulus'      , 0, 0.01 },...
                                                  { 'MaximumTensile_Strength'    , 0, ''   },...
                                                  { 'MaximumTensile_Strain'      , 0, ''   },...
                                                  { 'MaximumCompressive_Strength', 0, ''   },...
                                                  { 'MaximumCompressive_Strain'  , 0, ''   },...
                                                  { 'MaximumShear_Strain'        , 0, ''   },...
                                                  { 'BendingStiffness'           , 0, ''   },...
                                                  { 'CriticalBucklingLoads'      , 0, ''   },...
                                                    };
                                %-----------------------------------------------------------------
                                % PARAMETERS CONTROLLING --> NODAL BOUNDARY CONDITIONS
                                    % Define  PAT (that is, PRESET_ANALYSIS_TYPE) related parameters
                                    %NOTE: value:0 -- Do not consider any of the preset values
                                    %           :1 -- tension/compression along Armchair direction
                                    %           :2 -- tension/compression along Zigzag direction
                                    %           :3 -- shear along Armchair direction
                                    %           :4 -- shear along Zigzag direction
                                    %--------------------------
                                    %--------------------------
                                    PAT =    varargin{7};     % Preset Analysis Type
                                    %--------------------------
                                    %--------------------------
                                    switch PAT
                                        case 0  % CUSTOM PARAMETERS ARE TO BE SET HERE
                                            %--------------------------
                                            NODALCONSTRAIN_OPTION      = 'yminend.Constrained';
                                            Con_GDOF_ConstrainedNodes  = {'MoveIn_x-0', 'MoveIn_y-0', 'MoveIn_z-0', 'Stabilize'}; % Constraints on GDOF of Constrained Nodes
                                            % 'MoveIn_x-0': Cannot move in x.     'MoveIn_x-1': Can move in x
                                            %--------------------------
                                            NODALDISP_OPTION           = 'ymaxend.Displaced';
                                            DiplacedAlong              = 'y';
                                            NatureOfDispLoading        = {'c', 00.01, 0.1};
                                            Con_GDOF_DisplacedNodes    = {'MoveIn_x-1', 'MoveIn_y-1', 'MoveIn_z-0'}; % Constraints on GDOF of Displaced Nodes
                                            % 'MoveIn_x-0': Cannot move in x.     'MoveIn_x-1': Can move in x
                                            %--------------------------
                                            NODALLOADING_OPTION        = 'xminend.Loaded';
                                            NatureOfLoading            = {'c', 00.000, 0.2};
                                            Con_GDOF_LoadedNodes       = {'LoadIn_x-1', 'LoadIn_y-0', 'LoadIn_z-0'}; % Constraints on GDOF of Loaded Nodes
                                            %----------------------------------------
                                        case 1  % TENSION ALONG ARMCHAIR DIRECTION
                                            %--------------------------
                                            NODALCONSTRAIN_OPTION      = 'xminend.Constrained';
                                            Con_GDOF_ConstrainedNodes  = {'MoveIn_x-0', 'MoveIn_y-0', 'MoveIn_z-0', 'Stabilize'}; % Constraints on GDOF of Constrained Nodes
                                            % 'MoveIn_x-0': Cannot move in x.     'MoveIn_x-1': Can move in x
                                            %--------------------------
                                            NODALDISP_OPTION           = 'xmaxend.Displaced';
                                            DiplacedAlong              = 'x';
                                            NatureOfDispLoading        = {'c', 00.01*varargin{8}, 0.1};
                                            Con_GDOF_DisplacedNodes    = {'MoveIn_x-1', 'MoveIn_y-1', 'MoveIn_z-0'}; % Constraints on GDOF of Displaced Nodes
                                            % 'MoveIn_x-0': Cannot move in x.     'MoveIn_x-1': Can move in x
                                            %--------------------------
                                            NODALLOADING_OPTION        = 'yminend.Loaded';
                                            NatureOfLoading            = {'c', 00.010, 0.2};
                                            Con_GDOF_LoadedNodes       = {'LoadIn_x-1', 'LoadIn_y-0', 'LoadIn_z-0'}; % Constraints on GDOF of Loaded Nodes
                                            %----------------------------------------
                                        case 2  % TENSION ALONG ZIGZAG DIRECTION
                                            %--------------------------
                                            NODALCONSTRAIN_OPTION      = 'yminend.Constrained';
                                            Con_GDOF_ConstrainedNodes  = {'MoveIn_x-0', 'MoveIn_y-0', 'MoveIn_z-0', 'Stabilize'}; % Constraints on GDOF of Constrained Nodes
                                            % 'MoveIn_x-0': Cannot move in x.     'MoveIn_x-1': Can move in x
                                            %--------------------------
                                            NODALDISP_OPTION           = 'ymaxend.Displaced';
                                            DiplacedAlong              = 'y';
                                            NatureOfDispLoading        = {'c', 00.01*varargin{8}, 0.1};
                                            Con_GDOF_DisplacedNodes    = {'MoveIn_x-1', 'MoveIn_y-1', 'MoveIn_z-0'}; % Constraints on GDOF of Displaced Nodes
                                            % 'MoveIn_x-0': Cannot move in x.     'MoveIn_x-1': Can move in x
                                            %--------------------------
                                            NODALLOADING_OPTION        = 'xminend.Loaded';
                                            NatureOfLoading            = {'c', 00.000, 0.2};
                                            Con_GDOF_LoadedNodes       = {'LoadIn_x-1', 'LoadIn_y-0', 'LoadIn_z-0'}; % Constraints on GDOF of Loaded Nodes
                                            %----------------------------------------
                                        case 3  % SHEAR ALONG ARMCHAIR DIRECTION
                                            %--------------------------
                                            NODALCONSTRAIN_OPTION      = 'yminend.Constrained';
                                            Con_GDOF_ConstrainedNodes  = {'MoveIn_x-0', 'MoveIn_y-0', 'MoveIn_z-0', 'Stabilize'}; % Constraints on GDOF of Constrained Nodes
                                            % 'MoveIn_x-0': Cannot move in x.     'MoveIn_x-1': Can move in x
                                            %--------------------------
                                            NODALDISP_OPTION           = 'ymaxend.Displaced';
                                            DiplacedAlong              = 'x';
                                            NatureOfDispLoading        = {'c', 00.01*varargin{8}, 0.1};
                                            Con_GDOF_DisplacedNodes    = {'MoveIn_x-1', 'MoveIn_y-0', 'MoveIn_z-0'}; % Constraints on GDOF of Displaced Nodes
                                            % 'MoveIn_x-0': Cannot move in x.     'MoveIn_x-1': Can move in x
                                            %--------------------------
                                            NODALLOADING_OPTION        = 'xminend.Loaded';
                                            NatureOfLoading            = {'c', 00.000, 0.2};
                                            Con_GDOF_LoadedNodes       = {'LoadIn_x-1', 'LoadIn_y-0', 'LoadIn_z-0'}; % Constraints on GDOF of Loaded Nodes
                                            %----------------------------------------
                                        case 4  % SHEAR ALONG ZIGZAG DIRECTION
                                            %--------------------------
                                            NODALCONSTRAIN_OPTION      = 'xminend.Constrained';
                                            Con_GDOF_ConstrainedNodes  = {'MoveIn_x-0', 'MoveIn_y-0', 'MoveIn_z-0', 'Stabilize'}; % Constraints on GDOF of Constrained Nodes
                                            % 'MoveIn_x-0': Cannot move in x.     'MoveIn_x-1': Can move in x
                                            %--------------------------
                                            NODALDISP_OPTION           = 'xmaxend.Displaced';
                                            DiplacedAlong              = 'y';
                                            NatureOfDispLoading        = {'c', 00.01*varargin{8}, 0.1};
                                            Con_GDOF_DisplacedNodes    = {'MoveIn_x-1', 'MoveIn_y-1', 'MoveIn_z-0'}; % Constraints on GDOF of Displaced Nodes
                                            % 'MoveIn_x-0': Cannot move in x.     'MoveIn_x-1': Can move in x
                                            %--------------------------
                                            NODALLOADING_OPTION        = 'yminend.Loaded';
                                            NatureOfLoading            = {'c', 00.000, 0.2};
                                            Con_GDOF_LoadedNodes       = {'LoadIn_x-1', 'LoadIn_y-0', 'LoadIn_z-0'}; % Constraints on GDOF of Loaded Nodes
                                            %----------------------------------------
                                    end
                                    thickness = 0.34;
                                %-----------------------------------------------------------------
                                % PAREMETERS PERTAINING TO VIZUALISATION OF ORIGINAL GEOMETRY:
                                    plotoriginalgeometry_atoms = 0;
                                    %--------------------------
                                    plotoriginalgeometry_cov   = 1;    plotoriginalgeometry_vd1   = 0;     plotoriginalgeometry_vd2   = 0;
                                    TEXTnodenumbersOrgGeom     = 0;    TEXTnodenumbersOrgGeomFS   = 8;     TEXTnodenumbersOrgGeomCol  = {'r'};
                                    %--------------------------
                                    TEXTelemnumbersOrgGeom     = {'cov', 0,      'vd1', 0,                'vd2', 0};
                                    TEXTelemnumbersOrgGeomCol  = {'cov', 'w',    'vd1', [0 1 1],    'vd2', 'g'};
                                    TEXTelemnumbersOrgGeomFS   = 8;
                                %-----------------------------------------------------------------
                                % PAREMETERS PERTAINING TO VIZUALISATION OF DEFORMED GEOMETRY:
                                    plotdeformedgeometry_atoms_details = {1, { 1,'ko','k',6 }, { 0,'kx','r',5 } };
                                    %--------------------------
                                    plotdeformedgeometry_cov   = 1;    plotdeformedgeometry_vd1   = 0;     plotdeformedgeometry_vd2   = 0;
                                    TEXTnodenumbersDefGeom     = 0;    TEXTnodenumbersDefGeomFS   = 8;     TEXTnodenumbersDefGeomCol  = {'c'};
                                    %--------------------------
                                    TEXTelemnumbersDefGeom     = {'cov', 1,      'vd1', 1,                'vd2', 1};
                                    TEXTelemnumbersDefGeomCol  = {'cov', 'w',    'vd1', [0.7 0.9 0.7],    'vd2', 'g'};
                                    TEXTelemnumbersDefGeomFS   = 8;
                                    %--------------------------
                                    PlotForAllLoadSteps               = 1;
                                    PlotOnlyAtFinalLoadStep           = 1;
                                    PLOT_REACTION_FORCES_IN_GEOMETRY  = 0;
                                %-----------------------------------------------------------------
                                % MISCELLANEOUS PARAMETERS
                                    PauseInBetween = 0;   PauseDuration = 0.025;
                                %-----------------------------------------------------------------
                                % INITIALIZE IMPORTANT VARIABLES
                                    LengthOfElements      = cell(LS, 1);
                                    ElDef                 = cell(LS, 1);
                                    UA                    = cell(LS, 1);
                                    HistoryOfElementData  = cell(LS, 1);
                                %-----------------------------------------------------------------
                                % CALCULATING THE LOADING PATTERN FOR LOAD STEPS
                                    [LOADING] = SF_LoadStep_Loading(NatureOfLoading, LS);
                                    [NdDispLOADING] = SF_LoadStep_DispLoading({'',''}, NatureOfDispLoading, LS);
                                %-----------------------------------------------------------------
                                SFFO('sfeam','ag','checkroot'); % SET-UP RESULTS FOLDER FOR THIS RUN
                                %-----------------------------------------------------------------
                                switch varargin{4}{2}
                                    case {'NodalDisp.and.NodalForce', 'nd.and.nf'}
                                        for lscount = 1:LS
                                            SCMD('sfeam.ag', 'LoadStepStart', lscount);
                                            %---------------------------------------------
                                            if lscount == 1
                                                cdef = varargin{9}(:);
                                                AGG({'G1','sfeam'}, 's', LAYUP, WARP, WARPFN, XPERT, YPERT, WTD, cdef);
                                                [ecov, evd1, evd2]     = SFFO('sfeam','ag','ragfd','e');
                                                [econUA, econA, Nodes] = SElemConn('ag', '2d', {'ecov', ecov, 'evd1', evd1, 'evd2', evd2}, 'ArrangeByNode');
                                                [NNNCM]                = SFIM('sf', 'ag', 'nnncm', {econA, lscount});
                                                %if LS > 1
                                                    NNNCM_ls1 = NNNCM;
                                                %end
                                                nNodes                 = numel(Nodes);
                                                [~, GDOFlong]          = SFIM('sf','ag','GDOF', 1, {nNodes, Nodes});
                                                [NTBC]                 = SFIM('sf', 'ag', 'graphene_NTBC_2d_version01',...
                                                                              {'',''}, {NODALCONSTRAIN_OPTION, NNNCM}, {'',''}, {lscount});
                                                [NTBD]                 = SFIM('sf', 'ag', 'graphene_NTBD_2d_version01',...
                                                                              {'',''}, {NODALDISP_OPTION,      NNNCM}, {'',''}, {lscount});
                                                %[NTBCD1]               = SFIM('sf', 'ag', 'graphene_NTBCD_2d_version01', {'',''}, {NTBC, NTBD});
                                                [NTBCD]                = sort([NTBC; NTBD]);
                                                [NTBLinfo]             = SFIM('sf', 'ag', 'graphene_NTBL_2d_version01',...
                                                                              {'',''}, {NODALLOADING_OPTION,   NNNCM}, {'',''}, {lscount});
                                                NTBL                   = NTBLinfo{1};
                                                [GTBC, GTBD, GTBCD, GTBL] = SFIM('sf', 'ag', 'FormGDOF_CDL_2d_version02',...
                                                                              {'', ''}, {NTBC, NTBD, NTBCD, NTBL},...
                                                                              {NODALCONSTRAIN_OPTION, NODALDISP_OPTION, DiplacedAlong, NODALLOADING_OPTION},...
                                                                              {Con_GDOF_ConstrainedNodes, Con_GDOF_DisplacedNodes, Con_GDOF_LoadedNodes},...
                                                                              {NatureOfDispLoading, NatureOfLoading}, {'',''}, {lscount, LS, WTD});
                                                SGV('ag', 'g1',...
                                                    {lscount, econA, NNNCM},...
                                                    {plotoriginalgeometry_cov, plotoriginalgeometry_vd1, plotoriginalgeometry_vd2, plotoriginalgeometry_atoms},...
                                                    {TEXTelemnumbersOrgGeom, TEXTelemnumbersOrgGeomFS, TEXTelemnumbersOrgGeomCol},...
                                                    {TEXTnodenumbersOrgGeom, TEXTnodenumbersOrgGeomFS, TEXTnodenumbersOrgGeomCol})
                                                [IEI, ElDef, LengthOfElements] = SFIM( 'sf', 'ag', 'IEI', {'', ''}, {econA}, {MP_beta, MP_De, LJ_eps, LJ_sig}, {lscount}, {WTD} );
                                            end
                                            SFFO('sfeam','ag', 'wrtd', 'FullElemConnUA_LS', econUA, 'loadstep', lscount);
                                            SFFO('sfeam','ag', 'wrtd', 'FullElemConnA_LS' , econA , 'loadstep', lscount);
                                            %---------------------------------------------
                                            if lscount > 1
                                                [IEI, ElDef, LengthOfElements] = SFIM( 'sf', 'ag', 'IEI', {'', ''}, {econA, ElDef, LengthOfElements},...
                                                                                      {MP_beta, MP_De, LJ_eps, LJ_sig}, {lscount}, {WTD} );
                                            end
                                            %---------------------------------------------
                                            if lscount == 1 % P: Load.   NTBL: Nodes To Be Loaded
                                                [P, ~] = SFIM('sf','ag','P,NTBL',...
                                                                      {lscount, LOADING, nNodes, NNNCM, NODALLOADING_OPTION});
                                            else
                                                [P, ~] = SFIM('sf','ag','P,NTBL',...
                                                                      {lscount, LOADING, nNodes, NNNCM, NODALLOADING_OPTION}, {P, NTBL});
                                            end
                                            %---------------------------------------------
                                            [U]              = SFIM('sf','ag','U_version02', {''}, {NdDispLOADING},...
                                                                    {''}, {GDOFlong, GTBC, GTBD, NTBD, NTBL},...
                                                                    {Con_GDOF_DisplacedNodes,''}, {lscount});
                                            nEle             = size(IEI,1);
                                            [kmil]           = SFIM('sf','ag','kmil', 1, {IEI, nEle, lscount});
                                            [GDOF, GDOFlong] = SFIM('sf','ag','GDOF', 1, {nNodes, Nodes});
                                            [kmig]           = SFIM('sf','ag','kmig', 1, {IEI, nEle, kmil, lscount});
                                            [exkmig]         = SFIM('sf','ag','exkmig', { 1, '' }, { IEI, nEle, kmig, GDOF, lscount } );
                                            [GSM]            = SSMA({'fe', '2dtruss'}, {nNodes, nEle}, {exkmig}, {lscount});
                                            %---------------------------------------------
                                            [U, NodalForces, REAC] = SFSolver('UDMS', {'nd.and.nf', 6}, {GSM, U, P, UA},...
                                                                              {GDOFlong, GTBC, GTBD, GTBCD, GTBL}, {'',''}, {lscount,''});
                                            %---------------------------------------------
                                            if numel(REAC) == 1
                                                RC = [GTBC REAC{1}];
                                                RD = 0; % Does not exist -- appears when only nodal force boundary cond is applied
                                            elseif numel(REAC) == 2
                                                RC = [GTBC REAC{1}];
                                                RD = [GTBD REAC{2}];
                                            end
                                            %---------------------------------------------
                                            [econA] = SFIM('sf', 'ag', 'Update_econA', {'',''}, {econA, U, GDOFlong}, {'', ''}, {lscount});
                                            [NNNCM] = SFIM('sf', 'ag', 'nnncm',{econA, lscount});
                                            % SSSS - just a check point in the code
%                                             size(NNNCM)
                                            %---------------------------------------------
                                            SGV('sfeam.OverlayDefGeom',...
                                                'ag',...
                                                {PlotOnlyAtFinalLoadStep, PlotForAllLoadSteps, lscount, LS},...
                                                {plotdeformedgeometry_cov, plotdeformedgeometry_vd1, plotdeformedgeometry_vd2, plotdeformedgeometry_atoms_details},...
                                                {econA, NNNCM},...
                                                {TEXTnodenumbersDefGeom, TEXTnodenumbersDefGeomFS, TEXTnodenumbersDefGeomCol},...
                                                {TEXTelemnumbersDefGeom, TEXTelemnumbersDefGeomFS, TEXTelemnumbersDefGeomCol})
                                            %---------------------------------------------
                                            ResultIdentifier    = floor(100000*rand);
                                            fprintf('the result jpeg for deformation will have %d \n', ResultIdentifier)
                                            filename_defplot    = strcat(pwd,'\results','\','VDD',num2str(LAYUP(4)),'_',num2str(ResultIdentifier),'.jpeg');
                                            filename_resultData = strcat(pwd,'\results','\','VDD',num2str(LAYUP(4)),'_',num2str(ResultIdentifier),'.txt');
                                            %---------------------------------------------
                                            %final markups before printing
                                            xlabel('Armchair');
                                            ylabel('Zigzag');
                                             %--------------------------------------------
                                            
                                            print('-djpeg100',filename_defplot)
                                            %---------------------------------------------
                                            %\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
                                            ConsiderEndThickness = 1;
                                            %\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
                                            % CALCULATE STRAIN
                                            if PAT == 1
                                                if lscount == LS
                                                    % Now @ 1'st load step
                                                    x_ls_1_c = NNNCM_ls1(NTBC(1), 2); y_ls_1_c = NNNCM_ls1(NTBC(1), 3); z_ls_1_c = NNNCM_ls1(NTBC(1), 4);
                                                    x_ls_1_d = NNNCM_ls1(NTBD(1), 2); y_ls_1_d = NNNCM_ls1(NTBD(1), 3); z_ls_1_d = NNNCM_ls1(NTBD(1), 4);
                                                    % Now @ N'th load step
                                                    x_ls_N_c = NNNCM(NTBC(1), 2); y_ls_N_c = NNNCM(NTBC(1), 3); z_ls_N_c = NNNCM(NTBC(1), 4);
                                                    x_ls_N_d = NNNCM(NTBD(1), 2); y_ls_N_d = NNNCM(NTBD(1), 3); z_ls_N_d = NNNCM(NTBD(1), 4);
                                                    % Find initial and final dimension
%                                                     if ConsiderEndThickness == 1
%                                                         InitialDistance = 0.34 + sqrt( (x_ls_1_d - x_ls_1_c)^2 + (y_ls_1_d - y_ls_1_c)^2 + (z_ls_1_d - z_ls_1_c)^2); % nm
%                                                         FinalDistance   = 0.34 + sqrt( (x_ls_N_d - x_ls_N_c)^2 + (y_ls_N_d - y_ls_N_c)^2 + (z_ls_N_d - z_ls_N_c)^2); % nm
%                                                     else
                                                        InitialDistance = sqrt( (x_ls_1_d - x_ls_1_c)^2 + (y_ls_1_d - y_ls_1_c)^2 + (z_ls_1_d - z_ls_1_c)^2); % nm
                                                        FinalDistance   = sqrt( (x_ls_N_d - x_ls_N_c)^2 + (y_ls_N_d - y_ls_N_c)^2 + (z_ls_N_d - z_ls_N_c)^2); % nm
%                                                     end
                                                    % Calculate strain
                                                    ArmchairStrain = (FinalDistance - InitialDistance)/InitialDistance;  % nm/nm
                                                    ArmchairDisplacement = (FinalDistance - InitialDistance); % nm
                                                    fprintf('Strain along armchair direction = %4.4f nm/nm   \n', ArmchairStrain)
                                                end
                                            elseif PAT == 2
                                                if lscount == LS
                                                    % Now @ 1'st load step
                                                    x_ls_1_c = NNNCM_ls1(NTBC(1), 2); y_ls_1_c = NNNCM_ls1(NTBC(1), 3); z_ls_1_c = NNNCM_ls1(NTBC(1), 4);
                                                    x_ls_1_d = NNNCM_ls1(NTBD(1), 2); y_ls_1_d = NNNCM_ls1(NTBD(1), 3); z_ls_1_d = NNNCM_ls1(NTBD(1), 4);
                                                    % Now @ N'th load step
                                                    x_ls_N_c = NNNCM(NTBC(1), 2); y_ls_N_c = NNNCM(NTBC(1), 3); z_ls_N_c = NNNCM(NTBC(1), 4);
                                                    x_ls_N_d = NNNCM(NTBD(1), 2); y_ls_N_d = NNNCM(NTBD(1), 3); z_ls_N_d = NNNCM(NTBD(1), 4);
                                                    % Find initial and final dimension
%                                                     if ConsiderEndThickness == 1
%                                                         InitialDistance = 0.34 + sqrt( (x_ls_1_d - x_ls_1_c)^2 + (y_ls_1_d - y_ls_1_c)^2 + (z_ls_1_d - z_ls_1_c)^2); % nm
%                                                         FinalDistance   = 0.34 + sqrt( (x_ls_N_d - x_ls_N_c)^2 + (y_ls_N_d - y_ls_N_c)^2 + (z_ls_N_d - z_ls_N_c)^2); % nm
%                                                     else
                                                        InitialDistance = sqrt( (x_ls_1_d - x_ls_1_c)^2 + (y_ls_1_d - y_ls_1_c)^2 + (z_ls_1_d - z_ls_1_c)^2); % nm
                                                        FinalDistance   = sqrt( (x_ls_N_d - x_ls_N_c)^2 + (y_ls_N_d - y_ls_N_c)^2 + (z_ls_N_d - z_ls_N_c)^2); % nm
%                                                     end
                                                    % Calculate strain
                                                    ZigzagStrain = (FinalDistance - InitialDistance)/InitialDistance;  % nm/nm
                                                    ZigzagDisplacement = (FinalDistance - InitialDistance); % nm
                                                    fprintf('Strain along zigzag direction = %4.4f nm/nm   \n', ZigzagStrain)
                                                end
                                            elseif PAT == 3
                                                if lscount == LS
                                                    x1_old = NNNCM_ls1(NTBC(1),2); y1_old = NNNCM_ls1(NTBC(1),3); z1_old = NNNCM_ls1(NTBC(1),4);
                                                    x2_old = NNNCM_ls1(NTBD(1),2); y2_old = NNNCM_ls1(NTBD(1),3); z2_old = NNNCM_ls1(NTBD(1),4);
                                                    x1_new = NNNCM(NTBC(1),2);     y1_new = NNNCM(NTBC(1),3);     z1_new = NNNCM(NTBC(1),4);
                                                    x2_new = NNNCM(NTBD(1),2);     y2_new = NNNCM(NTBD(1),3);     z2_new = NNNCM(NTBD(1),4);
                                                        plot( [x1_old x2_old], [y1_old y2_old], 'b--', 'LineWidth', 1.5)
                                                        plot( [x1_old x2_new], [y1_old y2_new], 'r--', 'LineWidth', 1.5)
                                                    Tan_theta        = sqrt( (x2_old-x2_new)^2 + (y2_old-y2_new)^2 ) /...
                                                                       sqrt( (x1_old-x2_old)^2 + (y1_old-y2_old)^2 );
                                                    ArmchairSingleShearAngle = atan(Tan_theta); % In radians.
                                                    fprintf('Single Shear angle in radians = %4.4f radians   \n', ArmchairSingleShearAngle)
                                                end
                                            elseif PAT == 4
                                                if lscount == LS
                                                    x1_old = NNNCM_ls1(NTBC(1),2); y1_old = NNNCM_ls1(NTBC(1),3); z1_old = NNNCM_ls1(NTBC(1),4);
                                                    x2_old = NNNCM_ls1(NTBD(1),2); y2_old = NNNCM_ls1(NTBD(1),3); z2_old = NNNCM_ls1(NTBD(1),4);
                                                    x1_new = NNNCM(NTBC(1),2);     y1_new = NNNCM(NTBC(1),3);     z1_new = NNNCM(NTBC(1),4);
                                                    x2_new = NNNCM(NTBD(1),2);     y2_new = NNNCM(NTBD(1),3);     z2_new = NNNCM(NTBD(1),4);
                                                        plot( [x1_old x2_old], [y1_old y2_old], 'b--', 'LineWidth', 1.5)
                                                        plot( [x1_old x2_new], [y1_old y2_new], 'r--', 'LineWidth', 1.5)
                                                    Tan_theta        = sqrt( (x2_old-x2_new)^2 + (y2_old-y2_new)^2 ) /...
                                                                       sqrt( (x1_old-x2_old)^2 + (y1_old-y2_old)^2 );
                                                    ZigzagSingleShearAngle = atan(Tan_theta);
                                                    % In radians.
                                                    fprintf('Single Shear angle in radians = %4.4f radians   \n', ZigzagSingleShearAngle)
                                                end
                                            end 
                                            %---------------------------------------------
                                            % CALCULATE REACTOIN FORCE ON CONSTRAINED NODES
                                            if PAT == 1
                                                if lscount == LS
                                                    row = zeros(numel(NTBC),1);
                                                    col = zeros(numel(NTBC),1);
                                                    for count = 1:numel(NTBC)
                                                        row(count,1) = find(RC(:,1)==2*NTBC(count,1)-1);
                                                        col(count,1) = find(RC(:,1)==2*NTBC(count,1));
                                                    end
                                                    NodalForces_x = RC(row,2);
                                                    NodalForces_y = RC(col,2);
                                                    Force_x = sum(abs(NodalForces_x));
                                                    Force_y = sum(abs(NodalForces_y));
                                                end
                                            elseif PAT == 2
                                                if lscount == LS
                                                    row = zeros(numel(NTBC),1);
                                                    col = zeros(numel(NTBC),1);
                                                    for count = 1:numel(NTBC)
                                                        row(count,1) = find(RC(:,1)==2*NTBC(count,1)-1);
                                                        col(count,1) = find(RC(:,1)==2*NTBC(count,1));
                                                    end
                                                    NodalForces_x = RC(row,2);
                                                    NodalForces_y = RC(col,2);
                                                    Force_x = sum(abs(NodalForces_x));
                                                    Force_y = sum(abs(NodalForces_y));
                                                end
                                            elseif PAT == 3
                                                if lscount == LS
                                                    row = zeros(numel(NTBC),1);
                                                    col = zeros(numel(NTBC),1);
                                                    for count = 1:numel(NTBC)
                                                        row(count,1) = find(RC(:,1)==2*NTBC(count,1)-1);
                                                        col(count,1) = find(RC(:,1)==2*NTBC(count,1));
                                                    end
                                                    NodalShearForces_x = RC(row,2);
                                                    NodalShearForces_y = RC(col,2);
                                                    ArmchairShearForce_x = sum(abs(NodalShearForces_x));
                                                    ArmchairShearForce_y = sum(abs(NodalShearForces_y));
                                                end
                                            elseif PAT == 4
                                                if lscount == LS
                                                    row = zeros(numel(NTBC),1);
                                                    col = zeros(numel(NTBC),1);
                                                    for count = 1:numel(NTBC)
                                                        row(count,1) = find(RC(:,1)==2*NTBC(count,1)-1);
                                                        col(count,1) = find(RC(:,1)==2*NTBC(count,1));
                                                    end
                                                    NodalShearForces_x = RC(row,2);
                                                    NodalShearForces_y = RC(col,2);
                                                    ZigzagShearForce_x = sum(abs(NodalShearForces_x));
                                                    ZigzagShearForce_y = sum(abs(NodalShearForces_y));
                                                end
                                            end
                                            %---------------------------------------------
                                            % CALCULATE AREA
                                            if PAT == 1
                                                if lscount == LS
                                                    MinEndx_NTBC = min(NNNCM(NTBC,2));
                                                    MinEndy_NTBC = min(NNNCM(NTBC,3));
                                                    MinEndz_NTBC = min(NNNCM(NTBC,4));
                                                    MaxEndx_NTBC = max(NNNCM(NTBC,2));
                                                    MaxEndy_NTBC = max(NNNCM(NTBC,3));
                                                    MaxEndz_NTBC = max(NNNCM(NTBC,4));
                                                    MinEndMaxEndDISTANCE_NTBC = sqrt( (MaxEndx_NTBC-MinEndx_NTBC)^2 +...
                                                                                      (MaxEndy_NTBC-MinEndy_NTBC)^2 +...
                                                                                      (MaxEndz_NTBC-MinEndz_NTBC)^2 ); % nm
                                                    if ConsiderEndThickness == 1
                                                        ArmchairArea = (MinEndMaxEndDISTANCE_NTBC * thickness) + pi*(0.34/2)^2; % nm^2
                                                    else
                                                        ArmchairArea = (MinEndMaxEndDISTANCE_NTBC * thickness)                ; % nm^2
                                                    end
                                                    ArmchairArea_linear = MinEndMaxEndDISTANCE_NTBC;
                                                end                                                
                                            elseif PAT == 2
                                                if lscount == LS
                                                    MinEndx_NTBC = min(NNNCM(NTBC,2));
                                                    MinEndy_NTBC = min(NNNCM(NTBC,3));
                                                    MinEndz_NTBC = min(NNNCM(NTBC,4));
                                                    MaxEndx_NTBC = max(NNNCM(NTBC,2));
                                                    MaxEndy_NTBC = max(NNNCM(NTBC,3));
                                                    MaxEndz_NTBC = max(NNNCM(NTBC,4));
                                                    MinEndMaxEndDISTANCE_NTBC = sqrt( (MaxEndx_NTBC-MinEndx_NTBC)^2 +...
                                                                                      (MaxEndy_NTBC-MinEndy_NTBC)^2 +...
                                                                                      (MaxEndz_NTBC-MinEndz_NTBC)^2 ); % nm
                                                    if ConsiderEndThickness == 1
                                                        ZigzagArea = (MinEndMaxEndDISTANCE_NTBC * thickness) + pi*(0.34/2)^2; % nm^2
                                                    else
                                                        ZigzagArea = (MinEndMaxEndDISTANCE_NTBC * thickness);                 % nm^2
                                                    end
                                                    ZigzagArea_linear = MinEndMaxEndDISTANCE_NTBC;
                                                end
                                            elseif PAT == 3
                                                if lscount == LS
                                                    MinEndx_NTBC = min(NNNCM(NTBC,2));
                                                    MinEndy_NTBC = min(NNNCM(NTBC,3));
                                                    MinEndz_NTBC = min(NNNCM(NTBC,4));
                                                    MaxEndx_NTBC = max(NNNCM(NTBC,2));
                                                    MaxEndy_NTBC = max(NNNCM(NTBC,3));
                                                    MaxEndz_NTBC = max(NNNCM(NTBC,4));
                                                    MinEndMaxEndDISTANCE_NTBC = sqrt( (MaxEndx_NTBC-MinEndx_NTBC)^2 +...
                                                                                      (MaxEndy_NTBC-MinEndy_NTBC)^2 +...
                                                                                      (MaxEndz_NTBC-MinEndz_NTBC)^2 );
                                                    if ConsiderEndThickness == 1
                                                        ArmchairShearArea = (MinEndMaxEndDISTANCE_NTBC * thickness) + pi*(0.34/2)^2; % nm^2
                                                    else
                                                        ArmchairShearArea = (MinEndMaxEndDISTANCE_NTBC * thickness);                 % nm^2
                                                    end
                                                    ArmchairLinearShearArea = MinEndMaxEndDISTANCE_NTBC;
                                                end
                                            elseif PAT == 4
                                                if lscount == LS
                                                    MinEndx_NTBC = min(NNNCM(NTBC,2));
                                                    MinEndy_NTBC = min(NNNCM(NTBC,3));
                                                    MinEndz_NTBC = min(NNNCM(NTBC,4));
                                                    MaxEndx_NTBC = max(NNNCM(NTBC,2));
                                                    MaxEndy_NTBC = max(NNNCM(NTBC,3));
                                                    MaxEndz_NTBC = max(NNNCM(NTBC,4));
                                                    MinEndMaxEndDISTANCE_NTBC = sqrt( (MaxEndx_NTBC-MinEndx_NTBC)^2 +...
                                                                                      (MaxEndy_NTBC-MinEndy_NTBC)^2 +...
                                                                                      (MaxEndz_NTBC-MinEndz_NTBC)^2 );
                                                    if ConsiderEndThickness == 1
                                                        ZigzagShearArea = (MinEndMaxEndDISTANCE_NTBC * thickness) + pi*(0.34/2)^2; % nm^2
                                                    else
                                                        ZigzagShearArea = (MinEndMaxEndDISTANCE_NTBC * thickness);                 % nm^2
                                                    end
                                                    ZigzagLinearShearArea = MinEndMaxEndDISTANCE_NTBC;
                                                end
                                            end
                                            %---------------------------------------------
                                            % CALCULATE STRESS
                                            if PAT == 1
                                                if lscount == LS
                                                    ArmchairStress              = abs(Force_x / ArmchairArea);
                                                    ArmchairStress_Linear       = abs(Force_x / ArmchairArea_linear);
                                                end
                                            elseif PAT == 2
                                                if lscount == LS
                                                    ZigzagStress                = abs(Force_y / ZigzagArea);
                                                    ZigzagStress_Linear         = abs(Force_y / ZigzagArea_linear);
                                                end
                                            elseif PAT == 3
                                                if lscount == LS
                                                    ArmchairShearStress         = abs(ArmchairShearForce_x / ArmchairShearArea);
                                                    ArmchairShearStress_Linear  = abs(ArmchairShearForce_x / ArmchairLinearShearArea);
                                                end
                                            elseif PAT == 4
                                                if lscount == LS
                                                    ZigzagShearStress           = abs(ZigzagShearForce_y / ZigzagShearArea);
                                                    ZigzagShearStress_Linear    = abs(ZigzagShearForce_y / ZigzagLinearShearArea);
                                                end
                                            end
                                            %---------------------------------------------
                                            % CALCULATE INITIAL MODULUS
                                            if PAT == 1
                                                if lscount == LS
                                                    ArmchairInitialModulus        = ArmchairStress/ArmchairStrain;
                                                    ArmchairInitialModulus_linear = ArmchairStress_Linear/ArmchairStrain;
                                                    fprintf('Armchair intial modulus = %4.4f  GPa  \n', ArmchairInitialModulus)
                                                    fprintf('Armchair intial modulus = %4.4f  GPa-nm  \n', ArmchairInitialModulus_linear)
                                                    fprintf('Total Reaction Force = %4.4f nN \n',Force_x)
                                                    fprintf('Armchair Stiffness = %4.4f nN/nm \n', Force_x/ArmchairDisplacement)
                                                end
                                            elseif PAT == 2
                                                if lscount == LS
                                                    ZigzagInitialModulus          = ZigzagStress/ZigzagStrain;
                                                    ZigzagInitialModulus_linear   = ZigzagStress_Linear/ZigzagStrain;
                                                    fprintf('Zigzag intial modulus = %4.4f  GPa  \n', ZigzagInitialModulus)
                                                    fprintf('Zigzag intial modulus = %4.4f  GPa-nm  \n', ZigzagInitialModulus_linear)
                                                    fprintf('Total Reaction Force = %4.4f nN \n',Force_y)
                                                    fprintf('Zigzag Stiffness = %4.4f nN/n \n', Force_y/ZigzagDisplacement)
                                                end
                                            elseif PAT == 3
                                                if lscount == LS
                                                    ArmchairShearModulus          = ArmchairShearStress/ArmchairSingleShearAngle;
                                                    ArmchairShearModulus_linear   = ArmchairShearStress_Linear/ArmchairSingleShearAngle;
                                                    fprintf('Shear modulus = %4.4f  GPa  \n', ArmchairShearModulus)
                                                    fprintf('Total Shear Reaction Force = %4.4f nN \n',ArmchairShearForce_x)
                                                    fprintf('Armchair Shear Stiffness = %4.4f nN/rad \n', ArmchairShearForce_x/ArmchairSingleShearAngle)
                                                end
                                            elseif PAT == 4
                                                if lscount == LS
                                                    ZigzagShearModulus            = ZigzagShearStress/ZigzagSingleShearAngle;
                                                    ZigzagShearModulus_linear     = ZigzagShearStress_Linear/ZigzagSingleShearAngle;
                                                    fprintf('Shear modulus = %4.4f  GPa  \n', ZigzagShearModulus)
                                                    
                                                    fprintf('Total Shear Reaction Force = %4.4f nN \n',ZigzagShearForce_y)
                                                    fprintf('Zigzag Shear Stiffness = %4.4f nN/rad \n', ZigzagShearForce_y/ZigzagSingleShearAngle)
                                                end
                                            end
                                            %---------------------------------------------
                                            % FIND Dimensions OF THE GRAPHENE SHEET
                                            %Length = 
                                            xmin   = min(NNNCM_ls1(:,2));
                                            xmax   = max(NNNCM_ls1(:,2));
                                            ymin   = min(NNNCM_ls1(:,3));
                                            ymax   = max(NNNCM_ls1(:,3));
                                            length = abs(xmax - xmin);
                                            height = abs(ymax - ymin);
                                            fprintf('NumberOfAtoms = %d   \n', nNodes)
                                            fprintf('Graphene sheet LENGTH = %4.4f nm\n', length)
                                            fprintf('Graphene sheet HEIGHT = %4.4f nm\n', height)
                                            fprintf('Graphene sheet SURFACE AREA = %4.4f nm^2 \n', length*height)
                                            %---------------------------------------------
                                            % WRITE RESULTS TO HARD DISK
                                            % ResultIdentifier, filename_resultData
                                            if PAT == 1
                                                if lscount == LS
                                                    RESULT = [length;
                                                              height;
                                                              ArmchairStrain;
                                                              Force_x;
                                                              Force_y;
                                                              ArmchairArea;
                                                              ArmchairArea_linear;
                                                              ArmchairStress;
                                                              ArmchairStress_Linear;
                                                              ArmchairInitialModulus;
                                                              ArmchairInitialModulus_linear];
                                                          
                                                    dlmwrite(strcat(filename_resultData,'_lscount=',num2str(lscount),'.txt'), RESULT, 'delimiter', '\t')
                                                end
                                            elseif PAT == 2
                                                if lscount == LS
                                                    RESULT = [length;
                                                              height;
                                                              ZigzagStrain;
                                                              Force_x;
                                                              Force_y;
                                                              ZigzagArea;
                                                              ZigzagArea_linear;
                                                              ZigzagStress;
                                                              ZigzagStress_Linear;
                                                              ZigzagInitialModulus;
                                                              ZigzagInitialModulus_linear];
                                                          dlmwrite(strcat(filename_resultData,'_lscount=',num2str(lscount),'.txt'), RESULT, 'delimiter', '\t')
                                                    %SFFO('sfeam','ag', 'wrtd', strcat(filename_resultData,'_'), RESULT, 'loadstep', lscount);
                                                end
                                            elseif PAT == 3
                                                if lscount == LS
                                                    RESULT = [length;
                                                              height;
                                                              ArmchairSingleShearAngle;
                                                              ArmchairShearForce_x;
                                                              ArmchairShearForce_y;
                                                              ArmchairShearArea;
                                                              ArmchairLinearShearArea;
                                                              ArmchairShearStress;
                                                              ArmchairShearStress_Linear;
                                                              ArmchairShearModulus;
                                                              ArmchairShearModulus_linear ];
                                                          dlmwrite(strcat(filename_resultData,'_lscount=',num2str(lscount),'.txt'), RESULT, 'delimiter', '\t')
                                                    %SFFO('sfeam','ag', 'wrtd', strcat(filename_resultData,'_'), RESULT, 'loadstep', lscount);
                                                end
                                            elseif PAT == 4
                                                if lscount == LS
                                                    RESULT = [length;
                                                              height;
                                                              ZigzagSingleShearAngle;
                                                              ZigzagShearForce_x;
                                                              ZigzagShearForce_y;
                                                              ZigzagShearArea;
                                                              ZigzagLinearShearArea;
                                                              ZigzagShearStress;
                                                              ZigzagShearStress_Linear;
                                                              ZigzagShearModulus;
                                                              ZigzagShearModulus_linear ];
                                                          dlmwrite(strcat(filename_resultData,'_lscount=',num2str(lscount),'.txt'), RESULT, 'delimiter', '\t')
%                                                     SFFO('sfeam','ag', 'wrtd', strcat(filename_resultData,'_'), RESULT, 'loadstep', lscount);
                                                end
                                            end
                                            %---------------------------------------------
                                            disp('--------------------------------------------------------')
                                            %---------------------------------------------
                                        end
                                end
                                %--------------------------------------------------------------------------
                        end
                end
            case {'EqGeomMDYes', 'eqgeomyes', 'eqgyes', 'egy', 'eyes', 'ey'} %-----------------------------------\-\-\-\-\-\-\-\-> varagin{2}
        end
    case 'C' %                                       \-\-\-\-\-\-\-\-> varagin{1}
end
 end
