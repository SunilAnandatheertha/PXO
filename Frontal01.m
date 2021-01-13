function [TimeSteps, All_Grains_time, All_GrainBoundaries_time, All_GrainAreas_time, All_GrainEqGrainSize_time, ogn, CFN] = Frontal01(CFN)
% clear all; close all
%------------------------------------------------------
% rset = 4;
%------------------------------------------------------
latpar1     = dlmread(strcat(pwd,'\simparameters','\latpar.txt'));
% slspinfo1     = dlmread(strcat(pwd,'\simparameters','\slspinfo.txt'));
% icntinfo1     = dlmread(strcat(pwd,'\simparameters','\icntinfo.txt'));
% slpclustinfo1 = dlmread(strcat(pwd,'\simparameters','\slpclustinfo.txt'));
simpar1     = dlmread(strcat(pwd,'\simparameters','\simpar.txt'));
ffo1        = dlmread(strcat(pwd,'\simparameters','\ffo.txt'));
cm          = dlmread(strcat(pwd,'\results','\colormatrix.txt'));
xmin        = latpar1(1); xmax        = latpar1(2);
ymin        = latpar1(3); ymax        = latpar1(4);
xincr       = latpar1(5); yincr       = latpar1(6);
% xlength     = abs(xmin)+abs(xmax);
% ylength     = abs(ymin)+abs(ymax);
[x,y]       = meshgrid(xmin:xincr:xmax,ymin:yincr:ymax);
Q           = simpar1(1);
m           = simpar1(2);
% wantslsp    = slspinfo1(1);
% wantcnt     = icntinfo1(1);
% wantslspclust = slpclustinfo1(1);
txtwriteint = ffo1(1);
% sz1         = size(x,1);
% sz2         = size(x,2);
%------------------------------------------------------
TimeSteps    = txtwriteint:txtwriteint:m;
NtimeSteps   = numel(1:1:(m/txtwriteint));
%------------------------------------------------------
All_Grains_time           = cell(1,NtimeSteps);
All_GrainBoundaries_time  = cell(1,NtimeSteps);
All_GrainAreas_time       = cell(1,NtimeSteps);
All_GrainEqGrainSize_time = cell(1,NtimeSteps);

FileLocations             = cell(1,NtimeSteps);
GenericFileName           = cell(1,NtimeSteps);
ImageFileName             = cell(1,NtimeSteps);
%------------------------------------------------------
for rset = 1:1:(m/txtwriteint)
    filename = strcat(pwd,'\results\datafiles\statematrices','\s',...
                      num2str(rset*txtwriteint),'mcs',num2str(1),'.txt');
    s        = dlmread(filename);
    %------------------------------------------------------
    CFN      = length(findobj('type','figure'));
    figure(CFN + 1)
    pause(1)
    %------------------------------------------------------
    All_Grains_Q           = cell(1,Q);
    All_GrainBoundaries_Q  = cell(1,Q);
    All_GrainAreas_Q       = cell(1,Q);
    All_GrainEqGrainSize_Q = cell(1,Q);
    pixelarea              = xincr*yincr;
    %------------------------------------------------------
    ogn             = 0; % overall grain number
    %------------------------------------------------------
    %------------------------------------------------------
    %------------------------------------------------------
    guessnoofgrains = 1e3;
    %------------------------------------------------------
    %------------------------------------------------------
    %------------------------------------------------------
    grainnumber     = 0;
    %------------------------------------------------------
    for q = 1:Q
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
                    PlotXtals('both', grainnumber, q, xcoord, ycoord, xmin, xmax, xincr, ymin, ymax, ind_temp,...
                              GrainBoundaries_In_q{ng}, cm, 1, 1)
                    %------------------------------------------------------
                    Plot_GB(1, xcoord, ycoord, GrainBoundaries_In_q{ng}) % Plot the grain boundaries
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
        end
        pause(0.001)
    end
    pause(0.25) % Do not remove this pause !!
    %------------------------------------------------------
    All_Grains_time{1,rset}           = All_Grains_Q;
    All_GrainBoundaries_time{1,rset}  = All_GrainBoundaries_Q;
    All_GrainAreas_time{1,rset}       = All_GrainAreas_Q;
    All_GrainEqGrainSize_time{1,rset} = All_GrainEqGrainSize_Q;
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
    mkdir([pwd FileLocations])
    %------------------------------------------------------
end

% function haha()
% %--------------------------------
% % LEVEL: 1: DIFFERENT POLYCRYSTAL DOMAINS
% n_PX = 2; % Number of polycrystals domains
% PX_cl = cell(1,n_PX);
% PX = struct('PX_data', PX_cl);
% % PX_data = poly-crystal data
% % PX(1).PX_data: Gives 1st polycrystal data
% %--------------------------------
% % LEVEL: 2: DIFFERENT DATA FOR EVERY POLYCRYSTAL
% No_datatypes_PX = 2;
% for npx = 1:n_PX
%     PX(npx).PX_data = cell(1,No_datatypes_PX);
% end
% % cell(1,1): Raw grain data
% % cell(1,2): Grain statistics data
% %--------------------------------
% % LEVEL: 2: DIFFERENT DATA FOR EVERY POLYCRYSTAL
% for npx = 1:n_PX
%     for ndtypePX = 1:No_datatypes_PX
%         if ndtypePX == 1
%             PX(npx).PX_data(ndtypePX).RAWD = cell(1,1);
%         elseif ndtypePX == 2
%             PX(npx).PX_data(ndtypePX) = cell(1,4);
%         end
%     end
% end
% % Expansion:
% % if n_PX = 2 and No_datatypes_PX = 2, then
% % PX(1).PX_data(1): Stores raw data 1st polycrystal
% % PX(1).PX_data(2): Stores grain statistics data for 1st polycrystal
% % PX(2).PX_data(1): Stores raw data 2nd polycrystal
% % PX(2).PX_data(2): Stores grain statistics data for 2nd polycrystal
% %--------------------------------
% PX(npx).PX_data(ndtypePX).
% 
% patient(1).name = 'John Doe';
% patient(1).billing = 127.00;
% patient(1).test = [79, 75, 73; 180, 178, 177.5; 220, 210, 205];
% 
% 
% %--------------------------------
% % LS: Lattice sites
% clear PX
% % Get the coordinates of all lattice sites
% PX.PX_data.RAW.LS.xy = struct('LS_Coord', cell(1,2));
% % Get the state matrix
% PX.PX_data.RAW.LS.s  = struct('LS_S_Matrix', cell(1,1));
% % Get the element number matrix
% PX.PX_data.RAW.LS.e  = struct('LS_Elem', cell(1,1));
% % Get the appended element number matrix
% PX.PX_data.RAW.LS.ea = struct('LS_Elem_App', cell(1,1));
% % Get all grains (actually lattice sites) of each orientations:
% PX.PX_data.RAW.LS.q  = struct('LS_all_q', cell(1,64));
% % Get the xoordinates of all zener SLSP particles
% PX.PX_data.RAW.ZS.xy = struct('ZS_Coord', cell(1,2));
% % Get the element numbers of all zener SLSP particles
% PX.PX_data.RAW.ZS.e  = struct('ZS_Elem', cell(1,1));
% end
end