function [latpar,simpar,slspinfo,icntinfo,clusterinfo,solset,ffo,grapho, CFN] = pi2d(CFN)

%% LATTICE PARAMETERS
% CELL BLOCK OUTPUT VARIABLE(s): latpar{:,:}
%---------------------------------------------------------------------------------------------
% latticenumber = 11;
% if latticenumber     == 01; latticesizei = 0051; latticesizej = 0051;%01-0050x0050 SQUARE
% elseif latticenumber == 11; latticesizei = 101; latticesizej = 101;%01-0050x0040 RECTANBGLE
% elseif latticenumber == 02; latticesizei = 0100; latticesizej = 0100;%02-0100x0100 SQUARE
% elseif latticenumber == 03; latticesizei = 0150; latticesizej = 0150;%03-0150x0150 SQUARE
% elseif latticenumber == 04; latticesizei = 0200; latticesizej = 0200;%04-0200x0200 SQUARE
% elseif latticenumber == 05; latticesizei = 0300; latticesizej = 0300;%05-0300x0300 SQUARE
% elseif latticenumber == 06; latticesizei = 0500; latticesizej = 0500;%06-0500x0500 SQUARE
% elseif latticenumber == 07; latticesizei = 0750; latticesizej = 0750;%07-0750x0750 SQUARE
% elseif latticenumber == 08; latticesizei = 1000; latticesizej = 1000;%08-1000x1000 SQUARE
% elseif latticenumber == 09; latticesizei = 1500; latticesizej = 1500;%09-1500x1500 SQUARE
% elseif latticenumber == 10; latticesizei = 2000; latticesizej = 2000;%10-2000x2000 SQUARE
% elseif latticenumber == 51; latticesizei = 0500; latticesizej = 0200;%51-0500x0200 RECTANGLE
% elseif latticenumber == 52; latticesizei = 1000; latticesizej = 0400;%52-1000x0400 RECTANGLE
% end

latticesizei = 25;
latticesizej = 25;

q = 32;
m = 1.0E3;
txtwriteint = 500;              % MCS interval to write data to disk
% Use next 2 lines to define custom values by uncommenting
% latticesizei = 50;
% latticesizej = 50;
%---------------------------------------------------------------------------------------------
xmin  = -floor(latticesizei)/2+1; % latpar{1,01}
xmax  =  floor(latticesizei)/2;   % latpar{1,02}
ymin  = -floor(latticesizej)/2+1; % latpar{1,03}
ymax  =  floor(latticesizej)/2;   % latpar{1,04}
xincr = 1;                       % latpar{1,05}
yincr = 1;                       % latpar{1,06}
PERTURBfactor = 0;               % latpar{1,07}
%---------------------------------------------------------------------------------------------
latpar{1,:}   = {xmin, xmax, ymin, ymax, xincr, yincr, PERTURBfactor};
dlmwrite(strcat(pwd,'\simparameters','\latpar.txt'),...
    [latpar{1}{1} latpar{1}{2} latpar{1}{3} latpar{1}{4} latpar{1}{5} latpar{1}{6} latpar{1}{7}]')
%---------------------------------------------------------------------------------------------
%% SIMULATION PARAMETERS
% CELL BLOCK OUTPUT VARIABLE(s): simpar{:,:}
SCMD('seperator','type02',4,1);
SCMD('ssam.pi','simpar01')

% q = input('Number of Q-states (ENTER to accept def. of 64):: ');
% m = input('Number of Monte-Carlo steps (ENTER to accept def. of 1E4):: ');
% if numel(q) == 0
%     q = 64;
% end
% if numel(m) == 0
%     m = 0.2E4;
% end


simpar{1,:} = {q, m};
dlmwrite(strcat(pwd,'\simparameters','\simpar.txt'),[simpar{1}{1} simpar{1}{2}]')
SCMD('seperator','type02',4,1);
%<><><><><><><><><><><><><><><><><><>
%% SINGLE LATTICE SITE PARTICULATES INFORMATION
% CELL BLOCK OUTPUT VARIABLE(s): slspinfo{:,:}
wantslsp        = 0;    % Want Single Latice Site particles
volumefrac_slsp = 1.00; % VOLUME FRACTION IN PERCENTAGE
slspinfo{1,:}   = {wantslsp, volumefrac_slsp}; % single lattice site particlulate info
dlmwrite(strcat(pwd,'\simparameters','\slspinfo.txt'),[slspinfo{1}{1} slspinfo{1}{2}]')
%---------------------------------------------------------------------------------------------
%% INDIVIDUAL CNT INFORMATION
% CELL BLOCK OUTPUT VARIABLE(s): icntinfo
wantcnt         = 0;          % this goes to icntinfo{1}{1}.
noofcnt         = 0032;       % this goes to icntinfo{1}{2}.
NpCNT           = 0050;       % this goes to icntinfo{1}{3}. Number of co-ordinate points to use per CNT
genradiusfactor = 1.0000;     % this goes to icntinfo{1}{4}. Cut-off radius factor for each NpCNT of each noofcnt
cntinsidefactor = 0.9500;     % this goes to icntinfo{1}{5}. If CNT length is more, decrease this value
thicknessfactor = 1.0000;     % this goes to icntinfo{1}{6}. Controls CNT thickness
startingangle   = 0;          % this goes to icntinfo{1}{7}. Default is 0 deg. leave this unaltered.
thetaone        = 000;        % this goes to icntinfo{1}{8}(:). Input should be single row matrix
thetatwo        = 030;        % this goes to icntinfo{1}{9}(:). Input should be single row matrix
overlaycntsinlatticeplot = 1; % this goes to icntinfo{1}{10}.
ROTATEiCNTs     = 1;          % this goes to icntinfo{1}{11}. Rotate individual CNTs. 1-yes.0-no.
rotateallaboutsameangle  = 0; % this goes to icntinfo{1}{12}. 1-yes.0-no.
icntrotang      = 5;          % this goes to icntinfo{1}{13}. it will be be used only if icntinfo{1,13} is 1;
% If above variable takes '0', only CNT lattice sites will be plotted
% If above variable takes '1', actual CNT line will also be plotted
icntinfo{1,:} = {wantcnt, noofcnt, NpCNT, genradiusfactor,...
    cntinsidefactor, thicknessfactor, startingangle, thetaone,...
    thetatwo, overlaycntsinlatticeplot, ROTATEiCNTs, rotateallaboutsameangle, icntrotang}; % icntinfo - individual cntinfo
dlmwrite(strcat(pwd,'\simparameters','\icntinfo.txt'),...
    [icntinfo{1}{01}; icntinfo{1}{02}; icntinfo{1}{03}; icntinfo{1}{04}; icntinfo{1}{05}; icntinfo{1}{06}; icntinfo{1}{7};...
     icntinfo{1}{08}; icntinfo{1}{09}; icntinfo{1}{10}; icntinfo{1}{11}; icntinfo{1}{12}; icntinfo{1}{13}])
%---------------------------------------------------------------------------------------------
%% INFORMATION ON CIRCULAR CLUSTERING OF single lattice site PARTICULATES
% CELL BLOCK OUTPUT VARIABLE(s): slpclustinfo{:,:}
wantslspclust         = 0;        % This goes to slpclustinfo{1}{1} %'0' if no clustering is not desired
typeofcluster         = 1;        % This goes to slpclustinfo{1}{2} %'1': circular clustering
noslspclusters        = 1;     % This goes to slpclustinfo{1}{3} %Set the number of circular clusters
clusterdistr          = 1;        % This goes to slpclustinfo{1}{4} %1:RANDOM %2:SQUARE %3: Hexagonal
islspcvf              = 01.00; % This goes to slpclustinfo{1}{5} %Individual cluster VOLUME FRACTION (IN %age)
radiusfactorforcircle = 0.3000;   % This goes to slpclustinfo{1}{6} %Control circular cluster radius
slpclustinfo{1,:}     = {wantslspclust, typeofcluster, noslspclusters, clusterdistr, islspcvf, radiusfactorforcircle};
dlmwrite(strcat(pwd,'\simparameters','\slpclustinfo.txt'),...
    [slpclustinfo{1}{01}; slpclustinfo{1}{02}; slpclustinfo{1}{03}; slpclustinfo{1}{04}; slpclustinfo{1}{05}; slpclustinfo{1}{06}])
%---------------------------------------------------------------------------------------------
%% CNT CLUSTERING INFORMATION
% BLOCK OUTPUT VARIABLE(s): cntclusterinfo
wantcntclustering   = 0; % this goes to CLUSTERINFO{1}(1)
nocntclusters       = 1; % this goes to CLUSTERINFO{1}(2)
cntclusterinfo{1,:} = {wantcntclustering, nocntclusters};
dlmwrite(strcat(pwd, '\simparameters', '\cntclusterinfo.txt'), [cntclusterinfo{1}{01}; cntclusterinfo{1}{02}])
%---------------------------------------------------------------------------------------------
%% CLUSTERING INFORMATION
% BLOCK OUTPUT VARIABLE(s): clusterinfo
clusterinfo{1,:} = {slpclustinfo, cntclusterinfo};
%% SOLVER SETTINGS
% CELL BLOCK OUTPUT VARIABLE(s): solset
autoconv = 0;
solset{1,:} = {autoconv}; % solver settings
dlmwrite(strcat(pwd,'\simparameters','\solset.txt'),[solset{1}{01}])
%---------------------------------------------------------------------------------------------
%% FILE,FOLDER OPTIONS
% CELL BLOCK OUTPUT VARIABLE(s): ffo
% txtwriteint = floor(m/25);              % MCS interval to write data to disk
nof = 1;                       % Number of data files to write for a state paramter. TO BE REMOVED !!
ffo{1,:} = {txtwriteint, nof}; % file and folder options
dlmwrite(strcat(pwd,'\simparameters','\ffo.txt'),[ffo{1}{01}])
%---------------------------------------------------------------------------------------------
%% GRAPHICS OPTIONS
% CELL BLOCK OUTPUT VARIABLE(s): grapho
overlayed       = 1; % both grain and grain boundary
plain           = 1; % only grain
grainboundary   = 1; % only grain boundary
ploto{1,:} = {overlayed, plain, grainboundary}; % plotting options
dlmwrite(strcat(pwd,'\simparameters','\ploto.txt'),[ploto{1}{1}; ploto{1}{2}; ploto{1}{3}])
pitf = {1 75 'jpeg'};       %PrintImageToFile. pitf{1}=yes-1.no-0. pitf{2}=Quality(min25max100)
pio{1,:} = {pitf};          % print image options
grapho{1,:} = {ploto, pio}; % graphics options
dlmwrite(strcat(pwd,'\simparameters','\pio.txt'),[pio{1}{1}{1}; pio{1}{1}{2}])
%---------------------------------------------------------------------------------------------
end

%% REVISION INFORMATION
% v.1.39a.2D_REVISION_01: pi2d.V:4.00: FUNCTION NAME:procureinputs2D:start:01092013
% v.1.38c.2D_REVISION_02: pi2d.V:3.00: FUNCTION NAME:procureinputs2D:start:22082013
% V.1.38c.2D_REVISION_01: pi2d.V:2.00: FUNCTION NAME:procureinputs2D:start:09082013