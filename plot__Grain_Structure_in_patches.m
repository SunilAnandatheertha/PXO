function plot__Grain_Structure_in_patches(dimensionality, TimeSteps, All_Grains_time)

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
                        GrBound = boundary(grain_x, grain_y, 1.0);
                        patch(grain_x(GrBound), grain_y(GrBound), cm(countq,:), 'FaceAlpha', 1.0)
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