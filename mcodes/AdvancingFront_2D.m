function [TimeSteps, All_Grains_time, All_GrainBoundaries_time,...
    All_GrainAreas_time, All_GrainEqGrainSize_time, GrainCentroid_xy_time, ogn,...
    CFN, FileLocations, GenericFileName, ImageFileName] = AdvancingFront_2D(CFN, ALGORITHM, DynPlot)
% clear all; close all
%------------------------------------------------------
global Lattice MC_Param MC_Loop
% rset = 4;
%------------------------------------------------------
xmin        = Lattice.size.xmin;
xmax        = Lattice.size.xmax;
ymin        = Lattice.size.ymin;
ymax        = Lattice.size.ymax;
xincr       = Lattice.size.i_incr;
yincr       = Lattice.size.j_incr;
cm          = Lattice.ColourMatrix_RGB_UnitNorm;
x           = Lattice.size.x;
y           = Lattice.size.y;
Q           = Lattice.q;
m           = MC_Param.Num_MC_Steps;
txtwriteint = MC_Loop.DataOperation.txtwriteint;
%------------------------------------------------------
TimeSteps    = txtwriteint:txtwriteint:m;
NtimeSteps   = numel(1:1:(m/txtwriteint));
%------------------------------------------------------
All_Grains_time           = cell(1,NtimeSteps);
All_GrainBoundaries_time  = cell(1,NtimeSteps);
All_GrainAreas_time       = cell(1,NtimeSteps);
All_GrainEqGrainSize_time = cell(1,NtimeSteps);
GrainCentroid_xy_time     = cell(1,NtimeSteps);

FileLocations             = cell(1,NtimeSteps);
GenericFileName           = cell(1,NtimeSteps);
ImageFileName             = cell(1,NtimeSteps);
%------------------------------------------------------
switch ALGORITHM
    case 'ALG_01'
        for rset = 1:1:(m/txtwriteint)
            filename = strcat(pwd,'\results\datafiles\statematrices','\s',...
                              num2str(rset*txtwriteint),'mcs',num2str(1),'.txt');
            s        = dlmread(filename);
            %------------------------------------------------------
            CFN      = length(findobj('type','figure'));
            figure(CFN + 1)
            pause(0.001)
            %------------------------------------------------------
            All_Grains_Q           = cell(1,Q);
            All_GrainBoundaries_Q  = cell(1,Q);
            All_GrainAreas_Q       = cell(1,Q);
            All_GrainEqGrainSize_Q = cell(1,Q);
            pixelarea              = xincr*yincr;
            GrainCentroid_xy_Q     = cell(1,Q);
            %------------------------------------------------------
            ogn             = 0; % overall grain number
            %------------------------------------------------------
            guessnoofgrains = 1e3;
            %------------------------------------------------------
            grainnumber     = 0;
            %------------------------------------------------------
            for q = 1:Q
                %------------------------------------------------------
                
                %------------------------------------------------------
                [eq, xq, yq,...
                 GRAINS_In_q, GrainBoundaries_In_q,...
                 GrainAreas_In_q, GrainEqGrainSize_q] = Initialize_eq_xyq_GRAINS_In_q(q, s,...
                                                                        x, y, guessnoofgrains);
                %------------------------------------------------------
                eq_stat = eq; xq_stat = xq; yq_stat = yq;
                %------------------------------------------------------
                if q~=1; delete(ht); end
                titlestring2 = {['Temporal slice #: ', num2str(rset*txtwriteint)],...
                                [' Orientation #: ', num2str(q)]};
                ht           = title(titlestring2, 'fontsize', 10);
                %------------------------------------------------------
                if ~isempty(eq)
                    eq_dyn0 = eq; xq_dyn0 = xq; yq_dyn0 = yq;
                    %------------------------------------------------------
                    for ng = 1:guessnoofgrains
                        % This loop will run till all grains in q have been identified
                        GrainFull = 0;
                        if ~isempty(eq_dyn0)
                            Type_of_SP = 0;
                            %------------------------------------------------------
                            [grain, eq_dyn0, xq_dyn0, yq_dyn0] = Identify_one_Grain_In_q(ng, eq_stat, xq_stat, yq_stat,...
                                                                                         eq, xq, yq, xincr, yincr,...
                                                                                         Type_of_SP, GrainFull,...
                                                                                         eq_dyn0, xq_dyn0, yq_dyn0);
                            GRAINS_In_q{ng} = grain;
                            grainnumber     = grainnumber + 1;
                            %------------------------------------------------------
                            [ind_temp, xcoord, ycoord, GrainBoundaries_In_q{ng}] = Find_GB(eq, grain, xq, yq, 1, 1.0);
                            %------------------------------------------------------
                            [centroid_x, centroid_y] = PlotXtals('pixel', grainnumber, q, xcoord, ycoord, xmin, xmax, xincr, ymin, ymax, ind_temp,...
                                                                 GrainBoundaries_In_q{ng}, cm, DynPlot);
                            GrainCentroid_xy_q{1,ng} = [centroid_x, centroid_y];
                            %------------------------------------------------------
                            Plot_GB(0, q, xcoord, ycoord, GrainBoundaries_In_q{ng}, cm, DynPlot) % Plot the grain boundaries
                            %------------------------------------------------------
                            %%% ThisGrainArea           = polyarea(xcoord(Bindices), ycoord(Bindices));
                            %%% GrainAreas_In_q{ng}     = ThisGrainArea;
                            ThisGrainArea            = numel(grain)*pixelarea;
                            GrainAreas_In_q{ng}      = ThisGrainArea;
                            %------------------------------------------------------
                            GrainEqGrainSize_q{ng}     = sqrt(ThisGrainArea/pi); % This is Radius not diameter!
                            %------------------------------------------------------
                        else
                            [GRAINS_In_q]          = Rem_Empty_cells_GRAINS_In_q(GRAINS_In_q);
                            [GrainBoundaries_In_q] = Rem_Empty_cells_GRAINBoundaries_In_q(GrainBoundaries_In_q);
                            [GrainAreas_In_q]      = Rem_Empty_cells_GRAINAreas_In_q(GrainAreas_In_q);
                            [GrainEqGrainSize_q]   = Rem_Empty_cells_GRAINEqviGrainSize_In_q(GrainEqGrainSize_q);
                            break
                        end
                        ogn       = ogn + 1;
                        MsgString = 'q = %d  --  Grain #(%d in q, %d in PXtal)-- Grain area %4.1f unit^2 \n';
                        fprintf(MsgString, q, ng, ogn, ThisGrainArea)
        %                 pause(0.001)
                    end
                    All_Grains_Q{q}          = GRAINS_In_q;
                    All_GrainBoundaries_Q{q} = GrainBoundaries_In_q;
                    All_GrainAreas_Q{q}      = GrainAreas_In_q;
                    All_GrainEqGrainSize_Q   = GrainEqGrainSize_q;
                    GrainCentroid_xy_Q{q}    = GrainCentroid_xy_q;
                end
                pause(0.001)
            end
            pause(0.1) % Do not remove this pause !!
            %------------------------------------------------------
            All_Grains_time{1,rset}           = All_Grains_Q;
            All_GrainBoundaries_time{1,rset}  = All_GrainBoundaries_Q;
            All_GrainAreas_time{1,rset}       = All_GrainAreas_Q;
            All_GrainEqGrainSize_time{1,rset} = All_GrainEqGrainSize_Q;
            GrainCentroid_xy_time{1,rset}     = GrainCentroid_xy_Q;
            %------------------------------------------------------
            if rset<10;                    ThisGenericName = ['XTal__GrainStruct__SliceNo__000' num2str(rset) '__' 'Time__' num2str(TimeSteps(rset))];
            elseif rset>=10 && rset<100;   ThisGenericName = ['XTal__GrainStruct__SliceNo__00'  num2str(rset) '__' 'Time__' num2str(TimeSteps(rset))];
            elseif rset>=100 && rset<1000; ThisGenericName = ['XTal__GrainStruct__SliceNo__0'   num2str(rset) '__' 'Time__' num2str(TimeSteps(rset))];
            else rset>=1000;               ThisGenericName = ['XTal__GrainStruct__SliceNo__'    num2str(rset) '__' 'Time__' num2str(TimeSteps(rset))];
            end
            %------------------------------------------------------
            ThisFileLocation      = ['\results\plots\XTal_2D_Visualizaiton__V2_0\XTalVis__TimeSliceNo_' num2str(rset)];
            ThisImageName         = [ThisGenericName '.jpeg'];
            %------------------------------------------------------
            GenericFileName{1,rset} = ThisGenericName;
            ImageFileName{1,rset}   = ThisImageName;
            FileLocations{1,rset}   = ThisFileLocation;
            %------------------------------------------------------
            try 
                rmdir([pwd ThisFileLocation], 's')
            catch
                % Do nothing
            end
            mkdir([pwd ThisFileLocation])
            %------------------------------------------------------
            switch DynPlot{2}
                case 'printjpeg'
                    disp('Writing image file...')
                    print('-djpeg100', [pwd ThisFileLocation filesep ThisImageName])
                otherwise
            end
            %------------------------------------------------------
        end
    otherwise
end
end