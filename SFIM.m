function [varargout] = SFIM(varargin)
% SFIM: S.MS   F.ORM   I.MPORTANT    M.ATRICES


switch varargin{1}
    case {'sfeam','sf'} % sms finite element analysis module
        switch varargin{2}
            case 'ag' % atomic geometry
                % [NTBC_1] = SFIM('sf', 'ag', 'graphene_NTBC_2d_version01', {'',''}, {NODALCONSTRAIN_OPTION, NNNCM}, {'',''}, {lscount});
                switch varargin{3}
                    case 'graphene_NTBC_2d_version01'
                        NODALCONSTRAIN_OPTION = varargin{5}{1};
                        NNNCM                 = varargin{5}{2};
                        lscount               = varargin{7}{1};
                        switch NODALCONSTRAIN_OPTION
                            case {'yminend.Constrained'}% Task is to find all nodes in the ymin end and constrain them
                                NTBC = find(NNNCM(:,3)==min(NNNCM(:,3)));
                            case 'ymaxend.Constrained'% Task is to find all nodes in the ymax end and constrain them
                                NTBC = find(NNNCM(:,3)==max(NNNCM(:,3)));
                            case 'xminend.Constrained'% Task is to find all nodes in the xmin end and constrain them
                                NTBC = find(NNNCM(:,2)==min(NNNCM(:,2)));
                            case 'xmaxend.Constrained'% Task is to find all nodes in the xmax end and constrain them
                                NTBC = find(NNNCM(:,2)==max(NNNCM(:,2)));
                        end
                        varargout{1} = NTBC;
                    case 'graphene_NTBD_2d_version01'
                        NODALDISP_OPTION = varargin{5}{1};
                        NNNCM            = varargin{5}{2};
                        lscount          = varargin{7}{1};
                        %----------------------------------------------
                        switch NODALDISP_OPTION
                            case 'NoNodesDisplaced'
                                NTBD = [];
                            case 'yminend.Displaced'% Task is to find all nodes in the ymin end and displace them
                                NTBD = find(NNNCM(:,3)==min(NNNCM(:,3)));
                            case 'ymaxend.Displaced'% Task is to find all nodes in the ymax end and displace them
                                NTBD = find(NNNCM(:,3)==max(NNNCM(:,3)));
                            case 'xminend.Displaced'% Task is to find all nodes in the xmin end and displace them
                                NTBD = find(NNNCM(:,2)==min(NNNCM(:,2)));
                            case 'xmaxend.Displaced'% Task is to find all nodes in the xmax end and displace them
                                NTBD = find(NNNCM(:,2)==max(NNNCM(:,2)));
                        end
                        %----------------------------------------------
                        varargout{1} = NTBD;
                    case 'graphene_NTBCD_2d_version01'
                        NTBC = varargin{5}{1};
                        NTBD = varargin{5}{2};
                        %----------------------------------------------
                        NTBCD1 = sort([NTBC; NTBD]);
                        %----------------------------------------------
                        varargout{1} = NTBCD1;
                    case 'graphene_NTBL_2d_version01'
                        NODALLOADING_OPTION = varargin{5}{1};
                        NNNCM               = varargin{5}{2};
                        lscount             = varargin{7}{1};
                        %----------------------------------------------
                        switch NODALLOADING_OPTION
                            case 'yminend.Loaded'% Task is to find all nodes in the ymin end and displace them
                                NTBL = find(NNNCM(:,3)==min(NNNCM(:,3)));
                                NTBL_info = {NTBL};
                            case 'ymaxend.Loaded'% Task is to find all nodes in the ymax end and displace them
                                NTBL = find(NNNCM(:,3)==max(NNNCM(:,3)));
                                NTBL_info = {NTBL};
                            case 'yminANDymaxend.Loaded'
                                NTBLymin  = find(NNNCM(:,3)==min(NNNCM(:,3)));
                                NTBLymax  = find(NNNCM(:,3)==max(NNNCM(:,3)));
                                NTBL      = [NTBLymin;
                                             NTBLymax];
                                NTBLend1  = NTBLymin;
                                NTBLend2  = NTBLymax;
                                NTBL_info = {NTBL, NTBLend1, NTBLend2};
                            case 'xminend.Loaded'% Task is to find all nodes in the xmin end and displace them
                                NTBL = find(NNNCM(:,2)==min(NNNCM(:,2)));
                                NTBL_info = {NTBL};
                            case 'xmaxend.Loaded'% Task is to find all nodes in the xmax end and displace them
                                NTBL = find(NNNCM(:,2)==max(NNNCM(:,2)));
                                NTBL_info = {NTBL};
                            case 'xminANDxmaxend.Loaded'
                                NTBLxmin  = find(NNNCM(:,2)==min(NNNCM(:,2)));
                                NTBLxmax  = find(NNNCM(:,2)==max(NNNCM(:,2)));
                                NTBL      = [NTBLxmin; NTBLxmax];
                                NTBLend1  = NTBLxmin;
                                NTBLend2  = NTBLxmax;
                                NTBL_info = {NTBL, NTBLend1, NTBLend2};
                        end
                        %----------------------------------------------
                        varargout{1} = NTBL_info;
                    case 'nnncm'
                        econA   = varargin{4}{1};
                        lscount = varargin{4}{2};
                        NNNCM = unique([ [econA(:,1) econA(:,3) econA(:,4) econA(:,5)]; [econA(:,2) econA(:,6) econA(:,7) econA(:,8)] ], 'rows');
                        SFFO('sfeam','ag', 'wrtd', 'NNNCM=', NNNCM, 'loadstep', lscount);
                        varargout{1} = NNNCM;
                    case {'NNNCMnew', 'nnncmnew'}
                        % CALCULATE THE NEW NODAL POSITIONS
                        NNNCM = varargin{4}{1};
                        U     = varargin{4}{2};
                        
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
                        varargout{1} = NNNCMnew;
                    case 'U,DispConsMatrix'
                        nNodes = varargin{4}{1};
                        NTBC   = varargin{4}{2};
                        % FORM DISPLACEMENT MATRIX
                        SCMD('seperator','type02',4,1);
                        disp('FORMING DISPLACEMENT MATRIX')
                        DispConsMatrix = [NTBC zeros(size(NTBC)) zeros(size(NTBC))]; % <<<<<--- DISPLACEMENT BOUNMDARY CONDITION
                        U = zeros(nNodes*2,1);
                        U(:) = NaN;
                        for count = 1:size(DispConsMatrix,1)
                            U(2*DispConsMatrix(count,1)-1,1) = DispConsMatrix(count,2);
                            U(2*DispConsMatrix(count,1)  ,1) = DispConsMatrix(count,3);
                        end
                        varargout{1} = U;
                        varargout{2} = DispConsMatrix;
                    case 'U_version02'
                        %[U]       = SFIM('sf','ag','U_version02', {''}, {NdDispLOADING}, {''}, {GDOFlong, GTBC, GTBD, NTBL}, {''}, {lscount});
                        NdDispLOADING = varargin{5}{1};
                        GDOFlong      = varargin{7}{1};
                        GTBC          = varargin{7}{2};
                        GTBD          = varargin{7}{3};
                        NTBD          = varargin{7}{4};
                        NTBL          = varargin{7}{5};
                        Con_GDOF_DisplacedNodes = varargin{8}{1};
                        lscount       = varargin{9}{1};
                        %---------------------------------------------
                        U = zeros(size(GDOFlong));
                        %---------------------------------------------
                        % Implement values of Fixed Constrains in U @ GTBC
                        if numel(GTBC) > 0
                            U(GTBC) = 0;
                        end
                        %Con_GDOF_DisplacedNodes    = {'MoveIn_x-0', 'MoveIn_y-1', 'MoveIn_z-0'}; % Constraints on GDOF of Displaced Nodes
                        if numel(GTBD) > 0
                            U(GTBD) = NdDispLOADING(lscount);
                        end
                        %---------------------------------------------
                        % CORRECT THE IMPOSED DISPLACEMENTS AS PER THE REQUIREMENTS
                        if strcmp(Con_GDOF_DisplacedNodes{1}, 'MoveIn_x-0')
                            for count = 1:numel(NTBD)
                                U(2*NTBD(count)-1) = 0;
                            end
                        end
                        if strcmp(Con_GDOF_DisplacedNodes{2}, 'MoveIn_y-0')
                            for count = 1:numel(NTBD)
                                U(2*NTBD(count)) = 0;
                            end
                        end
                        %---------------------------------------------
                        varargout{1} = U;
                    case 'U,DispConsMatrix_gen'
% [U, DispConsMatrix]       = SFIM('sf','ag','U,DispConsMatrix_gen', {nNodes, NTBC, NODALDISP_OPTION, NdDispLOADING, NTBD}, {lscount});
                        nNodes            = varargin{4}{1};
                        NTBC              = varargin{4}{2};
                        
                        NODALDISP_OPTION  = varargin{4}{3};
                        NdDispLOADING     = varargin{4}{4};
                        NTBD              = varargin{4}{5};
                        
                        lscount           = varargin{5}{1};
                        
                        SCMD('seperator','type02',4,1);
                        disp('FORMING DISPLACEMENT MATRIX')
                        %---------------------------------------------
                        % FIRST: constrain the nodes
                        DispConsMatrix_NTBC = [NTBC zeros(size(NTBC)) zeros(size(NTBC))]; % <<<<<--- DISPLACEMENT BOUNMDARY CONDITION
                        U = zeros(nNodes*2,1);
                        U(:) = NaN;
                        for count = 1:size(DispConsMatrix_NTBC,1)
                            U(2*DispConsMatrix_NTBC(count,1)-1,1) = DispConsMatrix_NTBC(count,2);
                            U(2*DispConsMatrix_NTBC(count,1)  ,1) = DispConsMatrix_NTBC(count,3);
                        end
                        %---------------------------------------------
                        % SECOND: Enforce the necessary nodal displacements
                        DispConsMatrix_NTBD = [NTBD zeros(size(NTBD)) zeros(size(NTBD))];
                        switch NODALDISP_OPTION
                            case 'ymaxend.Displaced'
                                for count = 1:size(NTBD,1)
                                    DispConsMatrix_NTBD(count,3) = NdDispLOADING(lscount); % y-componenet of imposed displacement
                                    U(2*NTBD(count,1)-1,1)       = DispConsMatrix_NTBD(count,2);
                                    U(2*NTBD(count,1)  ,1)       = DispConsMatrix_NTBD(count,3);
                                end
                            case 'yminend.Displaced'
                                for count = 1:size(NTBD,1)
                                    DispConsMatrix_NTBD(count,3) = NdDispLOADING(lscount); % y-componenet of imposed displacement
                                    U(2*NTBD(count,1)-1,1)       = DispConsMatrix_NTBD(count,2);
                                    U(2*NTBD(count,1)  ,1)       = DispConsMatrix_NTBD(count,3);
                                end
                            case 'xmaxend.Displaced'
                                for count = 1:size(NTBD,1)
                                    DispConsMatrix_NTBD(count,2) = NdDispLOADING(lscount); % y-componenet of imposed displacement
                                    U(2*NTBD(count,1)-1,1)       = DispConsMatrix_NTBD(count,2);
                                    U(2*NTBD(count,1)  ,1)       = DispConsMatrix_NTBD(count,3);
                                end
                            case 'xminend.Displaced'
                                for count = 1:size(NTBD,1)
                                    DispConsMatrix_NTBD(count,2) = NdDispLOADING(lscount); % y-componenet of imposed displacement
                                    U(2*NTBD(count,1)-1,1)       = DispConsMatrix_NTBD(count,2);
                                    U(2*NTBD(count,1)  ,1)       = DispConsMatrix_NTBD(count,3);
                                end
                        end
                        DispConsMatrix = [DispConsMatrix_NTBC; DispConsMatrix_NTBD];
                        %-------------------------------------------------------------------------
                        varargout{1} = U;
                        varargout{2} = DispConsMatrix;
                        %-------------------------------------------------------------------------
                    case 'DispAlongNTBL'
%                         [ Displacement_NTBL_x, Displacement_NTBL_y, Displacement_NTBL_VecSum,...
%                             Displacement_NTBL_x_mean, Displacement_NTBL_y_mean ] = SFIM('sf', 'ag', 'DispAlongNTBL',...
%                                                                                         {lscount}, {NNNCM, NNNCMnew, NTBL});
                        
                        lscount  = varargin{4}{1};
                        
                        NNNCM    = varargin{5}{1};
                        NNNCMnew = varargin{5}{2};
                        NTBL     = varargin{5}{3};
                        % CALCULATE DISPLACEMENTS ALONG "NTBL"
                        if lscount == 1
                            NNNCM_FirstLoadStep = NNNCM;
                            SFFO('sfeam','ag', 'wrtd', 'NNNCM_LS=', NNNCM, 'loadstep', lscount);
                        else
                            [NNNCM_FirstLoadStep] = SFFO('sfeam','ag', 'rrfd', {'NNNCM_LS=1'});
                        end
                        Displacement_NTBL_x = NNNCMnew(NTBL,2) - NNNCM_FirstLoadStep(NTBL,2);
                        Displacement_NTBL_y = NNNCMnew(NTBL,3) - NNNCM_FirstLoadStep(NTBL,3);
                        Displacement_NTBL_VecSum = sqrt(Displacement_NTBL_x.^2 + Displacement_NTBL_y.^2);
                        
                        Displacement_NTBL_x_mean = sum(Displacement_NTBL_x)/size(Displacement_NTBL_x,1);
                        Displacement_NTBL_y_mean = sum(Displacement_NTBL_y)/size(Displacement_NTBL_y,1);
                        SFFO('sfeam','ag', 'wrtd', 'Displacement_NTBL_x_LS=', Displacement_NTBL_x, 'loadstep', lscount);
                        SFFO('sfeam','ag', 'wrtd', 'Displacement_NTBL_y_LS=', Displacement_NTBL_y, 'loadstep', lscount);
                        SFFO('sfeam','ag', 'wrtd', 'Displacement_NTBL_VecSum_LS=', Displacement_NTBL_VecSum, 'loadstep', lscount);
                        varargout{1} = Displacement_NTBL_x;
                        varargout{2} = Displacement_NTBL_y;
                        varargout{3} = Displacement_NTBL_VecSum;
                        varargout{4} = Displacement_NTBL_x_mean;
                        varargout{5} = Displacement_NTBL_y_mean;
                    case 'P,NTBL'
                        lscount             = varargin{4}{1};
                        LOADING             = varargin{4}{2};
                        nNodes              = varargin{4}{3};
                        NNNCM               = varargin{4}{4};
                        NODALLOADING_OPTION = varargin{4}{5};
                        
                        % FORM LOAD VECTOR
                        SCMD('seperator','type02',4,1);
                        disp('FORMING LOAD VECTOR')
                        if lscount == 1
                            P = zeros(nNodes*2,1);
                        else
                            P = varargin{5}{1};
                        end
                        if lscount == 1
%                             NTBL = find(temp==max(NNNCM(:,3)));
                            switch NODALLOADING_OPTION
                                case 'ymaxend.Loaded'
                                    temp = NNNCM(:,3);
                                    NTBL = find(temp==max(NNNCM(:,3)));
                                case 'yminend.Loaded'
                                    temp = NNNCM(:,3);
                                    NTBL = find(temp==min(NNNCM(:,3)));
                                case 'xmaxend.Loaded'
                                    temp = NNNCM(:,2);
                                    NTBL = find(temp==max(NNNCM(:,2)));
                                case 'xminend.Loaded'
                                    temp = NNNCM(:,2);
                                    NTBL = find(temp==min(NNNCM(:,2)));
                                case 'GraphicalSelection'
                                    disp('NOT YET FUNCTIONAL')
                            end
                        else
                            NTBL = varargin{5}{2};
                        end
                        switch NODALLOADING_OPTION
                            case 'ymaxend.Loaded'
                                LoadingMatrix = [ NTBL zeros(size(NTBL)) repmat(LOADING(lscount,1),size(NTBL)) ];
                            case 'yminend.Loaded'
                                LoadingMatrix = [ NTBL zeros(size(NTBL)) repmat(LOADING(lscount,1),size(NTBL)) ];
                            case 'xmaxend.Loaded'
                                LoadingMatrix = [ NTBL repmat(LOADING(lscount,1),size(NTBL)) zeros(size(NTBL)) ];
                            case 'xminend.Loaded'
                                LoadingMatrix = [ NTBL repmat(LOADING(lscount,1),size(NTBL)) zeros(size(NTBL)) ];
                            case 'GraphicalSelection'
                                disp('NOT YET FUNCTIONAL')
                        end
                        if lscount == 1
                            for count = 1:size(LoadingMatrix,1)
                                P(2*LoadingMatrix(count,1)-1,1) = LoadingMatrix(count,2);
                                P(2*LoadingMatrix(count,1)  ,1) = LoadingMatrix(count,3);
                            end
                        end
                        varargout{1} = P;
                        varargout{2} = NTBL;
                    case 'P_and_NTBL_version02'
                        %------------------------------------------
                        lscount             = varargin{4}{1};
                        LOADING             = varargin{4}{2};
                        nNodes              = varargin{4}{3};
                        NNNCM               = varargin{4}{4};
                        NODALLOADING_OPTION = varargin{4}{5};
                        %------------------------------------------
                        SCMD('seperator','type02',4,1);
                        disp('FORMING LOAD VECTOR - using version 02')
                        
                        
                        %------------------------------------------
                        varargout{1} = 0;
                        varargout{2} = 0;
                        %------------------------------------------
                    case 'Update_econA'
                        %[econA] = SFIM('sf', 'ag', 'Update_econA', {'',''}, {econA, U, GDOFlong});
                        econA    = varargin{5}{1};
                        U        = varargin{5}{2};
                        GDOFlong = varargin{5}{3};
                        
                        lscount  = varargin{7}{1};
                        %-----------------------------------------
                        NumberOfElements = size(econA,1);
%                         if lscount == 2
%                             econA
%                         end
                        for count = 1:NumberOfElements
                            %----------------------
                            node1 = econA(count,1);
                            node2 = econA(count,2);
                            %----------------------
                            node1_gdofx = 2*node1 - 1;
                            node1_gdofy = 2*node1    ;
                            
                            node2_gdofx = 2*node2 - 1;
                            node2_gdofy = 2*node2    ;
                            %----------------------
                            xnode1    = econA(count,3);
                            ynode1    = econA(count,4);
                            %----------------------
                            xnode2    = econA(count,6);
                            ynode2    = econA(count,7);
                            %----------------------------------------
                            node1_gdofx_displacement = U(find(GDOFlong == node1_gdofx)); % pos: position
                            node1_gdofy_displacement = U(find(GDOFlong == node1_gdofy));
                            %----------------------
                            node2_gdofx_displacement = U(find(GDOFlong == node2_gdofx)); % pos: position
                            node2_gdofy_displacement = U(find(GDOFlong == node2_gdofy));
                            %----------------------------------------
                            %Now updating the econA matrix
                              %FOR NODE 1
                               econA(count,3) = xnode1 + node1_gdofx_displacement;
                               econA(count,4) = ynode1 + node1_gdofy_displacement;
                              %FOR NODE 2
                               econA(count,6) = xnode2 + node2_gdofx_displacement;
                               econA(count,7) = ynode2 + node2_gdofy_displacement;
                            %----------------------------------------
                        end
                        %-----------------------------------------
                        varargout{1} = econA;
%                         if lscount == 2
%                             econA
%                         end
                        %-----------------------------------------
                    case 'Update_NNNCM'
%                        [NNNCM] = SFIM('sf','ag','Update_NNNCM', {'',''}, {NNNCM, U, GDOFlong}, {'','',}, {lscount});
                        %-----------------------------------
                        NNNCM    = varargin{5}{1};
                        U        = varargin{5}{2};
                        GDOFlong = varargin{5}{3};
                        
                        lscount  = varargin{7}{1};
                        
                        
                        NNNCM
                        %-----------------------------------
                        varargout{1} = NNNCM;
                        %-----------------------------------
                    case 'IEI_version02'
                        econA    = varargin{5}{1};
                        BP_Morse = varargin{6}{1};
                        BP_LJ    = varargin{6}{2};
                        lscount  = varargin{7}{1};
                        LS       = varargin{7}{2};
                        WTD      = varargin{7}{3};
                        %-----------------------------
                        lscount = varargin{7}{1};
                        if lscount > 1
                            % FILL THIS UP
                        end
                        IEI = econA(:,1:2);
                        
                        %-----------------------------
                        IEI                 = 0;
                        ElDef               = 0;
                        LengthOfElements    = 0;
                        %-----------------------------
                        varargout{1} = IEI;
                        varargout{2} = ElDef;
                        varargout{3} = LengthOfElements;
                        %-----------------------------
                    case 'IEI'
                        econA   = varargin{5}{1};
                        
                        MP_beta = varargin{6}{1};
                        MP_De   = varargin{6}{2};
                        LJ_eps  = varargin{6}{3};
                        LJ_sig  = varargin{6}{4};
                        
                        lscount = varargin{7}{1};
                        if lscount > 1
                            ElDef = varargin{5}{2};
                            LengthOfElements = varargin{5}{3};
                        end
                        WTD     = varargin{8}{1};
                        %----------------------------------------------------------------------
                        IEI = econA(:,1:2); %    I.ndividual    E.lement    I.nformation..     Format of "IEI":
                        %   1     2     3             4        5               6         7               8      9      10            11     12     13         14
                        % [ ElNum Nodei Nodej         BondType Stiffness       DireCos_l DireCos_m       xNodei yNodei znodei        xNodej yNodej znodej     delr    EleLen]
                        %------------------------------------------------------
                        IEI   = [(1:1:size(econA,1))' IEI econA(:,size(econA,2)) zeros(size(econA,1),1)];
                        %------------------------------------------------------
                        % The last column in the above "ES" stores stiffness values.
                        EleLenM = sqrt( (econA(:,6) - econA(:,3)).^2 + (econA(:,7) - econA(:,4)).^2 + (econA(:,8) - econA(:,5)).^2 ); % E.lement L.ength M.atrix
                        dclm    = (econA(:,6) - econA(:,3))./EleLenM; % direction coine "l" matrix
                        dcmm    = (econA(:,7) - econA(:,4))./EleLenM; % direction coine "m" matrix
                        IEI     = [IEI dclm dcmm econA(:,3:size(econA,2)-1)]; % Assemble Direction Cosines inside " IEI " matrix
                        %------------------------------------------------------
                        LengthOfElements{lscount,1} = [ IEI(:,1) EleLenM ];
                        SFFO('sfeam','ag', 'wrtd', 'Individual.Element.Lengths.LS=', LengthOfElements{lscount, 1}, 'loadstep', lscount); % Write IEI to disk
                        if lscount == 1
                            ElDef{lscount,1} = [IEI(:,1) zeros(size(EleLenM))]; % UNITS: nm
                        else
                            ElDef{lscount,1} = [IEI(:,1) LengthOfElements{lscount,1}(:,2) - LengthOfElements{lscount-1,1}(:,2)]; % UNITS: nm
                        end
                        %---------------------------------------------------
                        ESsz1 = size(IEI,1);
                        if lscount == 1
                            for count = 1:ESsz1
                                delr = ElDef{lscount,1}(count,2);
                                if IEI(count, 4) == 1     % USE MORSE POTENTIAL HERE.                                    
                                    IEI(count, 5) = 2 * MP_beta^2 * MP_De * (2*exp(-2*MP_beta * delr) - exp(-2*MP_beta * delr) );
                                elseif IEI(count, 4) == 2 % USE LENNARD JONES HERE.
                                    IEI(count, 5) = 24*(LJ_eps / (LJ_sig^2)) * ( 26*( LJ_sig/(EleLenM(count,1) + delr) )^14 - 7*( LJ_sig/(EleLenM(count,1) + delr) )^8 );
                                elseif IEI(count, 4) == 3 % USE LENNARD JONES HERE.
                                    IEI(count, 5) = 24*(LJ_eps / (LJ_sig^2)) * ( 26*( LJ_sig/(EleLenM(count,1) + delr) )^14 - 7*( LJ_sig/(EleLenM(count,1) + delr) )^8 );
                                end
                            end
                        else
                            for count = 1:ESsz1
                                delr = ElDef{lscount,1}(count,2);
                                if IEI(count, 4) == 1 % USE MORSE POTENTIAL HERE.
                                    IEI(count, 5) = 2 * MP_beta^2 * MP_De * (2*exp(-2*MP_beta * delr) - exp(-2*MP_beta * delr) );
                                elseif IEI(count, 4) == 2 % USE LENNARD JONES HERE.
                                    IEI(count, 5) = 24*(LJ_eps / (LJ_sig^2)) * ( 26*( LJ_sig/(EleLenM(count,1) + delr) )^14 - 7*( LJ_sig/(EleLenM(count,1) + delr) )^8 );
                                elseif IEI(count, 4) == 3 % USE LENNARD JONES HERE.
                                    IEI(count, 5) = 24*(LJ_eps / (LJ_sig^2)) * ( 26*( LJ_sig/(EleLenM(count,1) + delr) )^14 - 7*( LJ_sig/(EleLenM(count,1) + delr) )^8 );
                                end
                            end
                        end
                        %IEI(count, 5)
                        %------------------------------------------------------
                        if WTD == 1
                            SFFO('sfeam','ag', 'wrtd', 'Individual.Element.Information..LS=', IEI, 'loadstep', lscount); % Write IEI to disk
                        end
                        %------------------------------------------------------
                        % Update 14th column of IEI with element deformation
                        IEI = [IEI ElDef{lscount,1}(:,2)];
                        %------------------------------------------------------
                        % Update 15th column of IEI with element length values
                        IEI = [IEI  EleLenM];
                        %------------------------------------------------------
                        varargout{1} = IEI;
                        varargout{2} = ElDef;
                        varargout{3} = LengthOfElements;
                        %------------------------------------------------------
                    case 'FormGDOF_CDL_2d_version01'
                        NTBC                     = varargin{5}{1};
                        NTBD                     = varargin{5}{2};
                        NTBCD                    = varargin{5}{3};
                        NTBL                     = varargin{5}{4};
                        Con_GDOF_DisplacedNodes  = varargin{6}{1};
                        
                        
% Con_GDOF_DisplacedNodes    = {'CannotMoveIn_x', 'CanMoveIn_y', 'CannotMoveIn_z'}
                        
                        GTBC = zeros(2*size(NTBC,1),1);
                        GTBD = zeros(2*size(NTBD,1),1);
                        GTBL = zeros(2*size(NTBL,1),1);
                        %------------------------------------------
                        for count = 1:size(NTBC,1)
                            GTBC(2*count-1,1) = 2*NTBC(count,1)-1;
                            GTBC(2*count  ,1) = 2*NTBC(count,1)  ;
                        end
                        %------------------------------------------
                        for count = 1:size(NTBD,1)
                            GTBD(2*count-1,1) = 2*NTBD(count,1)-1;
                            GTBD(2*count  ,1) = 2*NTBD(count,1)  ;
                        end
                        %------------------------------------------
                        for count = 1:size(NTBL,1)
                            if strcmp(Con_GDOF_DisplacedNodes{1}, 'CannotMoveIn_x') == 1
                                GTBL(2*count-1,1) = 2*NTBL(count,1)-1;
                            end
                            if strcmp(Con_GDOF_DisplacedNodes{1}, 'CannotMoveIn_y') == 1
                                GTBL(2*count  ,1) = 2*NTBL(count,1)  ;
                            end
                        end
                        %------------------------------------------
                        GTBCD = zeros(2*size(NTBCD,1),1); % GDOF of Constrained as well as Displaced nodes
                        for count = 1:size(NTBCD)
                            GTBCD(2*count-1) = 2*NTBCD(count,1)-1;
                            GTBCD(2*count  ) = 2*NTBCD(count,1)  ;
                        end
                        %------------------------------------------
                        varargout{1} = GTBC;
                        varargout{2} = GTBD;
                        varargout{3} = GTBCD;
                        varargout{4} = GTBL;
                    case 'FormGDOF_CDL_2d_version02'
                        NTBC                      = varargin{5}{1};
                        NTBD                      = varargin{5}{2};
                        NTBCD                     = varargin{5}{3};
                        NTBL                      = varargin{5}{4};
                            NODALCONSTRAIN_OPTION     = varargin{6}{1};
                            NODALDISP_OPTION          = varargin{6}{2};
                            DiplacedAlong             = varargin{6}{3};
                            NODALLOADING_OPTION       = varargin{6}{4};
                        Con_GDOF_ConstrainedNodes = varargin{7}{1};
                        Con_GDOF_DisplacedNodes   = varargin{7}{2};
                        Con_GDOF_LoadedNodes      = varargin{7}{3};
                        NatureOfDispLoading       = varargin{8}{1};
                        NatureOfLoading           = varargin{8}{2};
                        lscount                   = varargin{10}{1};
                        LS                        = varargin{10}{2};
                        % Con_GDOF_ConstrainedNodes  = {'CannotMoveIn_x', 'CannotMoveIn_y', 'CannotMoveIn_z'}; % Constraints on GDOF of Constrained Nodes
                        % Con_GDOF_DisplacedNodes    = {'CanMoveIn_x'   , 'CanMoveIn_y'   , 'CannotMoveIn_z'}; % Constraints on GDOF of Displaced Nodes
                        % Con_GDOF_LoadedNodes       = {'LoadedIn_x'    , 'NotLoadedIn_y' , 'NotLoadedIn_z'} ; % Constraints on GDOF of Loaded Nodes
                        %------------------------------------------
                        Nd_Cons_X = Con_GDOF_ConstrainedNodes{1};  % OPTIONS: 'CannotMoveIn_x', 'CanMoveIn_x'
                        Nd_Cons_Y = Con_GDOF_ConstrainedNodes{2};  % OPTIONS: 'CannotMoveIn_y', 'CanMoveIn_y'
                       %Nd_Cons_Z = Con_GDOF_ConstrainedNodes{3};  % OPTIONS: 'CannotMoveIn_z', 'CanMoveIn_z' -- Not necessary for 2D(x,y)
                        Nd_Cons_Stabilize = Con_GDOF_ConstrainedNodes{4}; % OPTIONS: 'Stabilize', 'DontStabilize'
                            Nd_Disp_X = Con_GDOF_DisplacedNodes{1};     % OPTIONS: 'CannotMoveIn_x', 'CanMoveIn_x'
                            Nd_Disp_Y = Con_GDOF_DisplacedNodes{2};     % OPTIONS: 'CannotMoveIn_y', 'CanMoveIn_y'
                           %Nd_Disp_Z = Con_GDOF_DisplacedNodes{3};     % OPTIONS: 'CannotMoveIn_z', 'CanMoveIn_z' -- Not necessary for 2D(x,y)
                        Nd_Load_X = Con_GDOF_LoadedNodes{1};       % OPTIONS: 'LoadedIn_x', 'NotLoadedIn_x'
                        Nd_Load_Y = Con_GDOF_LoadedNodes{2};       % OPTIONS: 'LoadedIn_y', 'NotLoadedIn_y'
                       %Nd_Load_Z = Con_GDOF_LoadedNodes{3};       % OPTIONS: 'LoadedIn_z', 'NotLoadedIn_z' -- Not necessary for 2D(x,y)
                        %------------------------------------------
                        %                 G T B C
                        if numel(NTBC)>0
                            GTBC = zeros( 2*numel(NTBC) , 1 ); % THIS IS FOR 2D
                            switch Nd_Cons_X
                                case 'MoveIn_x-0'
                                    for count = 1:numel(NTBC)
                                        GTBC(2*count-1) = 2*NTBC(count)-1;
                                    end
                            end
                            switch Nd_Cons_Y
                                case 'MoveIn_y-0'
                                    for count = 1:numel(NTBC)
                                        GTBC(2*count) = 2*NTBC(count);
                                    end
                            end
                            switch Nd_Cons_Stabilize
                                case 'Stabilize'
                                    % Constrain any one of the NTBL along all GDOFs
                                    GTBC(1) = 2*NTBC(1)-1;
                                    GTBC(2) = 2*NTBC(1)  ;
                            end
                            GTBC(GTBC==0) = [];
                        else
                            GTBC = [];
                        end
                        %------------------------------------------
                        %                 G T B D
                        if numel(NTBD) > 0
                            GTBD = zeros( 2*numel(NTBD) , 1 ); % THIS IS FOR 2D. For 3D, i should use: 3*numel(..)..
                            switch DiplacedAlong
                                case 'y' % GDOF-along-y   is the default. % Hence, Nd_Disp_Y is not used here, but only Nd_Disp_X is used
                                    for count = 1:numel(NTBD)
                                        GTBD(2*count,1) = 2*NTBD(count); % GDOF-along-y   is implemented here
                                    end
                                    if strcmp(Nd_Disp_X,'MoveIn_x-0') == 1 % If GDOF along x is also fixed then this is needed
                                        for count = 1:numel(NTBD)
                                            GTBD(2*count-1,1) = 2*NTBD(count)-1;
                                        end
                                    end
                                case 'x'% GDOF-along-x   is the default. % Hence, Nd_Disp_X is not used here, but only Nd_Disp_Y is used
                                    for count = 1:numel(NTBD)
                                        GTBD(2*count-1,1) = 2*NTBD(count)-1; % GDOF-along-x   is implemented here
                                    end
                                    if strcmp(Nd_Disp_Y,'MoveIn_y-0') == 1 % If GDOF along x is also fixed then this is needed
                                        for count = 1:numel(NTBD)
                                            GTBD(2*count,1) = 2*NTBD(count);
                                        end
                                    end
                            end
                            GTBD(GTBD==0) = [];
                        else
                            GTBD = [];
                        end
                        %------------------------------------------
                        %                 G T B L
                        %Con_GDOF_LoadedNodes       = {'LoadIn_x-1', 'LoadIn_y-0', 'LoadIn_z-0'}; % Constraints on GDOF of Loaded Nodes
                        if numel(NTBL) > 0
                            GTBL = zeros(2*numel(NTBL),1);
                            LoadingCurve   = NatureOfLoading{1};
                            LoadingInitial = NatureOfLoading{2};
                            LoadingFinal   = NatureOfLoading{3};
                            switch LoadingCurve
                                case 'c'
                                    LSLoading = zeros(LS, 1);
                                    for count = 1:numel(LSLoading)
                                        LSLoading(count,1) = LoadingInitial;
                                    end
                            end
                        end
                        if sum(LSLoading)==0
                            GTBL = [];
                        else
                            if strcmp(Nd_Load_X,'LoadIn_x-1')==1
                                for count = 1:numel(NTBL)
                                    GTBL(2*count-1, 1) = 2*NTBL(count)-1;
                                end
                            end
                            if strcmp(Nd_Load_Y,'LoadIn_y-1')==1
                                for count = 1:numel(NTBL)
                                    GTBL(2*count, 1) = 2*NTBL(count);
                                end
                            end
                            GTBL(GTBL==0)=[];
                        end
                        %------------------------------------------
                        %                 G T B C D
                        GTBCD = [GTBC; GTBD];
                        %------------------------------------------
                        varargout{1} = GTBC;
                        varargout{2} = GTBD;
                        varargout{3} = GTBCD;
                        varargout{4} = GTBL;
                    case 'IEM,EleLenM'
                       %[IEI, EleLenM] = SFIM('sf', 'ag', 'IEM,EleLenM', 1, {econA, lscount, LengthOfElements});
                        WTD              = varargin{4};
                        econA            = varargin{5}{1};
                        lscount          = varargin{5}{2};
                        LengthOfElements = varargin{5}{3};
                        % Form individual element information matrix (" IEI ")
                        SCMD('seperator', 'type02', 4, 1);
                        disp('FORMING ELEMENT INFORMATION MATRIX')
                        clear IEI
                        IEI = econA(:,1:2); %    I.ndividual    E.lement    I.nformation
                        % Format of "IEI":: see 2 lines below
                        %   1     2     3     4        5         6         7         8      9      10     11
                        % [ ElNum Nodei Nodej BondType Stiffness DireCos_l DireCos_m xNodei yNodei xNodej yNodej ]
                        IEI   = [(1:1:size(econA,1))' IEI econA(:,size(econA,2)) zeros(size(econA,1),1)];
                        ESsz1 = size(IEI,1);
                        ESsz2 = size(IEI,2);
                        % The last column in the above "ES" stores stiffness values.
                        EleLenM = sqrt( (econA(:,6) - econA(:,3)).^2 + (econA(:,7) - econA(:,4)).^2 ); % E.lement L.ength M.atrix
                        dclm    = (econA(:,6) - econA(:,3))./EleLenM; % direction coine "l" matrix
                        dcmm    = (econA(:,7) - econA(:,4))./EleLenM; % direction coine "m" matrix
                        IEI     = [IEI dclm dcmm econA(:,3:size(econA,2)-1)]; % Assemble Direction Cosines inside " IEI " matrix
                        % Next 2 lines are only for "2-D FEA-only'... NOT for "2-D FEA-MD", "3-D FEA-only" and "3-D FEA".
                        IEI(:, size(IEI,2)-3) = []; % Remove z-coordinates of Nodei
                        IEI(:, size(IEI,2))   = []; % Remove z-coordinates of Nodej
                        LengthOfElements{lscount,1} = [ IEI(:,1) EleLenM ];
                        SFFO('sfeam','ag', 'wrtd', 'Individual.Element.Lengths.LS=', LengthOfElements{lscount, 1}, 'loadstep', lscount); % Write IEI to disk
                        if lscount == 1
                            ElDef{lscount,1} = [IEI(:,1) zeros(size(EleLenM))]; % UNITS: nm
                        else
                            ElDef{lscount,1} = [IEI(:,1) LengthOfElements{lscount,1}(:,2) - LengthOfElements{lscount-1,1}(:,2)]; % UNITS: nm
                        end
                        %---------------------------------------------
                        MP_beta = 26.25;
                        MP_De   = 0.603105;
                        LJ_eps = 3.825*10^-4;
                        LJ_sig = 0.34;
                        if lscount == 1
                            for count = 1:ESsz1
                                delr = ElDef{lscount,1}(count,2);
                                if IEI(count, ESsz2-1) == 1     % USE MORSE POTENTIAL HERE.
                                    IEI(count, ESsz2) = 2 * MP_beta^2 * MP_De * (2*exp(-2*MP_beta * delr) - exp(-2*MP_beta * delr) );
                                elseif IEI(count, ESsz2-1) == 2 % USE LENNARD JONES HERE.
                                    IEI(count, ESsz2) = 24*(LJ_eps / (LJ_sig^2)) * ( 26*( LJ_sig/(EleLenM(count,1) + delr) )^14 - 7*( LJ_sig/(EleLenM(count,1) + delr) )^8 );
                                elseif IEI(count, ESsz2-1) == 3 % USE LENNARD JONES HERE.
                                    IEI(count, ESsz2) = 24*(LJ_eps / (LJ_sig^2)) * ( 26*( LJ_sig/(EleLenM(count,1) + delr) )^14 - 7*( LJ_sig/(EleLenM(count,1) + delr) )^8 );
                                end
                            end
                        else
                            for count = 1:ESsz1
                                delr = ElDef{lscount,1}(count,2);
                                if IEI(count, ESsz2-1) == 1 % USE MORSE POTENTIAL HERE.
                                    IEI(count, ESsz2) = 2 * MP_beta^2 * MP_De * (2*exp(-2*MP_beta * delr) - exp(-2*MP_beta * delr) );
                                elseif IEI(count, ESsz2-1) == 2 % USE LENNARD JONES HERE.
                                    IEI(count, ESsz2) = 24*(LJ_eps / (LJ_sig^2)) * ( 26*( LJ_sig/(EleLenM(count,1) + delr) )^14 - 7*( LJ_sig/(EleLenM(count,1) + delr) )^8 );
                                elseif IEI(count, ESsz2-1) == 3 % USE LENNARD JONES HERE.
                                    IEI(count, ESsz2) = 24*(LJ_eps / (LJ_sig^2)) * ( 26*( LJ_sig/(EleLenM(count,1) + delr) )^14 - 7*( LJ_sig/(EleLenM(count,1) + delr) )^8 );
                                end
                            end
                        end
                        if WTD == 1
                            SFFO('sfeam','ag', 'wrtd', 'Individual.Element.Information..LS=', IEI, 'loadstep', lscount); % Write IEI to disk
                        end
                        %IEI
                        % Format of "IEI":: see 2 lines below
                        %        1     2     3     4        5         6         7         8      9      10     11
                        % IEI =[ ElNum Nodei Nodej BondType Stiffness DireCos_l DireCos_m xNodei yNodei xNodej yNodej ]
                        varargout{1} = IEI;
                        varargout{2} = EleLenM;
                    case 'kmil'
                        WTD     = varargin{4};
                        IEI     = varargin{5}{1};
                        nEle    = varargin{5}{2};
                        lscount = varargin{5}{3};
                        % STIFFNESS MATRIX OF INDIVIDUAL ELEMENTS IN LOCAL COORDINATE SYSTEM
                        % stiffness = (Young's modulus * area / length) * [1 -1;-1 1]
                        % here, unite os (inside brackets) is (nN/nm^2  * nm^2 / nm) = nN / nm
                        % That is the units of stiffness. So, we can directly use the stiffness obtained from potential functions
                        kil  = IEI(:,5);      % k.         of i.ndividual in l.ocal co. sys.
                        %0000000-0000000-0000000-0000000-0000000-0000000-0000000
                        %IEI
                        %IEI(:,5) = IEI(:,5)./EleLenM; % <------------------------<<<<<<<<<<< IS THIS NEEDED ??..
                        %IEI
                        %0000000-0000000-0000000-0000000-0000000-0000000-0000000
                        kmil = zeros(2*nEle,3); % k. m.atrix of i.ndividual in l.ocal co. sys.
                        for count = 1:nEle
                            temp  = kil(count,1) * [ +1 -1;
                                                     -1 +1; ];
                            kmil_count = 2*count;
                            kmil(kmil_count-1:kmil_count,:) = [repmat(IEI(count,1),2,1) temp];
                        end
                        % format of kmil:
                        % [ 1 elelocal(1,1) elelocal(1,2)
                        %   1 elelocal(2,1) elelocal(2,2) \\\ end of info of element no 1
                        %   2 elelocal(1,1) elelocal(1,2)
                        %   2 elelocal(2,1) elelocal(2,2) ... so on ]
                        varargout{1} = kmil;
                        if WTD == 1
                            SFFO('sfeam','ag', 'wrtd', 'Individual.Element.Stiffness.LCS..LS=', kmil, 'loadstep', lscount); % Write kmil to disk
                        end
                    case 'GDOF'
                        % CALCULATE GLOBAL DOFs
                        nNodes = varargin{5}{1};
                        Nodes  = varargin{5}{2};
                        SCMD('seperator','type02',4,1);
                        disp('CALCULATING GLOBAL DEGREES OF FREEDOM')
                        % REFER chandrupatla. Fig.E4.1, Pg. 108 and last paragraph in Pg. 109
                        GDOF = zeros(nNodes,3);
                        for count = 1:nNodes
                            GDOF(count,:) = [Nodes(count) 2*count-1 2*count];
                        end
                                                    GDOFlong = zeros(2*size(GDOF,1),1);
                                                    for count = 1:size(GDOF,1)
                                                        GDOFlong(2*count-1) = GDOF(count,2);
                                                        GDOFlong(2*count  ) = GDOF(count,3);
                                                    end
                        varargout{1} = GDOF;
                        varargout{2} = GDOFlong;
                    case 'kmig'
                        WTD     = varargin{4};
                        IEI     = varargin{5}{1};
                        nEle    = varargin{5}{2};
                        kmil    = varargin{5}{3};
                        lscount = varargin{5}{4};
                        % STIFFNESS MATRIX OF INDIVIDUAL ELEMENTS IN GLOBAL COORDINATE SYSTEM
                        SCMD('seperator','type02',4,1);
                        disp('STIFFNESS MATRIX OF INDIVIDUAL ELEMENTS IN GLOBAL COORDINATE SYSTEM')
                        kmig = zeros(nEle*4, 7); % k. m.atrix of i.ndividual in g.lobal co. sys.
                        for count = 1:nEle
                            TransMat = [ IEI(count,6) IEI(count,7) 0            0            ;
                                0            0            IEI(count,6) IEI(count,7) ]; % TRANSFORMATION MATRIX
                            kmil_count = 2*count;
                            kmig_count = 4*count;
                            kmig(kmig_count-3:kmig_count,:) = [ repmat(IEI(count,1),4,1) repmat(IEI(count,2),4,1) repmat(IEI(count,3),4,1) TransMat'*kmil(kmil_count-1:kmil_count,size(kmil,2)-1:size(kmil,2))*TransMat ];
                            % the repmat stuff in above line is to write the elem number insoide kmig
                        end
                        %kmig
                        if WTD == 1
                            SFFO('sfeam','ag', 'wrtd', 'Individual.Element.Stiffness.GCS..LS=', kmig, 'loadstep', lscount); % Write kmig to disk
                        end
                        % format of kmig:
                        %   1         2     3     4              5              6              7
                        % [ Elem.No=1 Nodei Nodej eleglobal(1,1) eleglobal(1,2) eleglobal(1,3) eleglobal(1,4)
                        %   Elem.No=1 Nodei Nodej eleglobal(2,1) eleglobal(2,2) eleglobal(2,3) eleglobal(2,4)
                        %   Elem.No=1 Nodei Nodej eleglobal(3,1) eleglobal(3,2) eleglobal(3,3) eleglobal(3,4)
                        %   Elem.No=1 Nodei Nodej eleglobal(4,1) eleglobal(4,2) eleglobal(4,3) eleglobal(4,4) \\\ end of info of element 1
                        %   Elem.No=2 Nodei Nodej eleglobal(1,1) eleglobal(1,2) eleglobal(1,3) eleglobal(1,4)
                        %   Elem.No=2 Nodei Nodej eleglobal(2,1) eleglobal(2,2) eleglobal(2,3) eleglobal(2,4)
                        %   Elem.No=2 Nodei Nodej eleglobal(3,1) eleglobal(3,2) eleglobal(3,3) eleglobal(3,4)
                        %   Elem.No=2 Nodei Nodej eleglobal(4,1) eleglobal(4,2) eleglobal(4,3) eleglobal(4,4) ... so on ]
                        varargout{1} =  kmig;
                    case 'exkmig'
                        WTD     = varargin{4}{1};
                        IEI     = varargin{5}{1};
                        nEle    = varargin{5}{2};
                        kmig    = varargin{5}{3};
                        GDOF    = varargin{5}{4};
                        lscount = varargin{5}{5};
                        % Form ex.tended  k. m.atrix of i.ndividual in g.lobal co. sys
                        exkmig = zeros(5*nEle,6);% ex.tended kmig
                        for count = 1:nEle
                            element     = IEI(count,1);
                            kmigcount   = 4*count;
                            k           = kmig(kmigcount-3:kmigcount, size(kmig,2)-3:size(kmig,2));
                            temp        = [GDOF(IEI(element,2),2:3) GDOF(IEI(element,3),2:3)];
                            k_with_gdof = [ [NaN; temp'] [temp; k] ];
                            exkmigcount = 5 * count;
                            exkmig(exkmigcount-4:exkmigcount,:) = [repmat(IEI(count,1),5,1) k_with_gdof];
                        end
                        if WTD == 1
                            SFFO('sfeam','ag', 'wrtd', 'Individual.Ex.Element.Stiffness.GCS..LS=', exkmig, 'loadstep', lscount); % Write exkmig to disk
                        end
                        varargout{1} = exkmig;
                end
            case 'cont2D'
        end
    case 'ssam' % sms simulated annealuing module
    case 'smdm' % sms molecular dynamics module
end
end