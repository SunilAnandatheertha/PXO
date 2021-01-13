function plazp2d()
%-------------------------------------------------------------
global CFN Lattice zslsp zslspc zcnt cntxythetainfo
%-------------------------------------------------------------
x                        = Lattice.size.x;
y                        = Lattice.size.y;
xmin                     = Lattice.size.xmin;
xmax                     = Lattice.size.xmax;
ymin                     = Lattice.size.ymin;
ymax                     = Lattice.size.ymax;
wantslsp                 = Lattice.zener.slsp.want_slsp; 
volumefrac_slsp          = Lattice.zener.slsp.Vol_Frac;
wantcnt                  = Lattice.zener.cnt.want_cnt;
overlaycntsinlatticeplot = Lattice.zener.cnt.overlaycntsinlatticeplot;
wantslspclust            = Lattice.zener.slspc.want_slspc;
islspcvf                 = Lattice.zener.slspc.islspcvf;
%-------------------------------------------------------------
figure(CFN+1)
%-------------------------------------------------------------
% PLOTTING slsp
if wantslsp == 1
    if volumefrac_slsp > 0
        plot(x(zslsp), y(zslsp), 'ko', 'MarkerFaceColor', 'k', 'MarkerSize', 2);
    end
end
%-------------------------------------------------------------
% PLOTTING cnts
if wantcnt == 1
    plot(x(zcnt), y(zcnt), 'ko', 'MarkerFaceColor', 'k', 'MarkerSize', 2);
    if overlaycntsinlatticeplot == 1
        for countcnts = 1:size(cntxythetainfo,2)
            plot(cntxythetainfo{6,countcnts}(:,1), smooth(cntxythetainfo{6,countcnts}(:,2),10), '-g','LineWidth', 1.5);
            hold on
        end
    end
end
%-------------------------------------------------------------
% PLOTTING slspc
if wantslspclust == 1
    if islspcvf > 0
        for count = 1:size(zslspc,1)
            plot(x(zslspc{count,1}),y(zslspc{count,1}), 'ko', 'MarkerFaceColor', 'k', 'MarkerSize', 2);
        end
    end
end
clear count
%-------------------------------------------------------------
% Plot settings and print to jpeg
axis equal
axis tight
axis([xmin xmax ymin ymax])
xlabel('X-axis')
ylabel('Y-axis')
title('Particle distribution in lattice')
box on
print('-djpeg100',strcat(pwd,'\results\plots','\lattice.jpeg'))
%-------------------------------------------------------------
CFN = length(findobj('type','figure'));
%-------------------------------------------------------------
end