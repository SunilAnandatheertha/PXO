function [varargout] = SFCMPAB(varargin)
% SFCMPAB: Sms Feam Calculate Mechanical Properties And Behavior

% CALCULATE INITIAL MODULUS
% NTBC
% NNNCM

switch varargin{1}
    case {'sfeam.calc.MechProp.2d','sfeam.calc.mp.2d'}
%         [TotalStrain, AXIALSTRESS, INITIALMODULUS] = SFCMPAB('sfeam.calc.MechProp.2d',...
%                                              {'ag.g1','StressAndRelated'},...
%                                              {NNNCM, NNNCMnew, NTBC, NTBL, thickness, lscount},...
%                                              {Displacement_NTBL_x_mean, Displacement_NTBL_y_mean, REACTION_x_SUM, REACTION_y_SUM});
        switch varargin{2}{1}
            case 'ag.g1'
                switch varargin{2}{2}
                    case 'SupportReactions2d'
                        NODALCONSTRAIN_OPTION = varargin{3}{1};
                        NTBC                  = varargin{3}{2};
                        lscount               = varargin{3}{3};
                        GSM                   = varargin{3}{4};
                        DispConsMatrix        = varargin{3}{5};
                        U                     = varargin{3}{6};
                        % CALCULATE   SUPPORT   REACTION  ON   "CONSTRAINED NODES ONLY"
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
                        %---------------------------------------------
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
                        temp_PAUSE_exec(0, 0.025)
                        %---------------------------------------------
                        % CALCULATE AND WRITE THE   " REACTION_X "   &   " REACTION_Y " 
                        % and WRITE THEM TO HARD DISK
                        REACTION_X = [ REACTION(1:2:size(REACTION,1),1) REACTION(1:2:size(REACTION,1),3)];
                        REACTION_Y = [ REACTION(2:2:size(REACTION,1),1) REACTION(2:2:size(REACTION,1),3)];
                        SFFO('sfeam','ag', 'wrtd', 'ReactionX_OnConstrainedNodes_LS=', REACTION_X, 'loadstep', lscount);
                        SFFO('sfeam','ag', 'wrtd', 'ReactionY_OnConstrainedNodes_LS=', REACTION_Y, 'loadstep', lscount);
                        %---------------------------------------------
                        % SUM THE NODAL FORCES
                        REACTION_x_SUM = sum(REACTION_X(:,2));
                        REACTION_y_SUM = sum(REACTION_Y(:,2));
                        
                        varargout{1} = REACTION;
                        varargout{2} = REACTION_X;
                        varargout{3} = REACTION_Y;                        
                        varargout{4} = REACTION_x_SUM;
                        varargout{5} = REACTION_y_SUM;
                        varargout{6} = NodalReactionForces;
                    case 'StressAndRelated'
                        NNNCM     = varargin{3}{1};
                        NNNCMnew  = varargin{3}{2};
                        NTBC      = varargin{3}{3};
                        NTBL      = varargin{3}{4};
                        thickness = varargin{3}{5};
                        lscount   = varargin{3}{6};
                        
                        Displacement_NTBL_x_mean = varargin{4}{1};
                        Displacement_NTBL_y_mean = varargin{4}{2};
                        REACTION_x_SUM           = varargin{4}{3};
                        REACTION_y_SUM           = varargin{4}{4};
                        
                        ExtremePoints_x = [min(NNNCM(NNNCM(NTBC,1),2)) max(NNNCM(NNNCM(NTBC,1),2))];
                        ExtremePoints_y = [min(NNNCM(NNNCM(NTBC,1),3)) max(NNNCM(NNNCM(NTBC,1),3))];
                        
                        plot(ExtremePoints_x, ExtremePoints_y, 'kh', 'MarkerSize',18)
                        
                        Length_AlongNTBC = sqrt( ( ExtremePoints_x(2) - ExtremePoints_x(1) )^2 + ( ExtremePoints_y(2) - ExtremePoints_y(1) )^2 );
                        Length_AlongLoadingAxis = abs(min(NNNCMnew(NNNCMnew(NTBC,1),3)) - min(NNNCMnew(NNNCMnew(NTBL,1),3)));
                        AreaAlongConstrainedEdge = Length_AlongNTBC * thickness;
                        TotalStrain = Displacement_NTBL_y_mean / Length_AlongLoadingAxis
                        %         REACTION_y_SUM
                        forceforstresscalc(lscount,1) = REACTION_y_SUM;
                        INITIALMODULUS = abs(REACTION_y_SUM) / (AreaAlongConstrainedEdge * TotalStrain)
                        
                        totalstrainvalue(lscount,1) = TotalStrain
                        initialmodulusvalue(lscount,1) = INITIALMODULUS
                        %---------------------------------------------
                        % CALCULATE STRESS
                        AXIALSTRESS{lscount,1} = sum(abs(forceforstresscalc)) / AreaAlongConstrainedEdge
                        
                        varargout{1} = TotalStrain;
                        varargout{2} = AXIALSTRESS;
                        varargout{3} = INITIALMODULUS;
                    case 'StrainAndRelated'
                end
            case 'ag.gn'
        end
end


end