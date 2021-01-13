function [CFN, DataFileNames, Number_of_grains, Grain_Area_PXL] = FindPlotWriteStatistics2d(All_GrainAreas_time, All_Grains_time, ogn, CFN,...
                                           WriteGrainIndicesToDisk, FileLocations, GenericFileName)
% % clear all; close all
% %------------------------------------------------------
% % rset = 4;
% %------------------------------------------------------
% latpar1     = dlmread(strcat(pwd,'\simparameters','\latpar.txt'));
% % slspinfo1     = dlmread(strcat(pwd,'\simparameters','\slspinfo.txt'));
% % icntinfo1     = dlmread(strcat(pwd,'\simparameters','\icntinfo.txt'));
% % slpclustinfo1 = dlmread(strcat(pwd,'\simparameters','\slpclustinfo.txt'));
simpar1     = dlmread(strcat(pwd,'\simparameters','\simpar.txt'));
ffo1        = dlmread(strcat(pwd,'\simparameters','\ffo.txt'));
cm          = dlmread(strcat(pwd,'\results','\colormatrix.txt'));
% xmin        = latpar1(1); xmax        = latpar1(2);
% ymin        = latpar1(3); ymax        = latpar1(4);
% xincr       = latpar1(5); yincr       = latpar1(6);
% % xlength     = abs(xmin)+abs(xmax);
% % ylength     = abs(ymin)+abs(ymax);
% [x,y]       = meshgrid(xmin:xincr:xmax,ymin:yincr:ymax);
Q           = simpar1(1);
m           = simpar1(2);
% % wantslsp    = slspinfo1(1);
% % wantcnt     = icntinfo1(1);
% % wantslspclust = slpclustinfo1(1);
txtwriteint = ffo1(1);
% % sz1         = size(x,1);
% % sz2         = size(x,2);
%------------------------------------------------------
NtimeSteps       = numel(1:1:(m/txtwriteint));
Number_of_grains = cell(numel(1:1:(m/txtwriteint)), 1);
Grain_Area_PXL   = cell(numel(1:1:(m/txtwriteint)), 1);
%------------------------------------------------------
for rset = 1:1:(m/txtwriteint)
    titlestring1 = ['Temporal slice #: ', num2str(rset*txtwriteint)];
    %------------------------------------------------------
    % GRAIN AREA STATISTICS: get and plot
    [CFN, GA] = GASTAT(All_GrainAreas_time{rset}, ogn, 25, CFN, titlestring1);
    Grain_Area_PXL{rset, 1} = GA;
    pause(0.01)
    %------------------------------------------------------
    % GRAIN NUMBER PER q STATISTICS: get and plot
    [Number_of_grains_this_slice] = GNSTAT_Q(All_GrainAreas_time{rset}, Q, 50, CFN, titlestring1, cm);
    Number_of_grains{rset, 1} = Number_of_grains_this_slice;
    pause(0.5)
    %------------------------------------------------------
end
%------------------------------------------------------
% WRITE (INDICES OF LATTICE ELEMENTS OF EACH GRAIN TO .dat FILE
[DataFileNames] = WriteData('grainindices', WriteGrainIndicesToDisk, FileLocations,...
                            GenericFileName, All_Grains_time, m,...
                            txtwriteint, NtimeSteps);
end