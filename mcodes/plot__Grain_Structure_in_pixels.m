function plot__Grain_Structure_in_pixels(dimensionality, TimeSteps, All_Grains_time)

global Lattice
cm = Lattice.ColourMatrix_RGB_UnitNorm;
x  = Lattice.size.x;
y  = Lattice.size.y;

switch lower(dimensionality)
    case {'2d', 'thinfilm'}
        for rset = 1:numel(TimeSteps)
            figure, hold on, box on, set(gca, 'linewidth', 2)
            
            for countq = 1:numel(All_Grains_time{rset})
                if ~isempty(All_Grains_time{rset}{countq})
                    for countng = 1:numel(All_Grains_time{rset}{countq})
                        Grain_Lattice_Elements = All_Grains_time{rset}{countq}{countng};
                        grain_x = x(Grain_Lattice_Elements);
                        grain_y = y(Grain_Lattice_Elements);
                        plot(grain_x, grain_y,...
                             's',...
                             'markerfacecolor', cm(countq,:),...
                             'markeredgecolor', cm(countq,:),...
                             'markersize', 5)
                    end
                    pause(0.0001)
                end
            end
            axis equal; axis tight
        end
    case {'3d'}
        % Code here
    otherwise
        disp('invalid input')
end
end

% GrainBoundary_in_eq = boundary(xcoord, ycoord, BoundaryShrinkFactor);
% patchx = xcoord(GB_q); patchy = ycoord(GB_q);
% patch(patchx, patchy, GrainColor, 'FaceAlpha', 0.8)