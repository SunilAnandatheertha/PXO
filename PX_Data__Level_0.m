function [GDTable_0, GrainData_Matrix_0] = PX_Data__Level_0(TimeSteps, All_Grains_time, All_GrainAreas_time)
%----------------------------------------------
GrainData_1     = [];
NumOfTimeSlices = numel(All_Grains_time);
%----------------------------------------------
cm              = dlmread(strcat(pwd,'\results','\colormatrix.txt'));
%----------------------------------------------
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
%----------------------------------------------
GrainData_Matrix_0                 = GrainData_1;
GDTable_0                          = array2table(GrainData_1); % Grain Data Table
%----------------------------------------------
GDTable_0.Properties.Description   = ['Level 0: ',...
                                      'Provides only the very basic information of PXTal.',...
                                      'Filename: GDTable_0'];
%----------------------------------------------
VariableName__Unit__Description    = {'01', 'TSlice'      , '_NA_'  , '-number- of time slice (ith).OR.PXTal variant no.';...
                                      '02', 'TSliceValue' , 'mct'   , '-value-  of ith time slice, monte-carlo time';...
                                      '03', 'GrainID'     , '_NA_'  , '-number- of the grain: (nth)';...
                                      '04', 'Ori_ID'      , '_NA_'  , '-number- of the orientation (qth): ID';...
                                      
                                      '05', 'GrainAreaPXL', 'unit^2', '-value-  of the total grain pixel area';...
                                      '06', 'phi1'        , 'deg'   , '-value-  of the 1st Bunge Euler angle';...
                                      '07', 'psi'         , 'deg'   , '-value-  of the 2nd Bunge Euler angle';...
                                      '08', 'phi2'        , 'deg'   , '-value-  of the 3rd Bunge Euler angle';
                                      
                                      '09', 'Grain_CLR_R' , '_NA_'  , 'R in [R, G, B] used for nth grain [0 to 1]';...
                                      '10', 'Grain_CLR_G' , '_NA_'  , 'G in [R, G, B] used for nth grain [0 to 1]';...
                                      '11', 'Grain_CLR_B' , '_NA_'  , 'B in [R, G, B] used for nth grain [0 to 1]'};

                                  
VUD = VariableName__Unit__Description;
%----------------------------------------------
GDTable_0.Properties.VariableNames        = {VUD{1,2}, VUD{2,2}, VUD{3,2}, VUD{4,2},...
                                             VUD{5,2}, VUD{6,2}, VUD{7,2}, VUD{8,2},...
                                             VUD{9,2}, VUD{10,2}, VUD{11,2}};
%----------------------------------------------
fprintf('GDTable_0__COLUMN_01: %s ___[min: %d, max: %d]___\n',...
        VUD{1,2}, min(GDTable_0.TSlice), max(GDTable_0.TSlice))
fprintf('GDTable_0__COLUMN_02: %s ___[min: %d, max: %d]___\n',...
        VUD{2,2}, min(GDTable_0.TSliceValue), max(GDTable_0.TSliceValue))
fprintf('GDTable_0__COLUMN_03: %s \n', VUD{3,2})
fprintf('GDTable_0__COLUMN_04: %s \n', VUD{4,2})
fprintf('GDTable_0__COLUMN_05: %s ___[min: %4.2f, max: %4.2f]___ \n',...
        VUD{5,2}, min(GDTable_0.GrainAreaPXL), max(GDTable_0.GrainAreaPXL))
fprintf('GDTable_0__COLUMN_06: %s \n', VUD{6,2})
fprintf('GDTable_0__COLUMN_07: %s \n', VUD{7,2})
fprintf('GDTable_0__COLUMN_08: %s \n', VUD{8,2})
fprintf('GDTable_0__COLUMN_09: %s \n', VUD{9,2})
fprintf('GDTable_0__COLUMN_10: %s \n', VUD{10,2})
fprintf('GDTable_0__COLUMN_11: %s \n', VUD{11,2})
%----------------------------------------------
GDTable_0.Properties.VariableUnits        = {VUD{1,3}, VUD{2,3}, VUD{3,3}, VUD{4,3}, VUD{5,3}, VUD{6,3}, VUD{7,3}, VUD{8,3}, VUD{9,3}, VUD{10,3}, VUD{11,3}};
GDTable_0.Properties.VariableDescriptions = {VUD{1,4}, VUD{2,4}, VUD{3,4}, VUD{4,4}, VUD{5,4}, VUD{6,4}, VUD{7,4}, VUD{8,4}, VUD{9,4}, VUD{10,4}, VUD{11,4}};
%----------------------------------------------

%----------------------------------------------
end