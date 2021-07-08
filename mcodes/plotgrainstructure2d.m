function [CFN] = plotgrainstructure2d(colorplot,grainboundarylineplot,pitf, CFN)

% [----] = plotgrainstructure2d(-----)
% Internal function calls: (1) INT: plotgrains2d
%                          (2) INT: plotgrainboundary2d 
%                          (3) INT: plotzenerparticles2d
% todo_A [08-08-20]-[09-08-20]: Remoce CFN from output

global Lattice MC_Param MC_Loop File_Fold_Operations

% Plot the grain structure temporal evolution
cm            = Lattice.ColourMatrix_RGB_UnitNorm;
%------------------------------------------------------
xlength       = Lattice.size.xlength;
ylength       = Lattice.size.ylength;
%------------------------------------------------------
x             = Lattice.size.x;
y             = Lattice.size.y;
%------------------------------------------------------
q             = Lattice.q;
m             = MC_Param.Num_MC_Steps;
txtwriteint   = MC_Loop.DataOperation.txtwriteint;
nof           = File_Fold_Operations.writedlm.s.nof;
wantslsp      = Lattice.zener.slsp.want_slsp;
wantslspclust = Lattice.zener.slspc.want_slspc;
wantcnt       = Lattice.zener.cnt.want_cnt;
%<><><><><><><><><><><><><><><><><><>
% DEFINE MARKERSIZE
if  size(x,1)>= 40 && size(x,1) <= 75
    sizeofmrkr = 12;
elseif  size(x,1)>75 && size(x,1) <= 101
    sizeofmrkr = 5;
elseif size(x,1) > 101 && size(x,1) <= 290
    sizeofmrkr = 2;
elseif size(x,1) > 290 && size(x,1) <= 1000
    sizeofmrkr = 1;
else 
    sizeofmrkr = 10;
end
%<><><><><><><><><><><><><><><><><><>
% SET FIGURE PROPERTIES
% close all
% PLOT GRAIN STRUCTURE
figure(CFN+1);
for rset = 1:floor(m/txtwriteint)
    figure
    fprintf('currentplot: %d \n',rset*txtwriteint);
    rs = []; % result s matrix
    for fno = 1:nof
        filename = strcat(pwd,'\results\datafiles\statematrices', '\s', num2str(rset*txtwriteint), 'mcs',num2str(fno),'.txt');
        if size(rs,2) < ylength
            temp = dlmread(filename);
            rs = [rs temp];
        end
    end % Thus state matrix at a mcs has been reconstructed
    qe_some = cell(q,1);
    for count = 1:q
        qe_some{count,1} = find(rs==count);
    end
    hold on
    if colorplot == 1
        plotgrains2d(q,qe_some,cm,x,y,sizeofmrkr);
    end
    if grainboundarylineplot == 1
        plotgrainboundary2d(x,y,rs,sizeofmrkr);
    end
    if (wantslsp+wantcnt+wantslspclust) ~= 0
        plotzenerparticles2d();
    end
    titlestring = strcat(num2str(xlength),'x',num2str(ylength), 'Microstructure plot', 'mcs', num2str(num2str(rset*txtwriteint)));
    %title(titlestring)
    xlabel('x-->')
    ylabel('y-->')
    axis equal
    axis tight
    if pitf == 1
        if colorplot == 1 && grainboundarylineplot == 0
            print('-djpeg100',strcat(pwd, '\results\plots\microstructure_plain','\', strcat(num2str(rset*txtwriteint),'mcs'),'.jpeg'))
        elseif colorplot == 1 && grainboundarylineplot == 1
            print('-djpeg100',strcat(pwd, '\results\plots\microstructure_withgb','\', strcat(num2str(rset*txtwriteint),'mcs'),'.jpeg'))
        elseif colorplot == 0 && grainboundarylineplot == 1
            print('-djpeg100',strcat(pwd, '\results\plots\microstructure_gbonly','\', strcat(num2str(rset*txtwriteint),'mcs'),'.jpeg'))
        end
    else
        pause(0.001)
    end
%     clf
end
% close
rs = [];
CFN = length(findobj('type','figure'));
end
%<><><><><><><><><><><><><><><><><><>
% SUBFUNCTION: plotgrains2d
function plotgrains2d(q,qe_some,cm,x,y,sizeofmrkr)

hold on
for qcount = 1:q
    elem = qe_some{qcount,1};    
    plot(x(elem),y(elem),'ks',...
        'MarkerFaceColor',cm(qcount,:),...
        'MarkerEdgeColor',cm(qcount,:),'MarkerSize',sizeofmrkr);
end
axis equal
axis tight
% pause(0.001)
end
%<><><><><><><><><><><><><><><><><><>
% SUBFUNCTION: plotgrainboundary2d
function plotgrainboundary2d(x,y,rs,sizeofmrkr)

% THIS FUNCTION IS ONLY APPROXIMATE.. MUST BE IMPROVED !!

count = 1;
gbx   = zeros(numel(x),1);
gby   = zeros(numel(x),1);
for i = 1:size(x,1)-1
    for j = 1:(size(x,2)-1)
        if rs(i,j) ~= rs(i,j+1)
            gbx(count) = x(i,j);
            gby(count) = y(i,j);
            count = count + 1;
        end
        if rs(i,j) ~= rs(i+1,j)
            gbx(count) = x(i,j);
            gby(count) = y(i,j);
            count = count + 1;
        end
    end
end
% gbx(gbx==0)=[];
% gbx(gby==0)=[];

plot(gbx,gby,'ks','MarkerFaceColor','k','MarkerSize',sizeofmrkr)

%%% plot(gbx,gby,'ks','MarkerSize',sizeofmrkr,'MarkerFaceColor','k')

% titlestring = strcat('Microstructure plot','mcs',num2str(num2str(rset*txtwriteint)));
% title(titlestring),xlabel('x-->'),ylabel('y-->'),grid on,axis tight,axis square
% print('-djpeg100',strcat(pwd,'\', 'resultmicrostrucureplots', '\',strcat(num2str(rset*txtwriteint), 'withgb'),'.jpeg'))
end
%<><><><><><><><><><><><><><><><><><>
% SUBFUNCTION: plotzenerparticles2d
function plotzenerparticles2d()

%% READ DATA FROM DISK
latpar1       = dlmread(strcat(pwd,'\simparameters','\latpar.txt'));
slspinfo1     = dlmread(strcat(pwd,'\simparameters','\slspinfo.txt'));
icntinfo1     = dlmread(strcat(pwd,'\simparameters','\icntinfo.txt'));
slpclustinfo1 = dlmread(strcat(pwd,'\simparameters','\slpclustinfo.txt'));
%% ASSIGN VARIABLE VALUES
xmin          = latpar1(1);
xmax          = latpar1(2);
ymin          = latpar1(3);
ymax          = latpar1(4);
xincr         = latpar1(5);
yincr         = latpar1(6);
wantslsp      = slspinfo1(1);
wantcnt       = icntinfo1(1);
wantslspclust = slpclustinfo1(1);
%<><><><><><><><><><><><><><><><><><>
%% FORM XY GRID
[x,y] = meshgrid(xmin:xincr:xmax,ymin:yincr:ymax);
%<><><><><><><><><><><><><><><><><><>
%% DEFINE MARKERSIZE
if  size(x,1)>= 40 && size(x,1) <= 75
    sizeofZmrkr = 8;
elseif  size(x,1)>75 && size(x,1) <= 101
    sizeofZmrkr = 5;
elseif size(x,1) > 101 && size(x,1) <= 290
    sizeofZmrkr = 2;
elseif size(x,1) > 290 && size(x,1) <= 1000
    sizeofZmrkr = 1;
end
%<><><><><><><><><><><><><><><><><><>
%%  PLOT SLSP
hold on
if wantslsp == 1
    zslspe = dlmread(strcat(pwd,'\results\datafiles\e\zener_allover.txt'));
    plot(x(zslspe),y(zslspe),'ro','MarkerFaceColor','r','MarkerSize',sizeofZmrkr)
    axis off
end
%<><><><><><><><><><><><><><><><><><>
%%  PLOT SCNT
if wantcnt == 1
    zcnte = dlmread(strcat(pwd,'\results\datafiles\e\ZCarbonNanoTubes.txt'));
    plot(x(zcnte),y(zcnte),'gs','MarkerFaceColor','g','MarkerSize',sizeofZmrkr)
end
%<><><><><><><><><><><><><><><><><><>
%%  PLOT SLSPC
if wantslspclust == 1
    zslspce = dlmread(strcat(pwd,'\results\datafiles\e\zener_solidcircles.txt'));
    plot(x(zslspce),y(zslspce),'gs','MarkerFaceColor','g','MarkerSize',sizeofZmrkr)
end
%<><><><><><><><><><><><><><><><><><>

end