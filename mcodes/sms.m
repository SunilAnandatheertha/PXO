%-----------------------------------------------------------------
% <SARASWATI MECH SOLVER V.2.05> - Sunil Anandatheertha @gmail.com
%-----------------------------------------------------------------
    % VERSION START DATE :: 28-01-2014
    % REFER TO END FOR VERSION HISTORY
%-----------------------------------------------------------------
function sms(varargin)
%-----------------------------------------------------------------
close all
% FINFO('SMS'), pause(0.10)
% FINFO('DEV')
% CONSOLE_MESSAGE_DISPLAY('misc','PressToConti');
%-----------------------------------------------------------------
% SDMantra('saraswati')
% SCMD('eu','g1')
% SCMD('eu','gn')
% AGG('Gn','RFFYes',[0 1 3], 'SortNo',1,[0.30 0.34])
if nargin == 0
    SSAM('2d','PostProcessYes',1)
% elseif nargin == 1
%     if strcmpi(varargin{1},'g1')==1 %<<< TO GENERATE SINGLE GRAPHENE SHEET WITH DEFAULT VALUES
%         AGG('G1', 's', [5 0 2 5], 'WarpYes', 'trig03', 'xPerturbNo', 'yPerturbNo', 1);
%     end
else
    switch lower(varargin{1})
        case {'agg'} % Use case values {value1, value2,.. so oin } for multiple cases !!
            AC = 1;
            if nargin == 1
                [LAYUP, WARP, WARPFN, XPERT, YPERT, WTD] = SDV('agg', 'g1');
                AGG('G1', 's', LAYUP, WARP, WARPFN, XPERT, YPERT, WTD);
            else
                switch lower(varargin{2})
                    case 'g1.def' % ----- sms('agg', 'g1.def')
                        AC = AC + 1;
                        [LAYUP, WARP, WARPFN, XPERT, YPERT, WTD] = SDV('agg', 'g1');
                        AGG('G1', 's', LAYUP, WARP, WARPFN, XPERT, YPERT, WTD);
                    case 'g1'     % ----- sms('agg', 'g1')
                        if nargin < 3
                            disp('Not enough input arguments to AGG(..)')
                            disp('Using default values instead')
                            [LAYUP, WARP, WARPFN, XPERT, YPERT, WTD] = SDV('agg', 'g1');
                            AGG('G1', 's', LAYUP, WARP, WARPFN, XPERT, YPERT, WTD);
                        else
                            %//////////////////////////////////////
                            AC = AC + 1;
                            if ischar(varargin{AC+1}) == 1
                                disp('Taking default graphene Lay-up data')
                                layuptemp = SDV('agg','g1.layup');
                                m   = layuptemp(1); % 1ST CHIRAL INDEX
                                n   = layuptemp(2); % 2ND CHIRAL INDEX
                                l   = layuptemp(3); % GRAPHENE LENGTH
                                vdd = layuptemp(4); % VACANCY DEFECT DENSITY
                            else
                                if numel(varargin{AC+1}) < 4 || numel(varargin{AC+1}) > 4
                                    disp('The graphene sheet lay up parameters are incorrect')
                                    disp('Using default values instead')
                                    layuptemp = SDV('agg','g1.layup');
                                    m   = layuptemp(1);
                                    n   = layuptemp(2);
                                    l   = layuptemp(3);
                                    vdd = layuptemp(4);
                                else
                                    m   = varargin{AC+1}(1);
                                    n   = varargin{AC+1}(2);
                                    l   = varargin{AC+1}(3);
                                    vdd = varargin{AC+1}(4);
                                end
                            end
                            LAYUP  = [m n l vdd];
                            %//////////////////////////////////////
                            AC = 4;
                            WARP     = varargin{AC};    % VALUE: WarpYes or WarpNo
                            if strcmp(WARP,'wy')==1
                                WARP = 'WarpYes';
                            elseif strcmp(WARP,'wn')==1
                                WARP = 'WarpNo';
                            end
                            %//////////////////////////////////////
                            WARPFN = varargin{5};
                            % input handling for varargin{5}
                            %//////////////////////////////////////
                            XPERT  = varargin{6};
                            % input handling for varargin{6}
                            %//////////////////////////////////////
                            YPERT  = varargin{7};
                            % input handling for varargin{7}
                            %//////////////////////////////////////
                            WTD    = varargin{8};
                            % input handling for varargin{8}
                            %//////////////////////////////////////
                        end
                        AGG('G1', 's', LAYUP, WARP, WARPFN, XPERT, YPERT, WTD)
                    case 'gn.def' % -----
                        AC = AC + 1;
                        [LAYUP, WARP, WARPFN, XPERT, YPERT, WTD] = SDV('agg', 'gn');
                end
            end
        case {'sa','m'}
            CleanUpPWDofPreviousResults = 1;
            if CleanUpPWDofPreviousResults == 1
                fprintf('CLEARING OUT ALL STORED RESULT DATA PREVIOUS RUNS\n IN THE PRESENT WORKING DIRECTORY')
                try
                    rmdir('SSAM_Results_Run.No.*','s')
                catch err
                    % DO NOTHING
                end
            end
             % VALUES PASSED from 'sms' to 'SSAM'              :: VALUE
                % varargin{1} of sms                           :: 'sa'
                % varargin{2} of sms   =   varargin{1} of SSAM :: '2d' or '3d'
                % varargin{3} of sms   =   varargin{2} of SSAM :: 'PostProcessYes' or 'PostProcessNo'
                % varargin{4} of sms   =   varargin{3} of SSAM :: NumberOfTrials
             if numel(varargin{3}) == 0
                 PostProcessRequirement = 'PostProcessNo'; % NO POST-PROCESSING UNLESS SPECIFIED TO DO POST-PROCESS ::: DEFAULT
             else
                 switch varargin{3}
                     case {'PostProcessYes','ppy','py'}
                         PostProcessRequirement = 'PostProcessYes';
                     case {'PostProcessNo','ppn','pn'}
                         PostProcessRequirement = 'PostProcessNo';
                 end
%                  PostProcessRequirement = varargin{3};
             end
             %--------------------------------------------------------------------
             %--------------------------------------------------------------------
             NoOfRuns = 2;
             %-----------------------
             for count = 1:NoOfRuns
                 %count 
                 %NoOfRuns
                 if count == 1
                     SFFO('ssam', 1)
                 end
                 SCMD('seperator','type02',6,2)
                 SCMD('ssam.batch', 'BatchNo', varargin{2}, count)
                 %---------------
                 SSAM(varargin{2}, PostProcessRequirement, varargin{4});
                 %---------------
%                  if count == 1 && NoOfRuns > 1
%                      SFFO('ssam', count)
%                  end
                 if NoOfRuns > 1
                     SFFO('ssam', 'MoveResults', count)
                     SCMD('ssam.batch', 'BatchFFMove', count)
                 end
                 
                 close all
                 
             end
             % example: sms('SSAM', '2d', '', 1)
             %          sms('SSAM', '2d', 'PostProcessYes', 1)
             %          sms('SSAM', '2d', 'PostProcessNo', 1)
             %--------------------------------------------------------------------
             %--------------------------------------------------------------------
        case {'sfea', 'fea', 'fem', 'fe', 'f'}
            if nargin < 2
                % Set default values for this module
                SFEA('basic')
            else
                switch varargin{2}
                    case {'a', 'ag'}
                        SFEAM(varargin{2}, varargin{3}, varargin{4},...
                              varargin{5}, varargin{6}, varargin{7}, varargin{8}, varargin{9});
                    case 'c'
                end
            end
        case 'smd'
            % MOLECULAR DYNAMICS CODES HERE
    end
end
end
%-----------------------------------------------------------------
% FOR EXAMPLE USAGES, REFER END
%-----------------------------------------------------------------
% THINGS TO DO in VERSION 2.00 - 2.99
% 01. frontal algorithm implementation in 2D SA
% 02. fea code for graphene 2D analysis
% 03. bring 'mcs3d()' to working condition
% 04. agg for swcnt
% 05. agg for mwcnt
% 06. agg for crystalline polyethylene
% 07. agg for amorphous poly-ethylene
% 08. agg for swcnt ropes
% 09. agg for mwcnt ropes
% 10. SPEED UP:: graphene generation
% 11. SPEED UP:: graphene plot
%-----------------------------------------------------------------
%-----------------------------------------------------------------
%            E X A M P L E      U S A G E S
%-----------------------------------------------------------------
%-----------------------------------------------------------------
%                        SIMULATED ANNEALING
% sms('sa','2d', 'PostProcessYes',1)      % AS ON 20.01.2014 20.06
%-------------------------------------------
%                            FEA OF GRAPHENE
% sms('sfea','AG','EqGeomMDNo','2d','G1',[1 0 1 0])        % AS ON 22.01.2014
% sms('sfea', 'AG', 'EqGeomMDNo', '3d', 'G1', [10 0 4 2], 'WarpYes', 'XPerturbYes', 'YPerturbYes', WTD)
%-----------------------------------------------------------------
%-----------------------------------------------------------------
%          V E R S I O N     H I S T O R Y
%-----------------------------------------------------------------
%-----------------------------------------------------------------
% SMS.V.2.04  <<--||-->> START DATE ::  28-01-2014
% SMS.V.2.03  <<--||-->> START DATE ::  26-01-2014
% SMS.V.2.02  <<--||-->> START DATE ::  22-01-2014
% SMS.V.2.01  <<--||-->> START DATE ::  13-01-2014
% SMS.V.1.39  <<--||-->> START DATE ::  20-09-2013
% SMS.V.1.38c <<--||-->> START DATE ::  12-08-2013
% SMS.V.1.38b <<--||-->> START DATE ::  25-07-2013
% SMS.V.1.38a <<--||-->> START DATE ::  16-07-2013
% SMS.V.1.00  <<--||-->> START DATE ::  02-10-2012
%-----------------------------------------------------------------
% HEALTH ADVICE FOR PROGRAMMING
% For eyes:   
% For wrists: 
% For tummy:  http://www.youtube.com/watch?v=1d3erUbB3uw
% For legs:   
%-----------------------------------------------------------------