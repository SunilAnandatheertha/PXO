function [centroid_x, centroid_y] = PlotXtals(TYPE, grainnumber, qid, xcoord, ycoord, xmin, xmax, xincr, ymin, ymax, ind_temp,...
                                              GB_q, cm, DynPlot)
%          PlotXtals('both', grainnumber, q, xcoord, ycoord, xmin, xmax, ymin, ymax, ind_temp, GrainBoundaries_In_q{grainnumber}, cm, 1, 1)
% q is taken in as qid: meaning ID of q. BCZ, q is planned to be later replaced with euler angles with further development

switch DynPlot{1}
    case 'plot_grains_dynamically'
        axis square
        box on
        hold on
        axis([xmin xmax ymin ymax])
        axis equal
        GrainColor = cm(qid,:);
        axis off
        %-----------------------------------------
        switch TYPE
            case lower('pixel')
                plot(xcoord, ycoord, 'ks', 'markerfacecolor', GrainColor, 'markersize', 4, 'markeredgecolor', GrainColor)
%                  switch DynPlot{3}
%                      case 'Plot_GrainNumber_and_q_at_grain_centroid'
                        [centroid_x, centroid_y] = PutGrainNumber_And_q_AtCentroid(grainnumber, qid, xcoord, ycoord, xincr, DynPlot);
%                      case 'Plot_GrainNumber_at_grain_centroid'
%                      case 'Plot_q_at_grain_centroid'
%                  end
                %-----------------------------------------
            case lower('patch')
                patchx = xcoord(GB_q); patchy = ycoord(GB_q);
                patch(patchx, patchy, GrainColor, 'FaceAlpha', 0.8)
                [centroid_x, centroid_y] = PutGrainNumber_And_q_AtCentroid(grainnumber, qid, patchx, patchy, xincr, DynPlot);
%                  switch DynPlot{3}
%                      case 'Plot_GrainNumber_and_q_at_grain_centroid'
                        [centroid_x, centroid_y] = PutGrainNumber_And_q_AtCentroid(grainnumber, qid, xcoord, ycoord, xincr, DynPlot);
%                      case 'Plot_GrainNumber_at_grain_centroid'
%                      case 'Plot_q_at_grain_centroid'
%                  end
                %-----------------------------------------
            case lower('both')
                plot(xcoord, ycoord, 'ks', 'markerfacecolor', GrainColor, 'markersize', 4, 'markeredgecolor', GrainColor), hold on
                 
                patchx = xcoord(GB_q);
                patchy = ycoord(GB_q);
                patch(patchx, patchy, GrainColor, 'FaceAlpha', 0.5)
                

                        [centroid_x, centroid_y] = PutGrainNumber_And_q_AtCentroid(grainnumber, qid, xcoord, ycoord, xincr, DynPlot);
                %-----------------------------------------
            otherwise
                disp('I am not plotting the grain face')
                disp('Only centroids are calculated')
                [centroid_x, centroid_y] = PutGrainNumber_And_q_AtCentroid(grainnumber, qid, xcoord, ycoord, xincr, DynPlot);
        end
    %-----------------------------------------
    case 'dont_plot_grains_dynamically'
        % Do nothing
end
    
end % FUNCTION END
%--------------------------------------------------------------------------------------------------
function [centroid_x, centroid_y] = PutGrainNumber_And_q_AtCentroid(grainnumber, qid, XOFGRAIN, YOFGRAIN, xincr, DynPlot)

centroid_x = mean(XOFGRAIN);
centroid_y = mean(YOFGRAIN);
switch DynPlot{3}
    case 'Dont_Plot_GrainNumber_and_q'
        % Do nothing
    case 'Plot_GrainNumber_and_q_at_grain_centroid'
        shift = -1; % Left if negative and right if posititve
        text(centroid_x + shift*xincr, centroid_y, [num2str(grainnumber) ',' num2str(qid)], 'fontsize', 8)
    case 'Plot_GrainNumber_at_grain_centroid'
        shift = -1; % Left if negative and right if posititve
        text(centroid_x + shift*xincr, centroid_y, num2str(grainnumber), 'fontsize', 8)
    case 'Plot_q_at_grain_centroid'
        shift = -1; % Left if negative and right if posititve
        text(centroid_x + shift*xincr, centroid_y, num2str(qid), 'fontsize', 8)
    otherwise
        % Do nothing now
end
end
%--------------------------------------------------------------------------------------------------
%--------------------------------------------------------------------------------------------------
