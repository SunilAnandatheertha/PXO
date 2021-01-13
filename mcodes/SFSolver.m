function [varargout] = SFSolver(varargin)

switch varargin{1}
    case 'UDMS'
        % UDMS -- Use Default Matlab Solver
        SCMD('seperator','type02',4,1);
        disp('........... S O L V I N G ...........')
        switch varargin{2}{1}
            case 'nf'
                %Example:  [DISPLACEMENTS, Forces] = SFSolver('UDMS', {'', ''}, {GSMae, Pae, Uae});
                GSMae = varargin{3}{1};
                Pae   = varargin{3}{2};
                Uae   = varargin{3}{3};
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
                varargout{1} = DISPLACEMENTS;
                varargout{2} = Forces;
                temp_PAUSE_exec(0, 0.001)
            case 'nd.and.nf' % V1: version1
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                version = varargin{2}{2};
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                if version == 6
                    GSM      = varargin{3}{1};
                    U        = varargin{3}{2};
                    P        = varargin{3}{3};
                    GDOFlong = varargin{4}{1};
                    GTBC     = varargin{4}{2};
                    GTBD     = varargin{4}{3};
                    GTBCD    = varargin{4}{4};
                    GTBL     = varargin{4}{5};
                    lscount  = varargin{6}{1};
                    %---------------------------------------
                    Pnew        = P;
                    NodalForces = P;
                    %---------------------------------------
                    % Rows belonging to Constrained and Displaced nodes are removed
                    GSM1 = GSM;
                    GSM1(GTBCD, :) = [];
                    Pnew(GTBCD, :) = [];
                    %---------------------------------------
                            %----------------------
                            %----------------------
                                        % CALCULATE " GNBCD "
                                        % GDof Not Belonging to Constrained and Displaced nodes
                                        a = zeros(size(GDOFlong));
                                        for count = 1:numel(GTBCD);
                                            a = a + (GDOFlong == repmat(GTBCD(count), size(GDOFlong,1), 1));
                                        end
                                        GNBCD = find(a==0);
                            %----------------------
                            %----------------------
                    for countGSMrow = 1:size(GSM1,1) % NOTE: the new size(GSM,1) is different due to row elimination
                        GSMextract = GSM1(countGSMrow, GTBCD);
                        Uextract   = U(GTBCD,1);
                        Pnew(countGSMrow)       =       Pnew(countGSMrow) - sum(sum( GSMextract.*Uextract' ));
                    end
                    %---------------------------------------
                    % Update force vector
                    NodalForces(GNBCD) = Pnew;
                    %---------------------------------------
                    % elimnate columns in GSMexatrct
                    GSM1(:, GTBCD)  = [];
                    %---------------------------------------
                    % SOLVE FOR THE DISPLACEMENTS OF THE NODES WHICH ARE NEITHER CONSTREAINED NOT DISPLACED
                    U(GNBCD) = Pnew'/GSM1;
                    %---------------------------------------
                    % Calculate reaction forced on Constyrained GDOF
                            %----------------------
                            %----------------------
                                        % CALCULATE " GNBC "
                                        % GDof Not Belonging to Constrained nodes
                                        a = zeros(size(GDOFlong));
                                        for count = 1:numel(GTBC);
                                            a = a + (GDOFlong == repmat(GTBC(count), size(GDOFlong,1), 1));
                                        end
                                        GNBC = find(a==0);
                            %----------------------
                            %----------------------
                    GSM2         = GSM;
                    GSM2(GNBC,:) = []; % ROW ELIMINATION
                    RC            = GSM2*U;
                    %---------------------------------------
                    % Calculate reaction forced on Displaced GDOF
                            %----------------------
                            %----------------------
                                        % CALCULATE " GNBD "
                                        % GDof Not Belonging to Constrained nodes
                                        a = zeros(size(GDOFlong));
                                        for count = 1:numel(GTBD);
                                            a = a + (GDOFlong == repmat(GTBD(count), size(GDOFlong,1), 1));
                                        end
                                        GNBD = find(a==0);
                            %----------------------
                            %----------------------
                    GSM3         = GSM;
                    GSM3(GNBD,:) = []; % ROW ELIMINATION
                    RD            = GSM3*U;
                    %---------------------------------------
                    varargout{1}  = U;
                    varargout{2}  = NodalForces;
                    varargout{3}  = {RC, RD};
                    %---------------------------------------
                elseif version == 5
                    GSM      = varargin{3}{1};
                    U        = varargin{3}{2};
                    P        = varargin{3}{3};
                    UA       = varargin{3}{4};
                    
                    GDOFlong = varargin{4}{1};
                    GTBC     = varargin{4}{2};
                    GTBD     = varargin{4}{3};
                    GTBCD    = varargin{4}{4};
                    GTBL     = varargin{4}{5};
                    
                    lscount  = varargin{6}{1};
                    
                    Pnew = P;
                    NodalForces = P;
                    %---------------------------------------
                    % Rows belonging to Constrained and Displaced nodes are removed
                    GSM1 = GSM;
                    GSM1(GTBCD, :) = [];
                    Pnew(GTBCD, :) = [];
                            %----------------------
                            %----------------------
                                        % CALCULATE " GNBCD "
                                        % GDof Not Belonging to Constrained and Displaced nodes
                                        a = zeros(size(GDOFlong));
                                        for count = 1:numel(GTBCD);
                                            a = a + (GDOFlong == repmat(GTBCD(count), size(GDOFlong,1), 1));
                                        end
                                        GNBCD = find(a==0);
                            %----------------------
                            %----------------------
                    for countGSMrow = 1:size(GSM1,1) % NOTE: the new size(GSM,1) is different due to row elimination
                        GSMextract = GSM1(countGSMrow, GTBCD);
                        Uextract   = U(GTBCD,1);
                        Pnew(countGSMrow)       =       Pnew(countGSMrow) - sum(sum( GSMextract.*Uextract' ));
                    end
                    %---------------------------------------
                    % Update force vector
                    NodalForces(GNBCD) = Pnew;
                    %---------------------------------------
                    % elimnate columns in GSMexatrct
                    GSM1(:, GTBCD)  = [];
                    %---------------------------------------
                    % SOLVING FOR THE DISPLACEMENBTS OF THE NODES WHICH ARE NEITHER CONSTREAINED NOT DISPLACED
                    U(GNBCD) = Pnew'/GSM1;
                    %---------------------------------------
                    % Calculate reaction forced on Constyrained GDOF
                            %----------------------
                            %----------------------
                                        % CALCULATE " GNBC "
                                        % GDof Not Belonging to Constrained nodes
                                        a = zeros(size(GDOFlong));
                                        for count = 1:numel(GTBC);
                                            a = a + (GDOFlong == repmat(GTBC(count), size(GDOFlong,1), 1));
                                        end
                                        GNBC = find(a==0);
                            %----------------------
                            %----------------------
                    GSM2         = GSM;
                    GSM2(GNBC,:) = []; % ROW ELIMINATION
                    RC            = GSM2*U;
                    %---------------------------------------
                    % Calculate reaction forced on Displaced GDOF
                            %----------------------
                            %----------------------
                                        % CALCULATE " GNBD "
                                        % GDof Not Belonging to Constrained nodes
                                        a = zeros(size(GDOFlong));
                                        for count = 1:numel(GTBD);
                                            a = a + (GDOFlong == repmat(GTBD(count), size(GDOFlong,1), 1));
                                        end
                                        GNBD = find(a==0);
                            %----------------------
                            %----------------------
                    GSM3         = GSM;
                    GSM3(GNBD,:) = []; % ROW ELIMINATION
                    RD            = GSM3*U;
                    %---------------------------------------
                    varargout{1}  = U;
                    varargout{2}  = NodalForces;
                    varargout{3}  = {RC, RD};
                    %---------------------------------------
                elseif version == 4
                    GSM      = varargin{3}{1};
                    U        = varargin{3}{2};
                    P        = varargin{3}{3};
                    UA       = varargin{3}{4};
                    GDOFlong = varargin{4}{1};
                    GTBC     = varargin{4}{2};
                    GTBD     = varargin{4}{3};
                    GTBCD    = varargin{4}{4};
                    GTBL     = varargin{4}{5};
                    
                    lscount  = varargin{6}{1};
                    %----------------------------------------------------------
                    Ubefore = U;
                    Pbefore = P;
                    %----------------------------------------------------------
                    % Now i am updating the nodal force vector, on the basis of 
                        % reaction forces on the nodes, on which displacement boundary conditions are imposed
                    Pnew = P;
                    for countGDOFD = 1:numel(GTBD)
                        for countPnew = 1:numel(Pnew)
                                Pnew(countPnew) = Pnew(countPnew) - GSM(countPnew,GTBD(countGDOFD))*U(GTBD(countGDOFD));
                        end
                    end
                    %----------------------------------------------------------
                    % now i eleminate rows and columns of the constrained and displaced nodes, in:
                        % 1. GSM
                        % 2. Pnew
                    GSM(GTBCD, :) = [];
                    GSM(:, GTBCD) = [];
                    Pnew(GTBCD)   = [];
                    %----------------------------------------------------------
                    % GDOF of Nodes Not Constrained and Displaced
                    GNNCD         = GDOFlong;
                    GNNCD(GTBCD)  = [];
                    %----------------------------------------------------------
                    displacements = (Pnew'/GSM)';
                    %----------------------------------------------------------
                    U(GNNCD) = displacements;
                    UA{lscount,1} = [GDOFlong U];
                    %----------------------------------------------------------
                    P(GNNCD) = Pnew;
                    %----------------------------------------------------------
                    varargout{1}  = UA;
                    varargout{2}  = U;
                    varargout{3}  = P;
                elseif version == 3
                    GSM      = varargin{3}{1};
                    U        = varargin{3}{2};
                    P        = varargin{3}{3};
                    GDOFlong = varargin{4}{1};
                    NTBC     = varargin{4}{2};
                    NTBD     = varargin{4}{3};
                    NTBL     = varargin{4}{4};
                    Ubefore = U;
                    Pbefore = P;
                    %----------------------------------------------------------
                    GDOFC = zeros(2*size(NTBC,1),1);  % GDOF to be Constrained
                    for count = 1:size(NTBC)
                        GDOFC(2*count-1) = 2*NTBC(count,1)-1;
                        GDOFC(2*count  ) = 2*NTBC(count,1)  ;
                    end
                    %--------------------------
                    GDOFD = zeros(2*size(NTBD,1),1);  % GDOF to be Displaced
                    for count = 1:size(NTBD)
                        GDOFD(2*count-1) = 2*NTBD(count,1)-1;
                        GDOFD(2*count  ) = 2*NTBD(count,1)  ;
                    end
                    %--------------------------
                    GDOFL = zeros(2*size(NTBL,1),1);  % GDOF to be Loaded
                    for count = 1:size(NTBL)
                        GDOFL(2*count-1) = 2*NTBL(count,1)-1;
                        GDOFL(2*count  ) = 2*NTBL(count,1)  ;
                    end                    
                    %--------------------------
                    NTBCD = sort([NTBC; NTBD]);
                    GDOFCD = zeros(2*size(NTBCD,1),1); % GDOF of Constrained as well as Displaced nodes
                    for count = 1:size(NTBCD)
                        GDOFCD(2*count-1) = 2*NTBCD(count,1)-1;
                        GDOFCD(2*count  ) = 2*NTBCD(count,1)  ;
                    end
                    %----------------------------------------------------------
                    % Now i am updating the nodal force vector, on the basis of 
                        % reaction forces on the nodes, on which displacement boundary conditions are imposed
                    Pnew = P;
                    for countGDOFD = 1:numel(GDOFD)
                        for countPnew = 1:numel(Pnew)
                            Pnew(countPnew) = Pnew(countPnew) - GSM(countPnew,GDOFD(countGDOFD))*U(GDOFD(countGDOFD));
                        end
                        
                    end
                    %----------------------------------------------------------
                    U_backup = U;
                    
                    
                    % now i eleminate rows and columns of the constrained and displaced nodes, in:
                        % 1. GSM
                        % 2. Pnew
                        % 3. U
                    GSM(GDOFCD, :) = [];
                    GSM(:, GDOFCD) = [];
                    Pnew(GDOFCD)   = [];
                    U(GDOFCD)      = [];
                    %----------------------------------------------------------
                    % S O L V E     F O R    D I S P L A C E M E N T S
                    displacements = (Pnew'/GSM)';
                    %----------------------------------------------------------
                    % Update the diplacement and load vectors accordingly
                    %-----------------------------------------
                    GNBCD = GDOFlong;
                    GNBCD(GDOFCD) = [];
                    
                    
                    for count = 1:numel(GNBCD)
                        if isnan(Ubefore(GNBCD(count))) == 0
                            U_backup(GNBCD(count)) = Ubefore(GNBCD(count)) + displacements(count);
                        else
                            U_backup(GNBCD(count)) = displacements(count);
                        end
                        P(GNBCD(count)) = P(GNBCD(count)) + Pnew(count);
                    end
                    for count = 1:numel(GDOFlong)
                        if isnan(U_backup(count)) == 1
                            U_backup(count) = Ubefore(count);
                        end
                    end
                    %[Pbefore P]
                    %[GNBCD displacements]
                    %[GDOFlong Ubefore U]
                    %----------------------------------------------------------
                    NodeNumbers = ceil(GDOFlong/2);
                    Ufinal = U_backup;
                    Uassembled = [NodeNumbers GDOFlong Ubefore Ufinal];
                    %----------------------------------------------------------
                    varargout{1}  = Uassembled;
                    varargout{2}  = P;
                    %----------------------------------------------------------
                elseif version == 1
                    GSM      = varargin{3}{1};
                    U        = varargin{3}{2};
                    P        = varargin{3}{3};

                    GDOFlong = varargin{4}{1};
                    NTBC     = varargin{4}{2};
                    NTBD     = varargin{4}{3};
                    NTBL     = varargin{4}{4};

                    %U
                    %P
                    %GDOFlong
                    %NTBC
                    %NTBD
                    %GSM
                    
                    GDOF_NTBC = [GDOFlong(2*NTBD-1); GDOFlong(2*NTBD)];
                    
                    EnfDispInfo = [ [NTBD GDOFlong(2*NTBD-1) U(GDOFlong(2*NTBD-1))]; [NTBD GDOFlong(2*NTBD) U(GDOFlong(2*NTBD))];...
                                    [NTBC GDOFlong(2*NTBC-1) U(GDOFlong(2*NTBC-1))]; [NTBC GDOFlong(2*NTBC) U(GDOFlong(2*NTBC))]];
                    

                    GSM_temp = [GSM U P];
                    
                    % Update nodal force vector
                    %P
                    if numel(NTBD)~=0
                        for count = 1:numel(NTBD)
                            a = 2*NTBD(count)-1;
                            b = 2*NTBD(count)  ;
                            
                            a_prev = 2*(NTBD(count)-1)-1; % previous to a
                            b_prev = 2*(NTBD(count)-1)  ; % previous to b
                            
                            kextract = [GSM(a,a) GSM(a,b);...
                                        GSM(b,a) GSM(b,b)];
                            utemp = [ U(GDOFlong(a));
                                      U(GDOFlong(b)) ];
                            fdelxy = kextract*utemp;
                                % next line performs the update for P vector
                            P(a) = P(a) + fdelxy(1); % Update the x-componenet
                            P(b) = P(b) + fdelxy(2); % Update the y-componenet
%                             P(a_prev) = P(a_prev) + fdelxy(1); % Update the x-componenet
%                             P(b_prev) = P(b_prev) + fdelxy(2); % Update the y-componenet
                        end
                    end
                    
                    
                    
                    GSMtemp = GSM;
                    
                    GDOF_C = [2*NTBC(1:numel(NTBC))-1; 2*NTBC(1:numel(NTBC))];
                    
                    
                    
                    GSMtemp(GDOF_C,:) = [];
                    GSMtemp(:,GDOF_C) = [];
                    
                    Ptemp = P;
                    Ptemp(GDOF_C) = [];
                    
                    
                    
                    
                    
                    
                    
                    displacements = Ptemp'/GSMtemp;
                    
                    
                    
                    
                    
                    
                    
                    GNBC = GDOFlong;
                    for count = 1:numel(GDOF_C)
                        GNBC(find(GDOFlong==GDOF_C(count))) = NaN;
                    end
                    GNBC = GNBC(find(isnan(GNBC)==0));
                    
                    Ubefore = U;
                    % Update U and P matrices
                    for count = 1:numel(GNBC)
                        U(GNBC(count)) = displacements(count);
                        P(GNBC(count)) = Ptemp(count);
                    end
                    Ufinal = U;
                    
                    NodeNumbers = ceil(GDOFlong/2);
                    
                    
                    Uassembled = [NodeNumbers GDOFlong Ubefore Ufinal];
                    
                    
                    varargout{1}  = Uassembled;
                    varargout{2}  = P;
                elseif version == 2
                    GSM      = varargin{3}{1};
                    U        = varargin{3}{2};
                    P        = varargin{3}{3};

                    GDOFlong = varargin{4}{1};
                    NTBC     = varargin{4}{2};
                    NTBD     = varargin{4}{3};
                    NTBL     = varargin{4}{4};

                    % NTBCD = [NTBC; NTBD]; % Assemble NTB related to displacement boundary condition

                    GSM_ReOrdered      = zeros(size(GSM));
                    GDOFlong_ReOrdered = zeros(size(GDOFlong));
                    for count = 1:size(NTBC,1)
                        GDOFlong_ReOrdered(2*count-1,:) = GDOFlong(2*NTBC(count)-1,:);
                        GDOFlong_ReOrdered(2*count  ,:) = GDOFlong(2*NTBC(count)  ,:);
                    end
                    increment = 2*size(NTBC,1);
                    for count = 1:size(NTBD,1)
                        GDOFlong_ReOrdered(increment+2*count-1,:) = GDOFlong(2*NTBD(count)-1,:);
                        GDOFlong_ReOrdered(increment+2*count  ,:) = GDOFlong(2*NTBD(count)  ,:);
                    end

                    %GDOF_LF = find(GDOFlong_ReOrdered(:)~=0);

                    GDOF_LR = find(GDOFlong_ReOrdered(:)==0); % GDOF_Long_Remaining

                    for count1 = 1:size(GDOFlong,1)
                        if numel(find( GDOFlong_ReOrdered(GDOFlong_ReOrdered(:)~=0) == GDOFlong(count1) )) == 0
                            for count2 = 1:size(GDOFlong_ReOrdered,1)
                                if GDOFlong_ReOrdered(count2,1)==0
                                    GDOFlong_ReOrdered(count2,1) = GDOFlong(count1,1);
                                    break
                                end
                            end
                        end
                    end
                    GDOF_LRO = GDOFlong_ReOrdered; % Just a short form
                    for count = 1:size(GDOF_LR,1)
                        GDOFlong_ReOrdered(GDOF_LR(count)  ,:) = GDOFlong(GDOF_LRO(GDOF_LR(count)) ,:);
                    end

                    for count = 1:numel(GDOFlong_ReOrdered)
                        row = GSM(GDOFlong_ReOrdered(count),:); % Extract the required row from GSM __ THIS IS ROW SHIFTING
                        row(1,GDOFlong') = row(1,GDOFlong_ReOrdered'); % perform COL SHIFTING
                        GSM_ReOrdered(count,:) = row;
                    end
                    P_ReOrdered = P(GDOFlong_ReOrdered);
                    U_ReOrdered = U(GDOFlong_ReOrdered);
                    
                    
                    Problemis = '2d';
                    if strcmp(Problemis, '2d') == 1
                        KExtractSize = 2*(numel(NTBC) + numel(NTBD));
                    elseif strcmp(Problemis, '3d') == 1
                        KExtractSize = 3*(numel(NTBC) + numel(NTBD));
                    end

                    GSM_RO_extract_A = GSM_ReOrdered(1:KExtractSize, 1:KExtractSize); % GSM_RO_extract_A: GSM_ReOrdered_extract_A
                    U_RO_extract_A   = U_ReOrdered(1:KExtractSize);






                    % Solve for P_RO_extract_A::
                    P_RO_extract_A   = GSM_RO_extract_A*U_RO_extract_A;









                    %Update P_ReOrdered with P_RO_extract_A
                    P_ReOrdered(1:numel(P_RO_extract_A)) = P_ReOrdered(1:numel(P_RO_extract_A)) + P_RO_extract_A;

                    %Update U_ReOrdered with U_RO_extract_A
                    U_ReOrdered(1:numel(U_RO_extract_A)) = U_ReOrdered(1:numel(U_RO_extract_A)) + U_RO_extract_A;

                    % THUS, WE NOW HAVE :
                                        % 1) GSM_ReOrdered
                                        % 2) U_ReOrdered
                                        % 3) P_ReOrdered
                    % NOW, WE HAVE TO SOLVE "Kd = f", that is,
                                        %     [GSM_ReOrdered] [U_ReOrdered]    =    [P_ReOrdered] , 
                                        % for [U_ReOrdered], by making use of the new [P_ReOrdered] !!
                    % DISPLACEMENTS = P_ReOrdered'/GSM_ReOrdered
                    % ELIMATION PROCEDURE
                       % the fully constrained nodes are present in NTBC
                       % GDOF of these nodes are alternatiely: [2*NTBC(:)-1 and 2*NTBC(:)]

                    GSM_ReOrdered_ae      = GSM_ReOrdered;
                    U_ReOrdered_ae        = U_ReOrdered;
                    P_ReOrdered_ae        = P_ReOrdered;
                    GDOFlong_ReOrdered_ae = GDOFlong_ReOrdered;

                    % ELIMINATION:
                    temp = find(U_ReOrdered_ae == 0);
                    Eliminated = temp;
                    GSM_ReOrdered_ae(temp,:)    = [];
                    GSM_ReOrdered_ae(:,temp)    = [];
                    U_ReOrdered_ae(temp)        = [];
                    P_ReOrdered_ae(temp)        = [];
                    GDOFlong_ReOrdered_ae(temp) = [];

                    % SOLVE FOR DISPLACEMENTS
                    DISPLACEMENTS = P_ReOrdered_ae'/GSM_ReOrdered_ae;

                    Ufinal = U;
                    U(isnan(U)) = 0;
                    Ufinal(GDOFlong_ReOrdered_ae) = U(GDOFlong_ReOrdered_ae) + DISPLACEMENTS';
                    NodeNumbers = ceil(GDOFlong/2);

                    Uassembled = [NodeNumbers GDOFlong U Ufinal];
                    %[GDOFlong_ReOrdered_ae DISPLACEMENTS']

                    % SOLVE FOR FORCES
                    FORCES        = GSM_ReOrdered_ae * DISPLACEMENTS';
                    % Introduce some rounding stuff... TO BE REMOVED !!!!
                    for count = 1:numel(FORCES)
                        if ( round(abs(FORCES(count))) -  abs(FORCES(count)) ) < 1E-6
                            FORCES(count) = round(FORCES(count));
                        end
                    end
                    [GDOFlong_ReOrdered_ae  FORCES];


                    Pfinal = P;
                    Pfinal(GDOFlong_ReOrdered_ae) = P(GDOFlong_ReOrdered_ae) + FORCES;
                    NodeNumbers = ceil(GDOFlong/2);
                    Passembled =  [NodeNumbers GDOFlong P Pfinal];

                    % REACTION FORCES ON CONSTRAINED NODES:
    %                 GDOFlong_ReOrdered_ae(Eliminated)
    %                 GSM_RO_extract = GSM_ReOrdered(1:temp, 1:temp)
                    varargout{1}  = Uassembled;
                    varargout{2}  = Passembled;
                end
        end
    case 'frontal'
end

end