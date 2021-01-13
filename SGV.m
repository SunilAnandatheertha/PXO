function [varargout] = SGV(varargin)

% THIS FUNCTION PLTS THE REQUIRED GEOEMTRY

% SMS GEOMETRTY VISUZLIZER
set(0,'DefaultFigureWindowStyle','docked')
switch varargin{1}
    case 'ag'
        switch varargin{2}
            case 'g1'
                lscount                       = varargin{3}{1};
                econA                         = varargin{3}{2};
                NNNCM                         = varargin{3}{3};
                
                plotoriginalgeometry_cov      = varargin{4}{1};
                plotoriginalgeometry_vd1      = varargin{4}{2};
                plotoriginalgeometry_vd2      = varargin{4}{3};
                plotoriginalgeometry_atoms    = varargin{4}{4};
                
                TEXTelemnumbersOrgGeomCov     = varargin{5}{1}{2};
                TEXTelemnumbersOrgGeomVd1     = varargin{5}{1}{4};
                TEXTelemnumbersOrgGeomVd2     = varargin{5}{1}{6};
                TEXTelemnumbersOrgGeomFS      = varargin{5}{2};
                TEXTelemnumbersOrgGeomCol_cov = varargin{5}{3}{2};
                TEXTelemnumbersOrgGeomCol_vd1 = varargin{5}{3}{4};
                TEXTelemnumbersOrgGeomCol_vd2 = varargin{5}{3}{6};
                
                TEXTnodenumbersOrgGeom        = varargin{6}{1};
                TEXTnodenumbersOrgGeomFS      = varargin{6}{2};
                TEXTnodenumbersOrgGeomCol     = varargin{6}{3}{1};
                
                % PLOT ORIGINAL GEOMETRY
                oazfc = 0; %   O.ffset    A.long   z    F.or     C.larity
                if lscount == 1
                    for count = 1:size(econA,1)
                        if plotoriginalgeometry_cov == 1
                            if econA(count,9) == 1
                                plot3([ econA(count,3)       econA(count,6)       ],...
                                      [ econA(count,4)       econA(count,7)       ],...
                                      [ oazfc+econA(count,5) oazfc+econA(count,8) ], 'k:','LineWidth',1)
                                  if TEXTelemnumbersOrgGeomCov == 1
                                      text( (econA(count,3) + econA(count,6))/2,...
                                            (econA(count,4) + econA(count,7))/2,...
                                            (econA(count,5) + econA(count,8))/2,...
                                            num2str(count),...
                                            'FontSize', TEXTelemnumbersOrgGeomFS, 'BackgroundColor',TEXTelemnumbersOrgGeomCol_cov)
                                  end
                            end
                        end
                        if plotoriginalgeometry_vd1 == 1
                            if econA(count,9) == 2
                                plot3([ econA(count,3)       econA(count,6)       ],...
                                      [ econA(count,4)       econA(count,7)       ],...
                                      [ oazfc+econA(count,5) oazfc+econA(count,8) ], 'c:')
                                  if TEXTelemnumbersOrgGeomVd1 == 1
                                      %  POINT (xp, yp) WHICH DIVIDES A LINE [(xa,ya), (xb,yb)] IN THE RATIO k1:k2
                                            % xp = (k1*xb + k2*xa)/(k1+k2)
                                            % yp = (k1*yb + k2*ya)/(k1+k2)
                                      k1 = 1;
                                      k2 = 1;
                                      text( (k1*econA(count,6) + k2*econA(count,3))/(k1+k2),...
                                            (k1*econA(count,7) + k2*econA(count,4))/(k1+k2),...
                                            (k1*econA(count,8) + k2*econA(count,5))/(k1+k2),...
                                            num2str(count),...
                                            'FontSize', TEXTelemnumbersOrgGeomFS, 'BackgroundColor',TEXTelemnumbersOrgGeomCol_vd1)
                                  end
                            end
                        end
                        if plotoriginalgeometry_vd2 == 1
                            if econA(count,9) == 3
                                plot3([ econA(count,3)       econA(count,6)       ],...
                                      [ econA(count,4)       econA(count,7)       ],...
                                      [ oazfc+econA(count,5) oazfc+econA(count,8) ], 'c:')
                                  if TEXTelemnumbersOrgGeomVd2 == 1
                                      k1 = 1;
                                      k2 = 0.65;
                                      text( (k1*econA(count,6) + k2*econA(count,3))/(k1+k2),...
                                            (k1*econA(count,7) + k2*econA(count,4))/(k1+k2),...
                                            (k1*econA(count,8) + k2*econA(count,5))/(k1+k2),...
                                            num2str(count),...
                                            'FontSize', TEXTelemnumbersOrgGeomFS, 'BackgroundColor',TEXTelemnumbersOrgGeomCol_vd2)
%                                       text( (econA(count,3) + econA(count,6))/2,...
%                                             (econA(count,4) + econA(count,7))/2,...
%                                             (econA(count,5) + econA(count,8))/2,...
%                                             num2str(count),...
%                                             'FontSize', TEXTelemnumbersOrgGeomFS, 'BackgroundColor',TEXTelemnumbersOrgGeomCol_vd2)
                                  end
                            end
                        end
                    end
                    if plotoriginalgeometry_atoms == 1
                        plot3(NNNCM(:,2), NNNCM(:,3), oazfc+NNNCM(:,4), 'kx', NNNCM(:,2), NNNCM(:,3), oazfc+NNNCM(:,4), 'ko')
                    end
                    if TEXTnodenumbersOrgGeom == 1
                        for count = 1:size(NNNCM,1)
                            text(NNNCM(count,2), NNNCM(count,3), oazfc+NNNCM(count,4), num2str(NNNCM(count,1)),...
                                'FontSize', TEXTnodenumbersOrgGeomFS, 'BackgroundColor',TEXTnodenumbersOrgGeomCol,'EdgeColor','k')
                        end
                    end
                end
                box on; axis equal; axis tight; pause(0.001)
        end
    case {'sfeam.ConstrainedNodes','sfeam.cn'}
        NTBC    = varargin{2};
        NNNCM   = varargin{3};
        lscount = varargin{4};
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
    case {'sfeam.LoadedNodes','sfeam.ln'}
        % plot the nodes which are loaded by FORCE
        
        lscount       = varargin{2}{1};
        NNNCM         = varargin{2}{2};
        NTBL          = varargin{2}{3};
        if lscount == 1
            mln = NNNCM(:,1); % my loaded nodes
            for count = 1:numel(NTBL)
                temp = find(mln==NTBL(count,1));
                plot3(NNNCM(temp,2), NNNCM(temp,3), NNNCM(temp,4), 'ko', 'MarkerFaceColor', 'c', 'MarkerSize',8)
                plot3(NNNCM(temp,2), NNNCM(temp,3), NNNCM(temp,4), 'k+', 'LineWidth', 2, 'MarkerSize',8)
            end
        end
    case {'sfeam.DisplacementLoadedNodes','sfeam.dln'}
        % plot the nodes which are loaded by DISPLACEMENT
        
        lscount       = varargin{2}{1};
        NNNCM         = varargin{2}{2};
        NTBD          = varargin{2}{3};
        if lscount == 1
            mln = NNNCM(:,1); % my loaded nodes
            for count = 1:numel(NTBD)
                temp = find(mln==NTBD(count,1));
                plot3(NNNCM(temp,2), NNNCM(temp,3), NNNCM(temp,4), 'ko', 'MarkerFaceColor', [0.7 0.9 0.7], 'MarkerSize',8)
                plot3(NNNCM(temp,2), NNNCM(temp,3), NNNCM(temp,4), 'k+', 'LineWidth', 2, 'MarkerSize',8)
            end
        end
    case {'sfeam.OverlayDefGeom','sfeam.ong'}
        switch varargin{2}
            case 'ag'
                    % EXAMPLE
                    % SGV('sfeam.OverlayDefGeom',...
                    %     'ag',...
                    %     {PlotOnlyAtFinalLoadStep, PlotForAllLoadSteps, lscount, LS},...
                    %     {plotdeformedgeometry_cov, plotdeformedgeometry_vd1, plotdeformedgeometry_vd2, plotdeformedgeometry_atoms},...
                    %     {econAnew, NNNCMnew})
                PlotOnlyAtFinalLoadStep = varargin{3}{1};
                PlotForAllLoadSteps     = varargin{3}{2};
                lscount                 = varargin{3}{3};
                LS                      = varargin{3}{4};
                
                plotdeformedgeometry_cov   = varargin{4}{1};
                plotdeformedgeometry_vd1   = varargin{4}{2};
                plotdeformedgeometry_vd2   = varargin{4}{3};
                
                plotdeformedgeometry_atoms_details = varargin{4}{4};
                
                plotdeformedgeometry_atoms = plotdeformedgeometry_atoms_details{1};
                %plotdeformedgeometry_atoms = {1, { 1,'ko','w',8 }, { 1,'kx','r',6 } };
                
                plotdeformedgeometry_atoms_marker1details       = plotdeformedgeometry_atoms_details{2};
                plotdeformedgeometry_atoms_marker1details_need  = plotdeformedgeometry_atoms_marker1details{1};
                plotdeformedgeometry_atoms_marker1details_type  = plotdeformedgeometry_atoms_marker1details{2};
                plotdeformedgeometry_atoms_marker1details_color = plotdeformedgeometry_atoms_marker1details{3};
                plotdeformedgeometry_atoms_marker1details_size  = plotdeformedgeometry_atoms_marker1details{4};
                
                plotdeformedgeometry_atoms_marker2details       = plotdeformedgeometry_atoms_details{3};
                plotdeformedgeometry_atoms_marker2details_need  = plotdeformedgeometry_atoms_marker2details{1};
                plotdeformedgeometry_atoms_marker2details_type  = plotdeformedgeometry_atoms_marker2details{2};
                plotdeformedgeometry_atoms_marker2details_color = plotdeformedgeometry_atoms_marker2details{3};
                plotdeformedgeometry_atoms_marker2details_size  = plotdeformedgeometry_atoms_marker2details{4};
                
                
                if plotdeformedgeometry_atoms == 1
                    if plotdeformedgeometry_atoms_marker1details_need == 0
                        plotdeformedgeometry_atoms_marker1details_need = 1; % Ensure atoms 'are' plotted when needed, buyt entries are wronly set..
                    end
                end
                
                
                econAnew = varargin{5}{1};
                NNNCMnew = varargin{5}{2};
                
                TEXTnodenumbersDefGeom    = varargin{6}{1};
                TEXTnodenumbersDefGeomFS  = varargin{6}{2};
                TEXTnodenumbersDefGeomCol = varargin{6}{3}{1};
                
                % OVERLAY PLOT THE NEW GEOMETRY
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
                            temp_PAUSE_exec(0, 0.025)
                        end
                        axis tight;
                        print('-djpeg100',strcat(pwd,'\DeformationPlot',num2str(lscount),'.jpeg'))
                    end
                elseif PlotOnlyAtFinalLoadStep == 1
                    if lscount == LS
                        for count = 1:size(econAnew)
                            % PLot only covalent bonds:
                            if plotdeformedgeometry_cov == 1
                                if econAnew(count,9)==1
                                    plot3([ econAnew(count,3) econAnew(count,6) ],...
                                          [ econAnew(count,4) econAnew(count,7) ],...
                                          [ econAnew(count,5) econAnew(count,8) ],'k','LineWidth',1)
                                end
                            end
                            if plotdeformedgeometry_vd1 == 1
                                if econAnew(count,9)==2
                                    plot3([ econAnew(count,3) econAnew(count,6) ],...
                                          [ econAnew(count,4) econAnew(count,7) ],...
                                          [ econAnew(count,5) econAnew(count,8) ],'b--','LineWidth',1)
                                end
                            end
                            if plotdeformedgeometry_vd2 == 1
                                if econAnew(count,9)==3
                                    plot3([ econAnew(count,3) econAnew(count,6) ],...
                                          [ econAnew(count,4) econAnew(count,7) ],...
                                          [ econAnew(count,5) econAnew(count,8) ],'g--','LineWidth',1)
                                end
                            end
                        end
                        
                        
                        
                        
                        
                        if plotdeformedgeometry_atoms ~= 0
                            for count = 1:size(NNNCMnew,1)
                                if plotdeformedgeometry_atoms_marker1details_need ~= 0
                                    plot3(NNNCMnew(count,2), NNNCMnew(count,3), NNNCMnew(count,4), plotdeformedgeometry_atoms_marker1details_type,...
                                        'MarkerFaceColor', plotdeformedgeometry_atoms_marker1details_color,...
                                        'MarkerSize', plotdeformedgeometry_atoms_marker1details_size)
                                end
                                if plotdeformedgeometry_atoms_marker2details_need ~= 0
                                    plot3(NNNCMnew(count,2), NNNCMnew(count,3), NNNCMnew(count,4), plotdeformedgeometry_atoms_marker2details_type,...
                                        'MarkerFaceColor', plotdeformedgeometry_atoms_marker2details_color,...
                                        'MarkerSize', plotdeformedgeometry_atoms_marker2details_size)
                                end
                            end
                        end
                        
                        
                        
                        
                        
                        if TEXTnodenumbersDefGeom ~= 0
                            for count = 1:size(NNNCMnew,1)
                                text(NNNCMnew(count,2), NNNCMnew(count,3), NNNCMnew(count,4), num2str(NNNCMnew(count,1)),...
                                    'FontSize', TEXTnodenumbersDefGeomFS, 'BackgroundColor',TEXTnodenumbersDefGeomCol,'EdgeColor','k')
                            end
                        end
                        
                        axis tight;
                        print('-djpeg100',strcat(pwd,'\DeformationPlot',num2str(lscount),'.jpeg'))
                    end
                end
        end
    case {'sfeam.PlotEndNodeDisp.2d','sfeam.pend.2d'}
        % PLOT THE END NODE Displacements
        lscount                  = varargin{3}{1};
        LS                       = varargin{3}{2};
        
        Displacement_NTBL_x      = varargin{4}{1};
        Displacement_NTBL_y      = varargin{4}{2};
        Displacement_NTBL_VecSum = varargin{4}{3};
        
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
    case {'sfeam.PlotNodalForceAlongZaxis.2d','sfeam.pnfaza.2d'}
        % PLOT NODAL REACTION FORCE GRAPHS ALONG Z-AXIS, ON CONSTRAINED NODES
        % Fx --- 'r' color '-' lines
        % Fy --- 'b' color '--' lines
        % Fz --- 'k' color ':' lines
        % FORMAT OF REACTION_X AND REACTION_Y
        % [  NODE    NodalReactionForce  ]
%         SGV('sfeam.PlotNodalForceAlongZaxis.2d',...
%             {'', ''},...
%             {PLOT_REACTION_FORCES_IN_GEOMETRY, REACTION_X, REACTION_Y, NNNCM})
        
        PLOT_REACTION_FORCES_IN_GEOMETRY = varargin{3}{1};
        REACTION_X                       = varargin{3}{2};
        REACTION_Y                       = varargin{3}{3};
        NNNCM                            = varargin{3}{4};
        
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
            figure(10)
            plot3(TEMPPX, TEMPPY, REACTION_X_NORMALIZED_SCALED(:,2),'r-','LineWidth',1)
            plot3(TEMPPX, TEMPPY, REACTION_Y_NORMALIZED_SCALED(:,2),'b--','LineWidth',1)
        end
    case {'sfeam.PlotLoadedNodes.AfterDef','sfeam.pnn.ad'}
%         SGV('sfeam.PlotLoadedNodes.AfterDef', {'',''}, {NNNCMnew, NTBL}, {lscount, LS})
        % PLOT THE LOADED ATOMS
        NNNCMnew = varargin{3}{1};
        NTBL     = varargin{3}{2};
        
        lscount  = varargin{4}{1};
        LS       = varargin{4}{2};
        if lscount == LS
            plot3(NNNCMnew(NTBL,2), NNNCMnew(NTBL,3), NNNCMnew(NTBL,4), 'bo', 'MarkerSize',10)
            plot3(NNNCMnew(NTBL,2), NNNCMnew(NTBL,3), NNNCMnew(NTBL,4), 'kx', 'MarkerSize',10)
            plot3(NNNCMnew(NTBL,2), NNNCMnew(NTBL,3), NNNCMnew(NTBL,4), 'k+', 'MarkerSize',10)
        end
end