close all;clear all; hold on
NOfPointsOnFitCurve = 60;
xp150_750x750_icr00625_icvf        = [ 00.0200 00.0300 00.0500 00.0750 00.1000 00.2500 00.5000 00.7500 01.0000 ];
xp150_750x750_icr00625_icvf_ags_T1 = [ 85.4489 72.2753 64.3134 56.3070 51.5780 44.5293 40.3929 40.4486 51.5036 ];
xp150_750x750_icr00625_icvf_ags_T2 = [ 81.3436 73.2063 64.3134 59.6895 52.9240 42.1042 40.3000 43.1652 51.1691 ];
xp150_750x750_icr00625_icvf_ags = (xp150_750x750_icr00625_icvf_ags_T1 + xp150_750x750_icr00625_icvf_ags_T2)/2;
xp150_750x750_icr00625_icvf_ags = xp150_750x750_icr00625_icvf_ags/max(xp150_750x750_icr00625_icvf_ags);
x00625 = xp150_750x750_icr00625_icvf;
y00625 = xp150_750x750_icr00625_icvf_ags;
z00625 = 0.00625*ones(size(xp150_750x750_icr00625_icvf_ags));
hold on; view(30,30)
plot3(x00625,y00625,z00625, 'or', 'LineWidth', 1, 'MarkerFaceColor', 'r', 'MarkerSize', 4)
[xData00625, yData00625] = prepareCurveData( x00625, y00625 );
ft   = fittype( 'rat31' ); opts = fitoptions( ft ); opts.Display = 'Off';
opts.Lower       = [-Inf -Inf -Inf -Inf -Inf];
opts.StartPoint  = [0.02 0.02 0.02 0.02 0.02];
opts.Upper       = [Inf Inf Inf Inf Inf];
[fitresult00625, gof] = fit( xData00625, yData00625, ft, opts );
xstart           = min(x00625);
xend             = max(x00625);
xfitdata00625 = linspace(xstart, xend, NOfPointsOnFitCurve);
yfitdata00625 = ( (fitresult00625.p1 * xfitdata00625.^3) + (fitresult00625.p2 * xfitdata00625.^2) + (fitresult00625.p3 * xfitdata00625) + (fitresult00625.p4) )./ (xfitdata00625 + fitresult00625.q1);
zfitdata00625 = 0.00625*ones(size(xfitdata00625));
plot3(xfitdata00625, yfitdata00625, zfitdata00625,'r','LineWidth',2)
xmin(1) = xfitdata00625(yfitdata00625 == min(yfitdata00625));
ymin(1) = yfitdata00625(yfitdata00625 == min(yfitdata00625));
zmin(1) = zfitdata00625(yfitdata00625 == min(yfitdata00625));





xp150_750x750_icr01250_icvf = [ 0.020 0.025 0.030 0.035 0.040 0.050 0.075 0.100 0.250 0.500 0.750 1.000 ];
xp150_750x750_icr01250_icvf_ags_T1 = [ 51.2031 47.0616 46.6017 47.3751 41.6098 39.2802 33.7059 29.7026 22.8319 21.7933 22.0248 42.8334 ];
xp150_750x750_icr01250_icvf_ags_T2 = [ 55.4995 49.3905 46.6426 47.3751 41.5526 37.9948 34.8839 30.9316 22.8319 21.3443 22.0248 42.7954 ];
xp150_750x750_icr01250_icvf_ags    = (xp150_750x750_icr01250_icvf_ags_T1 + xp150_750x750_icr01250_icvf_ags_T2)/2;
xp150_750x750_icr01250_icvf_ags = xp150_750x750_icr01250_icvf_ags/max(xp150_750x750_icr01250_icvf_ags);

z01250 = 0.01250*ones(size(xp150_750x750_icr01250_icvf_ags));
x01250 = xp150_750x750_icr01250_icvf;
y01250 = xp150_750x750_icr01250_icvf_ags;

plot3(x01250,y01250,z01250, 'sk', 'LineWidth', 1, 'MarkerFaceColor', 'k', 'MarkerSize', 4)
[xData, yData] = prepareCurveData( x01250, y01250 );
ft   = fittype( 'rat31' ); opts = fitoptions( ft ); opts.Display = 'Off';
opts.Lower       = [-Inf -Inf -Inf -Inf -Inf];
opts.StartPoint  = [0.02 0.02 0.02 0.02 0.02];
opts.Upper       = [Inf Inf Inf Inf Inf];
[fitresult01250, gof] = fit( xData, yData, ft, opts );
xstart           = min(x01250);
xend             = max(x01250);
xfitdata01250 = linspace(xstart, xend, NOfPointsOnFitCurve);
yfitdata01250 = ( (fitresult01250.p1 * xfitdata01250.^3) + (fitresult01250.p2 * xfitdata01250.^2) + (fitresult01250.p3 * xfitdata01250) + (fitresult01250.p4) )./ (xfitdata01250 + fitresult01250.q1);
zfitdata01250 = 0.01250*ones(size(xfitdata01250));
plot3(xfitdata01250, yfitdata01250, zfitdata01250,'k','LineWidth',2)
xmin(numel(xmin)+1) = xfitdata01250(yfitdata01250 == min(yfitdata01250));
ymin(numel(ymin)+1) = yfitdata01250(yfitdata01250 == min(yfitdata01250));
zmin(numel(zmin)+1) = zfitdata01250(yfitdata01250 == min(yfitdata01250));

plot3(xmin, ymin, zmin, 'xb-', 'LineWidth', 2, 'MarkerSize', 10)

zlim([0 0.025]); view(30,30); box on; xlabel('ICVF'); ylabel('AGS_{unit normalized}'); zlabel('ICR');
Legendhandle = legend('ICR = 0.00625', 'ICR = 0.00625: Curve fit',...
                      'ICR = 0.01250', 'ICR = 0.01250: Curve fit',...
                      'Line of min AGS_{n}');
legend boxoff
set(Legendhandle,'FontSize',6.5)
title('750 x 750')
axis tight

for count = 1:NOfPointsOnFitCurve
    plot3([xfitdata00625(count) xfitdata01250(count)], [yfitdata00625(count) yfitdata01250(count)], [zfitdata00625(count) zfitdata01250(count)], 'k:')
end

text(0.8, 1.2, 0.0085, 'ICVF: Individual Cluster Volume Fraction', 'clipping', 'off','FontSize',6.5)
text(0.8, 1.2, 0.008, 'ICR: Individual Cluster Radius', 'clipping', 'off','FontSize',6.5)
text(0.8, 1.2, 0.0075, 'AGS: Average Grain Size', 'clipping', 'off','FontSize',6.5)




xp150_750x750_icr00940_icvf        = [ 00.0200 00.0250 00.0300 00.0350 ];
xp150_750x750_icr00940_icvf_ags_T1 = [ 65.8366 59.5485 60.7003 56.0534 ];
xp150_750x750_icr00940_icvf_ags_T2 = [ 65.9304 57.3238 57.3459 51.3939 ];
xp150_750x750_icr00940_icvf_ags_T3 = [ 65.9304 57.8769 56.0358 51.3939 ];
xp150_750x750_icr00940_icvf_ags_T4 = [ 65.9304 56.2386 54.2241 51.3939 ];
xp150_750x750_icr00940_icvf_ags = (xp150_750x750_icr00940_icvf_ags_T1 +...
                                   xp150_750x750_icr00940_icvf_ags_T2 +...
                                   xp150_750x750_icr00940_icvf_ags_T3 +...
                                   xp150_750x750_icr00940_icvf_ags_T3)/4;
xp150_750x750_icr00940_icvf_ags = xp150_750x750_icr00940_icvf_ags/max(xp150_750x750_icr00940_icvf_ags);
x00940 = xp150_750x750_icr00940_icvf;
y00940 = xp150_750x750_icr00940_icvf_ags;
z00940 = 0.00940*ones(size(xp150_750x750_icr00940_icvf_ags));
plot3(x00940,y00940,z00940, 'ok', 'LineWidth', 1, 'MarkerFaceColor', 'c', 'MarkerSize', 5)
% [xData, yData] = prepareCurveData( x00940, y00940 );
% ft   = fittype( 'rat31' ); opts = fitoptions( ft ); opts.Display = 'Off';
% opts.Lower       = [-Inf -Inf -Inf -Inf -Inf];
% opts.StartPoint  = [0.02 0.02 0.02 0.02 0.02];
% opts.Upper       = [Inf Inf Inf Inf Inf];
% [fitresult, gof] = fit( xData, yData, ft, opts );
% xstart           = min(x00940);
% xend             = max(x00940);
% xfitdata01250         = linspace(xstart, xend, 50);
% ystart           = min(y00940);
% yend             = max(y00940);
% yfitdata01250 = ( (fitresult.p1 * xfitdata01250.^3) + (fitresult.p2 * xfitdata01250.^2) + (fitresult.p3 * xfitdata01250) + (fitresult.p4) )./ (xfitdata01250 + fitresult.q1);
% zfitdata01250 = 0.00940*ones(size(xfitdata01250));
% plot3(xfitdata01250, yfitdata01250, zfitdata01250,'k','LineWidth',2)



grid on
print('-depsc',strcat(pwd,'\AGS_UnitNormalized_VS_ICVFandICR.eps'))
print('-djpeg100',strcat(pwd,'\AGS_UnitNormalized_VS_ICVFandICR.jpeg'))