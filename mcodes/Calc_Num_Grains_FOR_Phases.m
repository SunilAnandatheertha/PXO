function [NUM_Grains_PHASE] = Calc_Num_Grains_FOR_Phases(dimensionality, TimeSteps, All_Grains_time)
%---------------------------------------------------------
global PHASE
%---------------------------------------------------------
NUM_Phases = PHASE.Num_Phases;
%---------------------------------------------------------
% Segregate number of grains as per phase number
switch lower(dimensionality)
    case {'2d', 'thinfilm'}
        NUM_Grains_PHASE = cell(1, numel(All_Grains_time));
        for rset = 1:numel(TimeSteps) % Time slice level
            NUM_Grains_PHASE{rset} = cell(1, NUM_Phases);
            for nphase = 1:NUM_Phases % Phase level
                ngr = 0;
                for countq = 1:numel(All_Grains_time{rset}) % Orientation level
                    if ~isempty(All_Grains_time{rset}{countq})
                        for countng = 1:numel(All_Grains_time{rset}{countq}) % Grain level
                            ngr = ngr + 1;
                        end
                    end
                end
                NUM_Grains_PHASE{rset}{nphase} = ngr;
            end
        end
    case {'3d'}
        % Code here
    otherwise
        disp('invalid input')
end
end