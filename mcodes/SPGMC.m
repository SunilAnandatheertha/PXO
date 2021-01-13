function [varargout] = SPGMC(varargin)
%$$$$--$$$$--$$$$--$$$$--$$$$--$$$$--$$$$--$$$$--$$$$--$$$$
%$$$$--$$$$--$$$$--$$$$--$$$$--$$$$--$$$$--$$$$--$$$$--$$$$
% SMS::    PHYSICAL & GEOEMETRIC CONSTANTS
% version:: 1.10 Start:: 12-01-2014
% version:: 1.00 Start:: 11-01-2014
%$$$$--$$$$--$$$$--$$$$--$$$$--$$$$--$$$$--$$$$--$$$$--$$$$
%$$$$--$$$$--$$$$--$$$$--$$$$--$$$$--$$$$--$$$$--$$$$--$$$$
%    --    --    --    --    --    --    --    --    --
switch varargin{1}
    case 'SMD'
        switch varargin{2}
            case 'boltzmann' % BOLTZMANN CONSTANT
                varargout{1} = 1.3806E-23; % m^2 kg s^-2 K^-1 .. Actual - 1.3806488E-23
            case 'c12mass' % MASS OF CARBON ATOM
                varargout{1} = 1.9944E-23; % kg
        end
        % |++++||++++||++++||++++||++++||++++||++++||++++||++++||++++|
        % |++++||++++||++++||++++||++++||++++||++++||++++||++++||++++|
        % |++++||++++||++++||++++||++++||++++||++++||++++||++++||++++|
    case 'SFEA'
        switch varargin{2}
            case 'atom' % atomistic
                switch varargin{3}
                    case '1d'
                        switch varargin{4}
                            case 'bar'
                                % USAGE:
                                % [NODELOCATIONS, EleCon, E] .. 
                                %   = SPGMC('SFEA', 'atom', '1d', 'bar');
                                %///////////////////////////
                                NODELOCATIONS = [1 0.00; 2 0.30; 3 0.70; 4 1.00;];
                                EleCon        = [1 1 2;  2 2 3;  3 3 4;];
                                E             = 1E9*[070; 200; 200];
                                %///////////////////////////
                                varargout{1} = NODELOCATIONS;
                                varargout{2} = EleCon;
                                varargout{3} = E;
                                %///////////////////////////
                                %///////////////////////////
                            case 'spring'
                            case 'truss'
                            case 'beam'
                        end
                        %///////////////////////////////////////////////
                        %///////////////////////////////////////////////
                    case '2d'
                        switch varargin{4}
                            case 'G1' % Single graphene sheet
                                switch varargin{5}
                                    case 's' % static
                                        % here, values once decided are constant
                                        % use to estimate something like initial
                                        % modulus, or initial stiffness, / something
                                        cov_gra = varargin{6}{1};
                                        vd1_gra = varargin{6}{2};
                                        vd2_gra = varargin{6}{3};
                                        [K] = CalcBondStiff(cov_gra, vd1_gra, vd2_gra);
                                        % Here K{1}, K{2}, K{3} = K_cov, K_vd1, K_vd2
                                        varargout{1} = K;
                                        %\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
                                        %\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
                                    case 'd' % dynamic
                                        % here, values depend on previous state
                                        % this should be used for stress - strain
                                        % simulation
                                        %\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
                                        %\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
                                end
                            case 'unknown' % new stuffs here !! \m/
                        end
                    case '3d'
                end
            case 'cont' % continuous
        end
        % |++++||++++||++++||++++||++++||++++||++++||++++||++++||++++|
        % |++++||++++||++++||++++||++++||++++||++++||++++||++++||++++|
        % |++++||++++||++++||++++||++++||++++||++++||++++||++++||++++|
    case 'AGG'
        switch varargin{2}
            case 'basic'
                switch varargin{3}
                    case 'acc'
                        acc = 0.1421; % equilibrium nm
                        varargout{1} = acc;
                end
                %\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
                %\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
            case 'G1' % Single graphene sheet
                % following factors are used to find out
                % which atoms are within cov and vd1, vd2 bonding
                % distance. Used only in the initial case
                covfaclow     = 0.95; covfacupp = 1.05;
                vd1faclow     = 0.95; vd1facupp = 1.05;
                vd2faclow     = 0.95; vd2facupp = 1.05;
                acc           = SPGMC('AGG', 'basic', 'acc'); % <--<< SELF CALL
                varargout{01} = acc;
                varargout{02} = covfaclow;
                varargout{03} = covfacupp;
                varargout{04} = vd1faclow;
                varargout{05} = vd1facupp;
                varargout{06} = vd2faclow;
                varargout{07} = vd2facupp;
                %\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
                %\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
            case 'Gn' % Stack of graphene sheets
                %EXAMPLE USAGES: 
                % SPGMC('AGG', 'Gn', 'RFFyes',[1 2 1 5 3],'SortYes')
                % SPGMC('AGG', 'Gn', 'RFFyes',[1 2 1 5 3],'SortNo')
                % SPGMC('AGG', 'Gn', 'RFFyes',[1 2 1 5],'SortYes')
                % SPGMC('AGG', 'Gn', 'RFFyes',[1 2 1 5],'SortNo')
                % SPGMC('AGG', 'Gn', 'RFFyes',[0 2 1 5 3],'SortYes')
                % SPGMC('AGG', 'Gn', 'RFFyes',[0 2 1 5 3],'SortNo')
                % SPGMC('AGG', 'Gn', 'RFFyes',[0 2 1 5],'SortYes')
                % SPGMC('AGG', 'Gn', 'RFFyes',[0 2 1 5],'SortNo')
                % SPGMC('AGG', 'Gn', 'RFFno')
                % RFF: READ FROM FILE
                acc           = SPGMC('AGG', 'basic', 'acc'); % <--<< SELF CALL
                % following factors are used to find out
                % which atoms are within cov and vd1, vd2 bonding
                % distance. Used only in the initial case
                covfaclow = 0.95;   covfacupp = 1.05;
                vd1faclow = 0.95;   vd1facupp = 1.05;
                vd2faclow = 0.95;   vd2facupp = 1.05;

                switch lower(varargin{3})
                    case 'rffyes'
                        % usage: SPGMC('AGG', 'Gn', 'RFFyes',...further arguments)
                        if exist(strcat(pwd,'\graphenestack.txt'),'file')==2 %% CHECK IF FILE EXISTS
                            try
                                TEMP = dlmread(strcat(pwd,'\graphenestack.txt'));
                                % ////////////////////////
                                % under 'RFFyes', varargin{4} is reserved for isheet & jsheet
                                part   = varargin{4}(1);
                                % If part = 1, particular sheets will be chosen
                                % If part = 0, sheets will be selected within range
                                % Example usages:
                                  % SPGMC('AGG', 'Gn', 'RFFyes', [1 2 4 7 2])
                                   % here, varargin{4}(1) = 0 : refers to part = 1
                                   % varargin{4}(2:5), individually represent a graphene sheet
                                  % SPGMC('AGG', 'Gn', 'RFFyes', [0 2 4 7 2 8])
                                   % here, varargin{4}(1) = 0 : refers to part = 0
                                   % varargin{4}(2) and varargin{4}(3) define first range of graphene sheet
                                   % varargin{4}(4) and varargin{4}(5) define second range of graphene sheet
                                   % varargin{4}(6) is the last sheet
                                ijvalues = varargin{4}(2:numel(varargin{4}));
                                if part == 1
                                    GrapheneStackLayUp = TEMP(ijvalues,:);
                                elseif part ==0
                                    GrapheneStackLayUp = [];
                                    if mod(numel(ijvalues),2)==0
                                        % If all inputs represent ranges in pairs
                                        for count = 1:numel(ijvalues)/2
                                            switch varargin{5}
                                                case 'SortYes'
                                                    stacks = sort([ijvalues(2*count-1) ijvalues(2*count)]);
                                                    GrapheneStackLayUp = [GrapheneStackLayUp; TEMP(stacks(1):stacks(2),:)];
                                                case 'SortNo'
                                                    stacks = [ijvalues(2*count-1) ijvalues(2*count)];
                                                    if stacks(1) > stacks(2)
                                                        GrapheneStackLayUp = [GrapheneStackLayUp; TEMP(stacks(1):-1:stacks(2),:)];
                                                    else
                                                        GrapheneStackLayUp = [GrapheneStackLayUp; TEMP(stacks(1):stacks(2),:)];
                                                    end
                                            end
                                        end
                                    elseif mod(numel(ijvalues),2)==1
                                        % Ensures if all inputs are not ranges in pairs
                                        % The last, n^th of the ijvalues will correspond to
                                        % n^th of the graphene stack layers
                                        for count = 1:(numel(ijvalues)-1)/2
                                            switch lower(varargin{5})
                                                case 'sortyes'
                                                    stacks = sort([ijvalues(2*count-1) ijvalues(2*count)]);
                                                    GrapheneStackLayUp = [GrapheneStackLayUp; TEMP(stacks(1):stacks(2),:)];
                                                case 'sortno'
                                                    stacks = [ijvalues(2*count-1) ijvalues(2*count)];
                                                    if stacks(1) > stacks(2)
                                                        GrapheneStackLayUp = [GrapheneStackLayUp; TEMP(stacks(1):-1:stacks(2),:)];
                                                    else
                                                        GrapheneStackLayUp = [GrapheneStackLayUp; TEMP(stacks(1):stacks(2),:)];
                                                    end
                                            end
                                        end
                                        GrapheneStackLayUp = [GrapheneStackLayUp; TEMP(ijvalues(numel(ijvalues)),:)];
                                    end
                                end
                                SCMD('seperator','type02',8,2)
                                printmat(GrapheneStackLayUp,'Lay up sequence of graphene stack')
                                SCMD('seperator','type02',8,2)
                                % ////////////////////////
                                % ////////////////////////
                            catch err
                                disp('The file graphenestack.txt is empty on graphene stack data')
                                disp('Please populate it with correct data for next run')
                                disp('Using default values for the current run')
                                SPGMC('AGG', 'Gn', 'RFFno'); %      <--<< SELF CALL
                            end
                        end
                    case 'rffno'
                        % will execute if SPGMC('AGG', 'Gn', 'RFFno', varargin{4})
                        GrapheneStackLayUp = [10 0 2.0000 floor(rand*10);
                                              10 0 2.0000 floor(rand*10);
                                              10 0 2.0000 floor(rand*10);
                                              10 0 2.0000 floor(rand*10);
                                              10 0 2.0000 floor(rand*10);
                                              10 0 2.0000 floor(rand*10);];
                        printmat(GrapheneStackLayUp,'The lay up is')
                end
                varargout{01} = acc;
                varargout{02} = covfaclow;
                varargout{03} = covfacupp;
                varargout{04} = vd1faclow;
                varargout{05} = vd1facupp;
                varargout{06} = vd2faclow;
                varargout{07} = vd2facupp;
                varargout{08} = GrapheneStackLayUp;
                
                InterGSSpacing    = 0.3350; % Inter Graphene Sheet Spacing, in nm
                varargout{09} = InterGSSpacing;
            case 'C1' % SWCNT
            case 'Cn' % MWCNT
        end
        % |++++||++++||++++||++++||++++||++++||++++||++++||++++||++++|
        % |++++||++++||++++||++++||++++||++++||++++||++++||++++||++++|
        % |++++||++++||++++||++++||++++||++++||++++||++++||++++||++++|
    case 'SMC'
end
%$$$$--$$$$--$$$$--$$$$--$$$$--$$$$--$$$$--$$$$--$$$$--$$$$
%$$$$--$$$$--$$$$--$$$$--$$$$--$$$$--$$$$--$$$$--$$$$--$$$$
%$$$$--$$$$--$$$$--$$$$--$$$$--$$$$--$$$$--$$$$--$$$$--$$$$
%$$$$--$$$$--$$$$--$$$$--$$$$--$$$$--$$$$--$$$$--$$$$--$$$$
end