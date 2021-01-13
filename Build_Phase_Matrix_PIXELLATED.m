function [phase_matrix_pixellated] = Build_Phase_Matrix_PIXELLATED()

global PHASE

x  = Lattice.size.x;
%---------------------------------------------------------
LatticeSize = size(x);
phase       = zeros(LatticeSize);
%---------------------------------------------------------
switch lower(dimensionality)
    case {'2d', 'thinfilm'}
        for rset = 1:numel(TimeSteps) % Time slice level
            for nphase = 1:PHASE.Num_Phases % Phase level
                EA_Grains_rset_phase = Temporal_Phase_Texture{rset}{nphase}{3};
                ngrain_phase = 1;
                for countq = 1:numel(All_Grains_time{rset}) % Orientation level
                    if ~isempty(All_Grains_time{rset}{countq})
                        for countng = 1:numel(All_Grains_time{rset}{countq}) % Grain level
                            ThisGrain_EA = EA_Grains_rset_phase(ngrain_phase,:);
                            for countLS = 1:numel(All_Grains_time{rset}{countq}{countng}) % Lattice site level
                                % going to lattice site level renders this code for further development.
                                phase(All_Grains_time{rset}{countq}{countng}(countLS)) = nphase;
                            end
                            ngrain_phase = ngrain_phase + 1;
                        end
                    end
                end
            end
        end
    case {'3d'}
        % Code here
    otherwise
        disp('invalid input')
end

end