function [Fil_Fol_Table] = BookKeeping_FFNames(FileLocations, GenericFileName, ImageFileName, DataFileNames,...
                                               TimeSteps, All_Grains_time, All_GrainAreas_time)

% [----] = BookKeeping_FFNames(-----)
% Internal function calls: (1) NONE
% todo_A [AA-AA-20]-[AA-AA-20]: 

NumOfTimeSlices = numel(All_Grains_time);
for c1 = 1:NumOfTimeSlices % Number of temporal slices
    Tslice    = c1;
    TimeValue = TimeSteps(c1);
    %----------------------------------------------
    NumOriInTimeSlice = numel(All_Grains_time{c1}); % Number of q in each temporal slice
    GrainNumber       = 0;
    for c2 = 1:NumOriInTimeSlice
        NumGrainsInThisq = numel(All_Grains_time{c1}{c2});
        if NumGrainsInThisq == 0 % If there are no grains in this q
            Orientation_ID = c2;
            Areaofgrain    = 0;
            phi1           = -1;
            psi            = -1;
            phi2           = -1;
            Color_Grains_R = 0;
            Color_Grains_G = 0;
            Color_Grains_B = 0;
            toappend       = [Tslice, TimeValue, 0, Orientation_ID,...
                              Areaofgrain,...
                              phi1, psi, phi2,...
                              Color_Grains_R, Color_Grains_G, Color_Grains_B];
            GrainData_1    = [GrainData_1; toappend];
         else % If there are grains in this q
            for c3 = 1:NumGrainsInThisq
                GrainNumber = GrainNumber + 1;
                Orientation_ID = c2;
                Areaofgrain    = All_GrainAreas_time{c1}{c2}{c3};
                phi1_mean      = randi(360);
                psi_mean       = randi(360);
                phi2_mean      = randi(360);
                Color_Grains_R = cm(c2,1);
                Color_Grains_G = cm(c2,2);
                Color_Grains_B = cm(c2,3);
                toappend       = [Tslice, TimeValue, GrainNumber, Orientation_ID,...
                                  Areaofgrain,...
                                  phi1_mean, psi_mean, phi2_mean,...
                                  Color_Grains_R, Color_Grains_G, Color_Grains_B];
                GrainData_1    = [GrainData_1; toappend];
            end
        end
        %------------------------------------------
    end
end

end