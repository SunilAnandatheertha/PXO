function postprocessPROPERTIES2d()
% This code is responsible for all microstructure processing properties (only)
% THINGS TO DO: 
    % lattice srtetching and grain boundary interpolation
    % lattice translation and copying
    % grain intexing
% Grain charecterization phase: 01 -- lattice site segregation and storage of segregated data
% Grain charecterization phase: 02 -- assignment of grain orientation angle
% Grain charecterization phase: 03 -- segregation of  grain boundaries of grains belonging to 'q'th state
% Grain charecterization phase: 04A -- Identification of individual grain boundaries
% Grain charecterization phase: 05 a -- Vertical Intercept method
% Grain charecterization phase: 05 b -- Horizontal Intercept method
% Grain charecterization phase: 05 ab1 -- Overlay plot
% Grain charecterization phase: 06 -- Finding number of single element zener particles lying on GB
%% Grain charecterization phase: 00A -- Set postprocessing code parameters & read data from hard disk 0
close all
clearvariableswhileworking = 0;
pausetime                  = 1; % in seconds
latpar1     = dlmread(strcat(pwd,'\simparameters','\latpar.txt'));

slspinfo1     = dlmread(strcat(pwd,'\simparameters','\slspinfo.txt'));
icntinfo1   = dlmread(strcat(pwd,'\simparameters','\icntinfo.txt'));
slpclustinfo1 = dlmread(strcat(pwd,'\simparameters','\slpclustinfo.txt'));

simpar1     = dlmread(strcat(pwd,'\simparameters','\simpar.txt'));
ffo1        = dlmread(strcat(pwd,'\simparameters','\ffo.txt'));
cm          = dlmread(strcat(pwd,'\results','\colormatrix.txt'));
xmin        = latpar1(1);
xmax        = latpar1(2);
ymin        = latpar1(3);
ymax        = latpar1(4);
xincr       = latpar1(5);
yincr       = latpar1(6);
xlength     = abs(xmin)+abs(xmax);
ylength     = abs(ymin)+abs(ymax);
[x,y]       = meshgrid(xmin:xincr:xmax,ymin:yincr:ymax);
q           = simpar1(1);
m           = simpar1(2);

wantslsp    = slspinfo1(1);
wantcnt     = icntinfo1(1);
wantslspclust = slpclustinfo1(1);

txtwriteint = ffo1(1);
sz1         = size(x,1);
sz2         = size(x,2);
%<><><><><><><><><><><><><><><><><><>
%% Grain charecterization phase: 01 -- lattice site segregation and storage of segregated data
display('<><><><><><><><><><><><><><><><><><>'), display('<><><><><><><><><><><><><><><><><><>')
display('Grain Charecterization Phase01::--Segregation of lattice sites having state value q{=1:Q} in every saved mcs')
display('Segregated state data will be written to file')
pause(pausetime)
% if nof~=0 && nof<=siminf(1,4) %% it cannot be siminf(1,4) -- CHECK !!!!. Neverthless it will work for almost all cases !!
    for rset = 1:floor(m/txtwriteint)
        fprintf('Grain Charecterization Phase 01:: segregating and storing Q grains: MCS--%d\n',rset*txtwriteint)
        statemat = []; % result s matrix
        filename = strcat(pwd,'\results\datafiles\statematrices','\s', num2str(rset*txtwriteint),'mcs',num2str(1),'.txt');
        temp = dlmread(filename);
        if size(statemat,2) < sz2
            statemat = [statemat temp];
        elseif size(statemat,2) == sz2
            statemat = temp;
        end
        mkdir(strcat(pwd,'\results','\datafiles','\graindata','\Qgrainelements','\MCS',num2str(rset*txtwriteint)))
        qvalueshavingnonzeroelements = zeros(q,1);
        for countq = 1:q
            elementsOFq = find(statemat==countq);
            if numel(elementsOFq)~=0
                dlmwrite(strcat(pwd,'\results','\datafiles', '\graindata','\Qgrainelements','\MCS', num2str(rset*txtwriteint),'\',num2str(countq), '.txt'),elementsOFq)
                qvalueshavingnonzeroelements(countq) = countq;
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                 hp1 = plot(x(elementsOFq), y(elementsOFq), 's', 'color', cm(countq,:), 'markerfacecolor', cm(countq,:), 'markersize', 4);
                hp1 = plot(x(elementsOFq), y(elementsOFq), 's', 'color', [0.7 0.7 0.7], 'markerfacecolor', 'w', 'markersize', 5);
                hold on
                axis([xmin xmax ymin ymax])
                axis square
                pause(0.001)
                print('-djpeg100', strcat(pwd,'\results', '\datafiles', '\graindata', '\Qgrainelements','\MCS', num2str(rset*txtwriteint), '\',num2str(rset*txtwriteint), 'nonzero_q_ORIENTATION_SETNo_',num2str(countq),'.jpeg'))
                if countq>1
                    delete(hp1)
                end
                if countq==q
                    close
                end
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                % Identify the individual grains having qth orientation
                [GrainsInThisQ] = FindIndividualGrains(x, y, elementsOFq);
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                % Plot the individual grains having qth orientation
                
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            end
            if numel(elementsOFq)~=0
            end
        end
        qvalueshavingnonzeroelements(qvalueshavingnonzeroelements==0)=[];
        dlmwrite(strcat(pwd,'\results', '\datafiles', '\graindata', '\Qgrainelements','\MCS', num2str(rset*txtwriteint), '\',num2str(rset*txtwriteint), 'nonzero_q','.txt'), qvalueshavingnonzeroelements)
    end
% end
if clearvariableswhileworking ~=0
    clear rset statemat filename temp qvalueshavingnonzeroelements countq elementsOFq
end
%<><><><><><><><><><><><><><><><><><>
%<><><><><><><><><><><><><><><><><><>
%% Grain charecterization phase: 02 -- assignment of grain orientation angle
display('<><><><><><><><><><><><><><><><><><>'),display('<><><><><><><><><><><><><><><><><><>')
disp('Initiating Grain Charecterization Phase 02 -- assignment of grain orientation angle')
pause(pausetime)
GOAngles = linspace(0,90,q)';% GrainOrientationAngles
dlmwrite(strcat(pwd,'\results\','GOAngles.txt'),[(1:q)' GOAngles],'delimiter','\t')
if clearvariableswhileworking ~=0
    clear GOAngles
end
%<><><><><><><><><><><><><><><><><><>
%<><><><><><><><><><><><><><><><><><>
%% Grain charecterization phase: 03 -- segregation of  grain boundaries of grains belonging to 'q'th state
display('<><><><><><><><><><><><><><><><><><>'),display('<><><><><><><><><><><><><><><><><><>')
display('Initiating Grain charecterization phase: 03 -- segregation of  grain boundaries of grains belonging to qth state')
pause(pausetime)
% [x,y] = makelatticegridandplot(siminf(1,5),siminf(1,6),siminf(1,7),siminf(1,8),siminf(1,9),siminf(1,10));
e = dlmread(strcat(pwd,'\results','\datafiles','\e','\e.txt'));
ew = dlmread(strcat(pwd,'\results','\datafiles','\e','\ewrapped.txt'));
% ||||||| ||||||| ||||||| |||||||
wantplot = 1; % <<--------- CONCERNING GRAIN BOUNDARY PLOT. 1:plot0: no plot
% ||||||| ||||||| ||||||| |||||||
for countmcs = txtwriteint:txtwriteint:m % Loop for Monte-Carlo steps
    fprintf('Grain Charecterization Phase 03 :: segregating GB elements from Q grains: MCS--%d\n',countmcs)
    mcss = dlmread(strcat(pwd,'\results\datafiles\statematrices','\s',num2str(countmcs),'mcs1.txt'));
    mcsq = dlmread(strcat(pwd,'\results', '\datafiles', '\graindata', '\Qgrainelements', '\MCS',num2str(countmcs),'\', num2str(countmcs),'nonzero_q', '.txt'));
    if wantplot == 1
        figure(countmcs)
    end
    gbelemcs = [];
    for countq = 1:numel(mcsq)
        mqele = dlmread(strcat(pwd,'\results', '\datafiles','\graindata','\Qgrainelements', '\MCS',num2str(countmcs),'\', num2str(mcsq(countq)),'.txt'));
        zero1 = zeros(size(mcss)); % pre-allocate a matrix
        zero1(mqele) = 1; % lattice sites of countq state recieve value 1
        diffx = diff(zero1,1,1); % find difference in states along x direction
        diffx = [diffx; zeros(1,size(diffx,2))]; % reestablish same matrix size
        diffy = diff(zero1,1,2); % find difference in states along y direction 
        diffy = [diffy zeros(size(diffy,1),1)];% reestablish same matrix size
        diffxy = abs(diffx) + abs(diffy); % combine information from diffx and diffy
        diffxy(diffxy~=0)=1; % change actual value to binary
        gbele = find(diffxy==1); % find gb elements
        gbelemcs = [gbelemcs; gbele];
        dlmwrite(strcat(pwd,'\results\datafiles\graindata\grainboundarye\','USD_mcs', num2str(countmcs),'GBEsofq',num2str(mcsq(countq)), '.txt'),gbele)
        % In above dlmwrite line, USD representes UnSortedData
    end
    gbelemcs = unique(gbelemcs);
%     dlmwrite(strcat(pwd,'\results\datafiles\graindata\grainboundarye\','GBEmcs',num2str(countmcs),'.txt'),gbelemcs)
    
    GBELEM_vec = zeros(sz1,sz2);
    GBELEM_vec(gbelemcs) = 1; % 1 MEANS THERE IS GRAIN BOUNDARY
    if wantcnt == 1
        cntzener = dlmread(strcat(pwd,'\results\datafiles\e\ZCarbonNanoTubes.txt'));
        GBELEM_vec(cntzener) = 0; % PUT ZEROS IN PLACE OF SITES BELONGING TO CNT ALSO
        for countgbelem_vec = 1:numel(GBELEM_vec)
            if GBELEM_vec(countgbelem_vec) == 1
                GBELEM_vec(countgbelem_vec) = countgbelem_vec;
            end
        end
    end
    
    if wantslspclust == 1
        zslspce = dlmread(strcat(pwd,'\results\datafiles\e\zener_solidcircles.txt'));
        GBELEM_vec(zslspce) = 0; % PUT ZEROS IN PLACE OF SITES BELONGING TO CNT ALSO
    end
    reshape(GBELEM_vec,numel(GBELEM_vec),1);
    GBELEM_vec(GBELEM_vec==0)=[];
    
    
    
    dlmwrite(strcat(pwd,'\results\datafiles\graindata\grainboundarye\','GBEmcs',num2str(countmcs),'.txt'),gbelemcs)
    if wantplot == 1
        plot(x(GBELEM_vec),y(GBELEM_vec),'k.'),hold on
        plot(x(GBELEM_vec),y(GBELEM_vec),'k.')
        axis square
        if wantcnt == 1
            plot(x(cntzener),y(cntzener),'g.')
        end
        if wantslspclust == 1
            plot(x(zslspce),y(zslspce),'ro')
        end
        print('-djpeg100',strcat(pwd,'\results\plots\s',num2str(countmcs),'mcs.jpeg'))
        close
    end
end
if clearvariableswhileworking ~=0
    clear e ew wantplot countmcs mcss mcsq countq mqele zero1 diffx diffy diffxy gbele
end
%<><><><><><><><><><><><><><><><><><>
%<><><><><><><><><><><><><><><><><><>
%% Grain charecterization phase: 04A -- Identification of individual grain boundaries
% m - total number of monte-carlo steps (mcs) adopted for the simulation
% mcss - state matrix corresponding to the current mcs
% mcsq - surviving states in the current mcs
% gbe - element numbers corresponding to grain boundaries. Hence gbe - grain boundary elements
% numz -  total number of zener particles on grain boundaries
% gzelem
display('<><><><><><><><><><><><><><><><><><>'),display('<><><><><><><><><><><><><><><><><><>')
display('Initiating Grain Charecterization Phase 04::--Identification of individual grain boundaries')
pause(pausetime)
for countmcs = txtwriteint:txtwriteint:m
    fprintf('Grain Charecterization Phase 04 :: Identification of individual grain boundaries: MCS--%d\n',countmcs)
    mcss = dlmread(strcat(pwd,'\results\datafiles\statematrices','\s',num2str(countmcs),'mcs1.txt'));
    mcsq = dlmread(strcat(pwd,'\results','\datafiles','\graindata', '\Qgrainelements','\MCS',num2str(countmcs),'\', num2str(countmcs),'nonzero_q','.txt'));
    numz = zeros(numel(mcsq),2);
    gzelem = cell(numel(mcsq),1);
    for countq = 1:numel(mcsq)
        gbe = dlmread(strcat(pwd,'\results\datafiles\graindata\grainboundarye\', 'USD_mcs',num2str(countmcs), 'GBEsofq', num2str(mcsq(countq)),'.txt'));
        gzelem{countq,1} = {[mcsq(countq) gbe(find(mcss(gbe)==0))']}; % Find and store element numbers of zener particles on grain boundaries
        numz(countq,:) = [mcsq(countq) numel(gbe(find(mcss(gbe)==0))) ]; % Store total number of zener particles on grain boundaries
    end
    for count = 1:size(gzelem,1) % bulid data to be readily written to file
        gzelemsizes(count,1) = numel(gzelem{count,1}{1});
    end
    gzelem_wrtf  = zeros(size(gzelem,1),max(gzelemsizes));% wrtf -- write to file
    for count = 1:size(gzelem,1)
        gzelem_wrtf(count,1:gzelemsizes(count,1)) = gzelem{count,1}{1};
    end
    dlmwrite(strcat(pwd,'\results\datafiles\graindata\grainboundarye\', 'elementnumbersofZ', num2str(countmcs), 'inandongrainsof1toq.txt'), gzelem_wrtf, 'delimiter','\t')
    dlmwrite(strcat(pwd,'\results\datafiles\graindata\grainboundarye\', 'numofzelements', num2str(countmcs), 'inandongrainsof1toq.txt'), numz,'delimiter','\t')
    % Now remove those elements from gzelem which belong to CNTs
end
if clearvariableswhileworking ~=0
    clear countmcs mcss mcsq numz gzelemsizes gzelem
end
%<><><><><><><><><><><><><><><><><><>
%<><><><><><><><><><><><><><><><><><>

% grainsize_interceptmethod2d()

%<><><><><><><><><><><><><><><><><><>
%<><><><><><><><><><><><><><><><><><>
%% Grain charecterization phase: 06 -- Finding number of single element zener particles lying on GB
% % first a binary matrix for all single element zener particles if created
% % next create the binary matrix using
% display('<><><><><><><><><><><><><><><><><><>'),display('<><><><><><><><><><><><><><><><><><>')
% display('Initiating Grain Charecterization Phase 06::-- Finding number of single element zener particles lying on GB')
% numZonGB = zeros(numel(txtwriteint:txtwriteint:m),1); % pre-allocation
% for countmcs = txtwriteint:txtwriteint:m
%     ZallonGB = dlmread(strcat(pwd,'\results\datafiles\graindata\grainboundarye\', 'numofzelements',num2str(countmcs), 'inandongrainsof1toq.txt'));
%     numZonGB(countmcs/txtwriteint) = sum(ZallonGB(:,2));
% end
% % plot((txtwriteint:txtwriteint:m)',numZonGB,'-ko','LineWidth',1,'MarkerSize',5)
% plot((txtwriteint:txtwriteint:m)',numZonGB,'-ko','LineWidth',1)
% dlmwrite(strcat(pwd,'\results\datafiles\numZonGB.txt'),numZonGB)
% hold on
% plot((txtwriteint:txtwriteint:m)',smooth(numZonGB,10),'-k.','LineWidth',1)
% legend('Actual data','5 point moving point average','Location','NorthEast')
% title('Total Number of Zener sites')
% xlabel('MCS')
% ylabel('No of Z particles on GB')
% axis tight, axis square
% print('-djpeg100',strcat(pwd,'\results\plots\','NoOfParticlesOnGB.jpeg'))
% %%% CHECKING AGAINST CNT ELEMENT NUMBERS
% if wantcnt ~=0
%     ZCNTelem = dlmread(strcat(pwd,'\results\datafiles\e','\ZCarbonNanoTubes.txt'));
%     zcntmatrix = zeros(size(x));
%     zcntmatrix(ZCNTelem) = 2; % DO NOT CHANGE
%     % zallmatrix = zeros(size(x));
%     % zeneralloverEXCNT =
%     % dlmread(strcat(pwd,'\results\datafiles\e','\zener_allover.txt')); %
%     % Excluding CNTs
%     for countmcs = txtwriteint:txtwriteint:m
%         grainboundelem = dlmread(strcat(pwd,'\results\datafiles\graindata\grainboundarye','\GBEmcs',num2str(countmcs),'.txt'));
%         grainboundelembinarymatrix = zeros(size(x));
%         grainboundelembinarymatrix(grainboundelem) = 3;
%         grainboundelembinarymatrixNCCNTelem = grainboundelembinarymatrix; % Initialize grainboundelembinarymatrixNCCNTelem here.
%         % NCCNTelem means - Not Containing CNT elements
%         indices = find( (grainboundelembinarymatrix - zcntmatrix) == 0);
%         grainboundelembinarymatrixNCCNTelem(indices)=0;
%         indices = find( grainboundelembinarymatrixNCCNTelem >0);
%         grainboundelembinarymatrixNCCNTelem(indices) = 1;
%     end
% end
% clear
%<><><><><><><><><><><><><><><><><><>
%<><><><><><><><><><><><><><><><><><>
end
%^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
function [GrainsInThisQ] = FindIndividualGrains(x, y, elementsOFq)

temp0 = elementsOFq;
temp1 = temp0;
count1 = 0;
ThisGrainElem = [];
while count1 < numel(temp1)
    count1  = count1 + 1;
    rp      = randi(numel(temp1));% Choose a random lattice site amongst the chosen sub-set
    
    [ELEM_In_This_Grain] = FindIndividualElementsInGrain(x, y, temp1, rp);
    
end

end
%^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
function [ELEM_In_This_Grain] = FindIndividualElementsInGrain(x, y, temp1, rp)

    rpx     = x(temp1(rp));% x of random point
    rpy     = y(temp1(rp));% y of random point
plot(rpx, rpy, 'k*', 'markersize', 10)
    rpxfc   = repmat(rpx, size(temp1));% rpx for comparison
    rpyfc   = repmat(rpy, size(temp1));% rpy for comparison
    xelq    = x(temp1);
    yelq    = y(temp1);
    dist1   = sqrt((xelq-rpxfc).^2+(yelq-rpyfc).^2);
    lr      = find(dist1==xincr);
    ud      = find(dist1==yincr);
    neig1   = unique([lr; ud]);
plot(x(temp1(neig1)), y(temp1(neig1)), 'k.', 'markersize', 12)
    su      = find(dist1==sqrt(xincr^2+yincr^2)); % Side up
    neig2   = unique(su);
plot(x(temp1(neig2)), y(temp1(neig2)), 'b.', 'markersize', 12)
    neig12  = [neig1; neig2];
    FRONT = neig12;
plot(x(temp1(FRONT)), y(temp1(FRONT)), 'yo', 'markersize', 12)
    [~, i_temp1] = intersect(temp1, [temp1(rp); temp1(neig12)]);
plot(x(temp1([rp; i_temp1])), y(temp1([rp; i_temp1])), 'cs')
    ThisGrainElem = [ThisGrainElem; temp1(i_temp1)];
    [~, i_temp1] = intersect(temp1, ThisGrainElem);% ThisGrain should be replaced by all elements in the current grain
    
    temp1(i_temp1) = [];
plot(x(temp1), y(temp1), 'cx', 'markersize', 12)
end

function [imm_neig] = FindImmNeigh(x, y, temp1)

end