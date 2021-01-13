function plot__grain_centroids(dimensionality, GrainCentroid_xy_time)
%-------------------------------------------------------
global Lattice
cm  = Lattice.ColourMatrix_RGB_UnitNorm;
switch lower(dimensionality)
    case {'2d', 'thinfilm'}
        %-----------------------------
        ng_temp_count_time = zeros(numel(GrainCentroid_xy_time),1);
        for rset = 1:numel(GrainCentroid_xy_time)
            ng_temp_count_Q = 1;
            for countq = 1:numel(GrainCentroid_xy_time{rset})
                if ~isempty(GrainCentroid_xy_time{rset}{countq})
                    for countng = 1:numel(GrainCentroid_xy_time{rset}{countq})
                        ng_temp_count_Q = ng_temp_count_Q + 1;
                    end
                end
            end
            ng_temp_count_time(rset,1) = ng_temp_count_Q;
        end
        %-----------------------------
        for rset = 1:numel(GrainCentroid_xy_time)
            figure, hold on, grainnumber = 1;
            for countq = 1:numel(GrainCentroid_xy_time{rset})
                if ~isempty(GrainCentroid_xy_time{rset}{countq})
                    for countng = 1:numel(GrainCentroid_xy_time{rset}{countq})
                        x = GrainCentroid_xy_time{rset}{countq}{countng}(1);
                        y = GrainCentroid_xy_time{rset}{countq}{countng}(2);
                        plot(x,y,'ro')
                        text(x, y, num2str(grainnumber), 'fontsize', 8)
                        grainnumber = grainnumber + 1;
                    end
                end
            end
        end
            
%             for countq = 1:numel(GrainCentroid_xy_time{rset})
%                 xy_q = zeros(ng_temp_count_time(rset,1), 2);
%                 for countng = 1:ng_temp_count_time(rset,1)
%                     xy_q(countng,:) = GrainCentroid_xy_time{rset}{countq}{countng};
%                     text(xy_q(countng, 1), xy_q(countng, 2), num2str(grainnumber), 'fontsize', 8)
%                     grainnumber = grainnumber + 1;
%                 end
%                 plot(xy_q(:,1), xy_q(:,2), 'ko', 'markerfacecolor', cm(countq,:), 'markersize', 4, 'linewidth', 1)
%                 pause(0.1)
%             end
%             axis equal
%             box on
%         end
    case '3d'
        %-------------------------------------------------------
        % CODE FOR 3D COMES HERE
        %-------------------------------------------------------
end
%-------------------------------------------------------
end