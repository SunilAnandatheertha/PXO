function [GRAINS] = POLY_XTAL____MTEX_GS_ANALYSIS()

EBSDDATA = loadEBSD('CTF_FILE.ctf');
EBSDDATA  = EBSDDATA('Aluminium');
EBSDDATA = reduce(EBSDDATA , 1);
set(gcf,'renderer','zBuffer')
plotx2east

% EBSDDATA = EBSDDATA.rotate(reflection(xvector));
EBSDDATA = fill(EBSDDATA);
[GRAINS, EBSDDATA.grainId] = calcGrains(EBSDDATA('Aluminium'),'angle',15*degree);

gB01 = GRAINS.boundary('Al','Al');

% figure
% hbc  = plot(EBSDDATA,EBSDDATA.bc);
% colormap gray; mtexColorbar
% close

figure
hold on
plot(gB01, 'k','linewidth',1); hold on;
plot(GRAINS.innerBoundary,'linecolor','r','linewidth',1)



figure; %plot(GRAINS,'translucent',.3,'micronbar','off'); legend off; hold on; 
plot(gB01('Aluminium'),gB01('Aluminium').misorientation.angle./degree,'linewidth',2);
colormap jet; mtexColorbar('title','misorientation angle')

KAM01 = KAM(EBSDDATA('Aluminium'),'threshold',5*degree, 'order', 2);
figure
plot(EBSDDATA('Aluminium'), KAM01./degree);
mtexColorbar('title', 'KAM (degrees)','fontsize',28); hold on;colormap jet;
plot(GRAINS.boundary('Aluminium'), '-k', 'LineWidth', 1);
plot(GRAINS.innerBoundary,'linecolor','k','linewidth',1);


% shapefactor = actual grain perimeter/equivalent perimeter
figure
hs1 = scatter(GRAINS.shapeFactor, GRAINS.aspectRatio, 100*GRAINS.area./max(GRAINS.area), 'r');
% ht  = title('Grain AR vs. SF');
hxl = xlabel('Aspect ratio'); hyl = ylabel('Shape factor'); box on
set([hxl hyl], 'fontsize', 18);
% set(ht, 'fontsize', 12);
set(gca, 'XMinorTick', 'on'); set(gca, 'YMinorTick', 'on')
set(gca,'TickLength',[0.02, 0.02])
ax = gca;   ax.XTick = 0:0.5:5;    ax.YTick = 0:10:100;
set(gca,'XMinorTick','on','YMinorTick','on', 'fontsize', 14)
axis([1 4 0 100]); axis square; box on
% htx = text(1.05,145,'Bubble size represent grain area'); set(htx, 'fontsize', 10);
grid on
axis tight


figure
plot(EBSDDATA); hold on
plot(gB01, 'k','linewidth',1); hold on;
plot(GRAINS.innerBoundary,'linecolor','r','linewidth',1)




% BungeEA_ebsd_a_red_3 = GRAINS.meanOrientation.Euler(:,1);
% fprintf('Total no. of grains = %d\n', prod(size(GRAINS)))
% gB_a_red_3 = GRAINS_a_red_3.boundary('Al','Al');

figure
BungeEA_GRAINS_MEAN = GRAINS.meanOrientation.Euler(:,1)*(180/pi);
h1 = histogram(BungeEA_GRAINS_MEAN(:,1), 50); hold on;
h2 = histogram(BungeEA_GRAINS_MEAN(:,2), 50);
h3 = histogram(BungeEA_GRAINS_MEAN(:,3), 50);
hl1 = legend('\phi_1', '\psi', '\phi_2');
h1.FaceColor = 'k';
h2.FaceColor = 'r';
h3.FaceColor = 'g';
xlim([0 360]); xl = xlabel('Euler angle (degrees)'); yl3 = ylabel('Count');
end