function plazp3d(x,y,z, latpar,slspinfo, icntinfo,clusterinfo, zslsp,zcnt,zslspc, cntxythetainfo, readfromdisk)

if readfromdisk == 0
    xmin                     = latpar{1}{1};
    xmax                     = latpar{1}{2};
    ymin                     = latpar{1}{3};
    ymax                     = latpar{1}{4};
    zmin                     = latpar{1}{5};
    zmax                     = latpar{1}{6};
    
    wantslsp                 = slspinfo{1}{1};
    volumefrac_slsp          = slspinfo{1}{2};
    wantcnt                  = icntinfo{1}{1};
    overlaycntsinlatticeplot = icntinfo{1}{10};
    slpclustinfo             = clusterinfo{1}{1};
    wantslspclust            = slpclustinfo{1}{01};
    islspcvf                 = slpclustinfo{1}{05};
end
%% PLOTTING slsp
plotunderlyinglattice = 1;
if plotunderlyinglattice == 1
    for zcount = 1:size(z,3)
        plot3(x(:,:,zcount),y(:,:,zcount),z(:,:,zcount),'g.','MarkerSize',5),hold on
    end
end
hold on
%<><><><><><><><><><><><><><><><><><>
%% PLOTTING slsp
if wantslsp == 1
    if volumefrac_slsp >0
        plot3(x(zslsp),y(zslsp),z(zslsp),'ko','MarkerFaceColor','k','MarkerSize',2);
    end
end
%<><><><><><><><><><><><><><><><><><>
%% PLOTTING cnts
if wantcnt == 1
    plot(x(zcnt),y(zcnt),'ko','MarkerFaceColor','k','MarkerSize',2);
    if overlaycntsinlatticeplot == 1
        for countcnts = 1:size(cntxythetainfo,2)
            plot(cntxythetainfo{6,countcnts}(:,1), smooth(cntxythetainfo{6,countcnts}(:,2),10), '-g', 'LineWidth',1.5);
            hold on
        end
    end
end
%<><><><><><><><><><><><><><><><><><>
%% PLOTTING slspc
if wantslspclust == 1
    if islspcvf > 0
        for count = 1:size(zslspc,1)
            plot3(x(zslspc{count,1}), y(zslspc{count,1}), z(zslspc{count,1}), 'ro', 'MarkerFaceColor','r', 'MarkerSize',2);
        end
    end
end
clear count
%<><><><><><><><><><><><><><><><><><>
%% Plot settings and print to jpeg
axis equal
axis tight
axis([xmin xmax ymin ymax zmin zmax])
xlabel('X-axis')
ylabel('Y-axis')
zlabel('Z-axis')
title('Particle distribution in lattice')
box on
print('-djpeg100',strcat(pwd,'\results\plots','\lattice.jpeg'))
%<><><><><><><><><><><><><><><><><><>
end