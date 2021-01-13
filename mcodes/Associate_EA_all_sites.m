function [EulerAngles_Pixellated] = Associate_EA_all_sites(dimensionality, TimeSteps,...
                                                    All_Grains_time,...
                                                    Temporal_Phase_Texture)
%---------------------------------------------------------
global Lattice PHASE
%---------------------------------------------------------
x  = Lattice.size.x;
%---------------------------------------------------------
N_Time_Slices = numel(TimeSteps);
LatticeSize   = size(x);
%---------------------------------------------------------
phi1_rset   = cell(1, N_Time_Slices);
psi_rset    = cell(1, N_Time_Slices);
phi2_rset   = cell(1, N_Time_Slices);

phi1        = zeros(LatticeSize);
psi         = zeros(LatticeSize);
phi2        = zeros(LatticeSize);
%---------------------------------------------------------
switch lower(dimensionality)
    case {'2d', 'thinfilm'}
        for rset = 1:N_Time_Slices % Time slice level
            for nphase = 1:PHASE.Num_Phases % Phase level
                EA_Grains_rset_phase = Temporal_Phase_Texture{rset}{nphase}{3};
                ngrain_phase = 1;
                for countq = 1:numel(All_Grains_time{rset}) % Orientation level
                    if ~isempty(All_Grains_time{rset}{countq})
                        for countng = 1:numel(All_Grains_time{rset}{countq}) % Grain level
                            ThisGrain_EA = EA_Grains_rset_phase(ngrain_phase,:);
                            for countLS = 1:numel(All_Grains_time{rset}{countq}{countng}) % Lattice site level
                                % going to lattice site level renders this code for further development.
                                phi1(All_Grains_time{rset}{countq}{countng}(countLS)) = ThisGrain_EA(1);
                                psi(All_Grains_time{rset}{countq}{countng}(countLS)) = ThisGrain_EA(2);
                                phi2(All_Grains_time{rset}{countq}{countng}(countLS)) = ThisGrain_EA(3);
                            end
                            ngrain_phase = ngrain_phase + 1;
                        end
                    end
                end
            end
            phi1_rset{1, rset} = phi1;
            psi_rset{1, rset}  = psi;
            phi2_rset{1, rset} = phi2;
        end
    case {'3d'}
        % Code here
    otherwise
        disp('invalid input')
end
EulerAngles_Pixellated.phi1 = phi1_rset;
EulerAngles_Pixellated.psi  = psi_rset;
EulerAngles_Pixellated.phi2 = phi2_rset;
%---------------------------------------------------------
end