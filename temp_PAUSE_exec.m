function temp_PAUSE_exec(PauseInBetween, PauseDuration)
% THIS FUNCTION CAUSES A TEMPORARY PAUSE IN EXECUTION FOR A TIME DURATION SPECIFIED BY "PauseDuration", ONLY IF "PauseInBetween == 1"

if PauseInBetween == 1
    pause(PauseDuration)
end

end