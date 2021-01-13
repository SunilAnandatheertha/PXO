% revd02a -- results for paper "vasudeva02" - code a
if isdir(strcat(pwd,'\compiled_results'))==0
    mkdir(strcat(pwd,'\compiled_results'))
end
if isdir(strcat(pwd,'\compiled_results\monte_carlo'))==0
    mkdir(strcat(pwd,'\compiled_results\monte_carlo'))
end
set(0,'DefaultFigureWindowStyle','docked')
clear all,close all
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 250 x 250
% lattice size = 250 x 250. number of particles = 100
agsvsvfi_100p_0pnt01250r_250x250 = [0.020 (60.2039+49.6141+42.6261+48.7977)/4;
                                    0.025 (39.7873+00.0000+49.5871+40.1154)/4;
                                    0.030 (45.3572+44.4966+34.7812+51.1842)/4;
                                    0.035 (57.1763+44.6017+00.0000)/3;
                                    0.040 (35.3460+00.0000+00.0000)/3;
                                    0.050 (42.7446+00.0000+00.0000)/3;
                                    0.075 (29.6559+00.0000)/2;
                                    0.100 (29.6868+00.0000)/2;
                                    0.250 (22.3184+00.0000)/2;
                                    0.500 (20.4276+00.0000)/2;
                                    0.750 (00.0000+23.8269)/2;
                                    1.000 (24.0854+00.0000)/2];
%% 300 x 300
% lattice size = 500 x 500. number of particles = 100
agsvsvfi_100p_0pnt01250r_300x300 = [0.020 ( 47.5217 + 45.7055 + 57.9902 + 45.3585 )/4;0.025 ( 52.1901 + 42.5926 + 54.8848 + 53.6412 )/4;0.030 ( 38.7792 + 40.0345 + 41.9967 + 43.7369 )/4;
                                    0.035 ( 47.2543 + 42.5372 + 40.4059 )/3;0.040 ( 40.5699 + 37.6702 + 40.2907 )/3;0.050 ( 36.7193 + 35.5649 + 38.078 )/3;
                                    0.075 ( 31.3714 + 35.293 )/2;0.100 ( 32.5386 + 31.5675 )/2;0.250 ( 25.7376 + 23.9699 )/2;0.500 ( 23.2829 + 24.2078 )/2;0.750 ( 24.3843 + 24.4059 )/2;1.000 ( 28.0109 + 32.2384 )/2];
agsvsvfi_100p_0pnt01250r_300x300x= agsvsvfi_100p_0pnt01250r_300x300(:,1);
agsvsvfi_100p_0pnt01250r_300x300y= agsvsvfi_100p_0pnt01250r_300x300(:,2);
%% 500 x 500
% lattice size = 500 x 500. number of particles = 100
agsvsvfi_100p_0pnt00625r_500x500 = [0.020 (98.3927+97.2756)/2;  0.025 (78.2062+100.4329)/2;  0.030 (74.5473+89.2407)/2;  0.035 (68.3768+91.8229)/2;
                                    0.040 (80.9126+76.0838)/2;  0.050 (65.9119+73.1833)/2;   0.075 (64.7516+57.0722)/2;  0.100 (60.2812+55.9084)/2;
                                    0.250 (54.9374+47.3554)/2;  0.500 (45.7216+41.9261)/2;   0.750 (45.1662+44.7860)/2;  1.000 (48.5111+49.0880)/2];
agsvsvfi_100p_0pnt00625r_500x500x= agsvsvfi_100p_0pnt00625r_500x500(:,1);
agsvsvfi_100p_0pnt00625r_500x500y= agsvsvfi_100p_0pnt00625r_500x500(:,2);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
agsvsvfi_100p_0pnt00940r_500x500 = [0.020 (87.6227+63.6802)/2;
                                    0.025 (61.1256+62.9356)/2;
                                    0.030 (63.9330+65.7763)/2;
                                    0.035 (66.4237+59.1412)/2;
                                    0.250 (36.3830+38.1789)/2;
                                    0.500 (39.1322+39.3262)/2;
                                    0.750 (38.8110+39.4048)/2;
                                    1.000 (48.2587+50.6602)/2];
agsvsvfi_100p_0pnt00940r_500x500x= agsvsvfi_100p_0pnt00940r_500x500(:,1);
agsvsvfi_100p_0pnt00940r_500x500y= agsvsvfi_100p_0pnt00940r_500x500(:,2);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% agsvsvfi_150p_0pnt01250r_500x500 = agsvsvfi_150p_0pnt01250r_750x750(:,2);%%%%%%%%%
agsvsvfi_100p_0pnt01250r_500x500 = [0.020 (66.5185+64.1636)/2;  0.030 (54.3077+54.9436)/2;  0.035 (53.7273+49.2933)/2;  0.040 (47.4655+45.8450)/2;
                                    0.050 (41.8256+47.8427)/2;  0.075 (42.3235+41.3119)/2;  0.100 (39.4620+38.0948)/2;  0.250 (32.0880+35.5915)/2;
                                    0.500 (29.3436+30.8015)/2;  0.750 (35.9567+34.0155)/2;  1.000 (44.2949+46.8010)/2];
agsvsvfi_100p_0pnt01250r_500x500x= agsvsvfi_100p_0pnt01250r_500x500(:,1);
agsvsvfi_100p_0pnt01250r_500x500y= agsvsvfi_100p_0pnt01250r_500x500(:,2);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% lattice size = 500 x 500. number of particles = 150
agsvsvfi_150p_0pnt01250r_500x500 = [0.020 (51.1538+51.5499)/2;  0.025 (43.9163+43.8336)/2;  0.030 (39.1222+35.3314)/2;  0.040 (36.5341+37.0384)/2;
                                    0.050 (34.2401+32.6444)/2;  0.075 (30.3241+29.4694)/2;  0.100 (25.6275+26.8561)/2;  0.250 (19.2402+20.1447)/2;
                                    0.500 (16.9563+17.3189)/2;  0.750 (18.9639+21.5450)/2;  1.000 (29.3432+29.4161)/2];
agsvsvfi_150p_0pnt01250r_500x500x= agsvsvfi_150p_0pnt01250r_500x500(:,1);
agsvsvfi_150p_0pnt01250r_500x500y= agsvsvfi_150p_0pnt01250r_500x500(:,2);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 750 x 750
% lattice size = 750 x 750. number of particles = 100
agsvsvfi_150p_0pnt00625r_750x750 = [0.050 (64.3134)/1;
                                    0.075 (56.3070+59.6895)/2;
                                    0.100 (51.5780+52.9240)/2;
                                    0.250 (44.5293+42.1042)/2;
                                    0.500 (40.3929+40.3000)/2;  0.750 (40.4486+43.1652)/2;  1.000 (51.5036+51.1691)/2];
agsvsvfi_150p_0pnt00625r_750x750x= agsvsvfi_150p_0pnt00625r_750x750(:,1);
agsvsvfi_150p_0pnt00625r_750x750y= agsvsvfi_150p_0pnt00625r_750x750(:,2);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
agsvsvfi_150p_0pnt01250r_750x750 = [0.020 (51.2031+55.4995)/2;  0.025 (47.0616+49.3905)/2;  0.030 (46.6017+46.6426)/2;  0.040 (41.6098+42.5526)/1;
                                    0.050 (39.2802)/1;          0.075 (33.7059+34.8839)/2;  0.100 (29.7026+30.9316)/2;  
                                    0.250 (22.8319+23.1516)/2;  0.500 (21.7933+21.3443)/2;  0.750 (23.3255+22.0248)/2;  1.000 (42.7954+42.8334)/2];
agsvsvfi_150p_0pnt01250r_750x750x = agsvsvfi_150p_0pnt01250r_750x750(:,1);
agsvsvfi_150p_0pnt01250r_750x750y = agsvsvfi_150p_0pnt01250r_750x750(:,2);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Calculate x-axis and y-axis limits
% Calculate x-axis limits for both normal and unit-normalized plots
xmin = min([agsvsvfi_100p_0pnt01250r_300x300x;
            agsvsvfi_100p_0pnt00625r_500x500x;
            agsvsvfi_100p_0pnt00940r_500x500x;
            agsvsvfi_100p_0pnt01250r_500x500x;
            agsvsvfi_150p_0pnt01250r_500x500x;
            agsvsvfi_150p_0pnt00625r_750x750x;
            agsvsvfi_150p_0pnt01250r_750x750x]);
xmax = max([agsvsvfi_100p_0pnt01250r_300x300x;
            agsvsvfi_100p_0pnt00625r_500x500x;
            agsvsvfi_100p_0pnt00940r_500x500x;
            agsvsvfi_100p_0pnt01250r_500x500x;
            agsvsvfi_150p_0pnt01250r_500x500x;...
            agsvsvfi_150p_0pnt00625r_750x750x;
            agsvsvfi_150p_0pnt01250r_750x750x]);
% Calculate y-axis limits for normal plot
ymin = min([agsvsvfi_100p_0pnt01250r_300x300y;
            agsvsvfi_100p_0pnt00625r_500x500y;
            agsvsvfi_100p_0pnt00940r_500x500y;
            agsvsvfi_100p_0pnt01250r_500x500y;
            agsvsvfi_150p_0pnt01250r_500x500y;
            agsvsvfi_150p_0pnt00625r_750x750y;
            agsvsvfi_150p_0pnt01250r_750x750y]);
ymax = max([agsvsvfi_100p_0pnt01250r_300x300y;
            agsvsvfi_100p_0pnt00625r_500x500y;
            agsvsvfi_100p_0pnt00940r_500x500y;
            agsvsvfi_100p_0pnt01250r_500x500y;
            agsvsvfi_150p_0pnt01250r_500x500y;
            agsvsvfi_150p_0pnt00625r_750x750y;
            agsvsvfi_150p_0pnt01250r_750x750y]);
% Calculate y-axis limits for unit-normalized plots
ymin_UN = min([agsvsvfi_100p_0pnt01250r_300x300(:,2)/agsvsvfi_100p_0pnt01250r_300x300(size(agsvsvfi_100p_0pnt01250r_300x300,1),2);...
               agsvsvfi_100p_0pnt00625r_500x500(:,2)/agsvsvfi_100p_0pnt00625r_500x500(size(agsvsvfi_100p_0pnt00625r_500x500,1),2);...
               agsvsvfi_100p_0pnt00940r_500x500(:,2)/agsvsvfi_100p_0pnt00940r_500x500(size(agsvsvfi_100p_0pnt00940r_500x500,1),2);...
               agsvsvfi_100p_0pnt01250r_500x500(:,2)/agsvsvfi_100p_0pnt01250r_500x500(size(agsvsvfi_100p_0pnt01250r_500x500,1),2);...
               agsvsvfi_150p_0pnt01250r_500x500(:,2)/agsvsvfi_150p_0pnt01250r_500x500(size(agsvsvfi_150p_0pnt01250r_500x500,1),2);...
               agsvsvfi_150p_0pnt00625r_750x750(:,2)/agsvsvfi_150p_0pnt00625r_750x750(size(agsvsvfi_150p_0pnt00625r_750x750,1),2);...
               agsvsvfi_150p_0pnt01250r_750x750(:,2)/agsvsvfi_150p_0pnt01250r_750x750(size(agsvsvfi_150p_0pnt01250r_750x750,1),2)]);
ymax_UN = max([agsvsvfi_100p_0pnt01250r_300x300(:,2)/agsvsvfi_100p_0pnt01250r_300x300(size(agsvsvfi_100p_0pnt01250r_300x300,1),2);...
               agsvsvfi_100p_0pnt00625r_500x500(:,2)/agsvsvfi_100p_0pnt00625r_500x500(size(agsvsvfi_100p_0pnt00625r_500x500,1),2);...
               agsvsvfi_100p_0pnt00940r_500x500(:,2)/agsvsvfi_100p_0pnt00940r_500x500(size(agsvsvfi_100p_0pnt00940r_500x500,1),2);...
               agsvsvfi_100p_0pnt01250r_500x500(:,2)/agsvsvfi_100p_0pnt01250r_500x500(size(agsvsvfi_100p_0pnt01250r_500x500,1),2);...
               agsvsvfi_150p_0pnt01250r_500x500(:,2)/agsvsvfi_150p_0pnt01250r_500x500(size(agsvsvfi_150p_0pnt01250r_500x500,1),2);...
               agsvsvfi_150p_0pnt00625r_750x750(:,2)/agsvsvfi_150p_0pnt00625r_750x750(size(agsvsvfi_150p_0pnt00625r_750x750,1),2);...
               agsvsvfi_150p_0pnt01250r_750x750(:,2)/agsvsvfi_150p_0pnt01250r_750x750(size(agsvsvfi_150p_0pnt01250r_750x750,1),2)]);
%% UNIT NORMALIZED AGS vs CLUSTER VOLUME FRACTION
figure(1)
SizeOfMarkers = 5;
hold on
plot(agsvsvfi_100p_0pnt01250r_300x300(:,1),agsvsvfi_100p_0pnt01250r_300x300(:,2)/agsvsvfi_100p_0pnt01250r_300x300(size(agsvsvfi_100p_0pnt01250r_300x300,1),2),'kd','LineWidth',1,'MarkerSize',SizeOfMarkers)
plot(agsvsvfi_100p_0pnt00625r_500x500(:,1),agsvsvfi_100p_0pnt00625r_500x500(:,2)/agsvsvfi_100p_0pnt00625r_500x500(size(agsvsvfi_100p_0pnt00625r_500x500,1),2),'k<','LineWidth',1,'MarkerSize',SizeOfMarkers)
plot(agsvsvfi_100p_0pnt00940r_500x500(:,1),agsvsvfi_100p_0pnt00940r_500x500(:,2)/agsvsvfi_100p_0pnt00940r_500x500(size(agsvsvfi_100p_0pnt00940r_500x500,1),2),'k^','LineWidth',1,'MarkerSize',SizeOfMarkers)
plot(agsvsvfi_100p_0pnt01250r_500x500(:,1),agsvsvfi_100p_0pnt01250r_500x500(:,2)/agsvsvfi_100p_0pnt01250r_500x500(size(agsvsvfi_100p_0pnt01250r_500x500,1),2),'ks','LineWidth',1,'MarkerSize',SizeOfMarkers)
plot(agsvsvfi_150p_0pnt01250r_500x500(:,1),agsvsvfi_150p_0pnt01250r_500x500(:,2)/agsvsvfi_150p_0pnt01250r_500x500(size(agsvsvfi_150p_0pnt01250r_500x500,1),2),'ko','LineWidth',1,'MarkerSize',SizeOfMarkers)
plot(agsvsvfi_150p_0pnt00625r_750x750(:,1),agsvsvfi_150p_0pnt00625r_750x750(:,2)/agsvsvfi_150p_0pnt00625r_750x750(size(agsvsvfi_150p_0pnt00625r_750x750,1),2),'kh','LineWidth',1,'MarkerSize',SizeOfMarkers)
plot(agsvsvfi_150p_0pnt01250r_750x750(:,1),agsvsvfi_150p_0pnt01250r_750x750(:,2)/agsvsvfi_150p_0pnt01250r_750x750(size(agsvsvfi_150p_0pnt01250r_750x750,1),2),'k>','LineWidth',1,'MarkerSize',SizeOfMarkers)
%%%%%%%%%%%%%%%%%%%%%%%%%%
% GENERATE CURVE-FITS AND PLOT THEM
ft   = fittype('rat31'); % rational polynomials of 3rd and 1st order
opts = fitoptions(ft); opts.Display = 'Off'; opts.Lower = [-Inf -Inf -Inf -Inf -Inf]; opts.Robust = 'LAR'; opts.StartPoint = [rand rand rand rand rand]; opts.Upper = [Inf Inf Inf Inf Inf];

[xData_300x300p100r01250_UN, yData_300x300p100r01250_UN] = prepareCurveData( agsvsvfi_100p_0pnt01250r_300x300(:,1),agsvsvfi_100p_0pnt01250r_300x300(:,2)/agsvsvfi_100p_0pnt01250r_300x300(size(agsvsvfi_100p_0pnt01250r_300x300,1),2) );

[xData_500x500p100r00625_UN, yData_500x500p100r00625_UN] = prepareCurveData( agsvsvfi_100p_0pnt00625r_500x500(:,1),agsvsvfi_100p_0pnt00625r_500x500(:,2)/agsvsvfi_100p_0pnt00625r_500x500(size(agsvsvfi_100p_0pnt00625r_500x500,1),2) );
%[xData_500x500p100r00940_UN, yData_500x500p100r00940_UN] = prepareCurveData( agsvsvfi_100p_0pnt00940r_500x500(:,1),agsvsvfi_100p_0pnt00940r_500x500(:,2)/agsvsvfi_100p_0pnt00940r_500x500(size(agsvsvfi_100p_0pnt00940r_500x500,1),2) );
[xData_500x500p100r01250_UN, yData_500x500p100r01250_UN] = prepareCurveData( agsvsvfi_100p_0pnt01250r_500x500(:,1),agsvsvfi_100p_0pnt01250r_500x500(:,2)/agsvsvfi_100p_0pnt01250r_500x500(size(agsvsvfi_100p_0pnt01250r_500x500,1),2) );
[xData_500x500p150r01250_UN, yData_500x500p150r01250_UN] = prepareCurveData( agsvsvfi_150p_0pnt01250r_500x500(:,1),agsvsvfi_150p_0pnt01250r_500x500(:,2)/agsvsvfi_150p_0pnt01250r_500x500(size(agsvsvfi_150p_0pnt01250r_500x500,1),2) );
%[xData_750x750p150r00625_UN, yData_750x750p150r00625_UN] = prepareCurveData( agsvsvfi_150p_0pnt00625r_750x750(:,1),agsvsvfi_150p_0pnt00625r_750x750(:,2)/agsvsvfi_150p_0pnt00625r_750x750(size(agsvsvfi_150p_0pnt00625r_750x750,1),2) );
[xData_750x750p150r01250_UN, yData_750x750p150r01250_UN] = prepareCurveData( agsvsvfi_150p_0pnt01250r_750x750(:,1),agsvsvfi_150p_0pnt01250r_750x750(:,2)/agsvsvfi_150p_0pnt01250r_750x750(size(agsvsvfi_150p_0pnt01250r_750x750,1),2) );


[fitresult_300x300p100r01250_UN, gof_300x300p100r01250_UN] = fit( xData_300x300p100r01250_UN, yData_300x300p100r01250_UN, ft, opts );


[fitresult_500x500p100r00625_UN, gof_500x500p100r00625_UN] = fit( xData_500x500p100r00625_UN, yData_500x500p100r00625_UN, ft, opts );
%[fitresult_500x500p100r00940_UN, gof_500x500p100r00940_UN] = fit( xData_500x500p100r00940_UN, yData_500x500p100r00940_UN, ft, opts );
[fitresult_500x500p100r01250_UN, gof_500x500p100r01250_UN] = fit( xData_500x500p100r01250_UN, yData_500x500p100r01250_UN, ft, opts );
[fitresult_500x500p150r01250_UN, gof_500x500p150r01250_UN] = fit( xData_500x500p150r01250_UN, yData_500x500p150r01250_UN, ft, opts );
%[fitresult_750x750p150r00625_UN, gof_750x750p150r00625_UN] = fit( xData_750x750p150r00625_UN, yData_750x750p150r00625_UN, ft, opts );
[fitresult_750x750p150r01250_UN, gof_750x750p150r01250_UN] = fit( xData_750x750p150r01250_UN, yData_750x750p150r01250_UN, ft, opts );

FitLineWidth_UN = 1.00;

fittedplot_UN(1) = plot(fitresult_500x500p100r00625_UN,'k--'); set(fittedplot_UN(1),'LineWidth',FitLineWidth_UN)
%fittedplot_UN(2) = plot(fitresult_500x500p100r00940_UN,'k:');  set(fittedplot_UN(2),'LineWidth',FitLineWidth_UN)
fittedplot_UN(3) = plot(fitresult_500x500p100r01250_UN,'k:') ; set(fittedplot_UN(3),'LineWidth',FitLineWidth_UN)
fittedplot_UN(4) = plot(fitresult_500x500p150r01250_UN,'k-.'); set(fittedplot_UN(4),'LineWidth',FitLineWidth_UN)
%fittedplot_UN(5) = plot(fitresult_750x750p150r00625_UN,'k:');  set(fittedplot_UN(5),'LineWidth',FitLineWidth_UN)
fittedplot_UN(6) = plot(fitresult_750x750p150r01250_UN,'k');   set(fittedplot_UN(6),'LineWidth',FitLineWidth_UN)
fittedplot_UN(7) = plot(fitresult_300x300p100r01250_UN,'k:') ; set(fittedplot_UN(7),'LineWidth',FitLineWidth_UN)

% TURN-OFF legend entry for fitted plots:
% hasbehavior(fittedplot_UN(1),'legend',false);
% %hasbehavior(fittedplot_UN(2),'legend',false);
% hasbehavior(fittedplot_UN(3),'legend',false);
% hasbehavior(fittedplot_UN(4),'legend',false);
% %hasbehavior(fittedplot_UN(5),'legend',false);
% hasbehavior(fittedplot_UN(6),'legend',false);
%%%%%%%%%%%%%%%%%%%%%%%%%%
RF = 1000; % round off factor
fig_un01_h = legend('300x300,p100,r0.01250',...
                    '500x500,p100,r0.00625',...
                    '500x500,p100,r0.00940',...
                    '500x500,p100,r0.01250',...
                    '500x500,p150,r0.01250',...
                    '750x750,p100,r0.00625',...
                    '750x750,p150,r0.01250',...
                    strcat(num2str(RF^-1*floor(RF*fitresult_500x500p100r00625_UN.p1)),',',...
                           num2str(RF^-1*floor(RF*fitresult_500x500p100r00625_UN.p2)),',',...
                           num2str(RF^-1*floor(RF*fitresult_500x500p100r00625_UN.p3)),',',...
                           num2str(RF^-1*floor(RF*fitresult_500x500p100r00625_UN.p4)),',',...
                           num2str(RF^-1*floor(RF*fitresult_500x500p100r00625_UN.q1)),'|',...
                           num2str(RF^-1*floor(RF*gof_500x500p100r00625_UN.rmse))),...
                    strcat(num2str(RF^-1*floor(RF*fitresult_500x500p100r01250_UN.p1)),',',...
                           num2str(RF^-1*floor(RF*fitresult_500x500p100r01250_UN.p2)),',',...
                           num2str(RF^-1*floor(RF*fitresult_500x500p100r01250_UN.p3)),',',...
                           num2str(RF^-1*floor(RF*fitresult_500x500p100r01250_UN.p4)),',',...
                           num2str(RF^-1*floor(RF*fitresult_500x500p100r01250_UN.q1)),'|',...
                           num2str(RF^-1*floor(RF*gof_500x500p100r01250_UN.rmse))),...
                    strcat(num2str(RF^-1*floor(RF*fitresult_500x500p150r01250_UN.p1)),',',...
                           num2str(RF^-1*floor(RF*fitresult_500x500p150r01250_UN.p2)),',',...
                           num2str(RF^-1*floor(RF*fitresult_500x500p150r01250_UN.p3)),',',...
                           num2str(RF^-1*floor(RF*fitresult_500x500p150r01250_UN.p4)),',',...
                           num2str(RF^-1*floor(RF*fitresult_500x500p150r01250_UN.q1)),'|',...
                           num2str(RF^-1*floor(RF*gof_500x500p150r01250_UN.rmse))),...
                    strcat(num2str(RF^-1*floor(RF*fitresult_750x750p150r01250_UN.p1)),',',...
                           num2str(RF^-1*floor(RF*fitresult_750x750p150r01250_UN.p2)),',',...
                           num2str(RF^-1*floor(RF*fitresult_750x750p150r01250_UN.p3)),',',...
                           num2str(RF^-1*floor(RF*fitresult_750x750p150r01250_UN.p4)),',',...
                           num2str(RF^-1*floor(RF*fitresult_750x750p150r01250_UN.q1)),'|',...
                           num2str(RF^-1*floor(RF*gof_750x750p150r01250_UN.rmse))),...
                    strcat(num2str(RF^-1*floor(RF*fitresult_300x300p100r01250_UN.p1)),',',...
                           num2str(RF^-1*floor(RF*fitresult_300x300p100r01250_UN.p2)),',',...
                           num2str(RF^-1*floor(RF*fitresult_300x300p100r01250_UN.p3)),',',...
                           num2str(RF^-1*floor(RF*fitresult_300x300p100r01250_UN.p4)),',',...
                           num2str(RF^-1*floor(RF*fitresult_300x300p100r01250_UN.q1)),'|',...
                           num2str(RF^-1*floor(RF*gof_300x300p100r01250_UN.rmse))),...
                    'Location','NorthEast');
set(fig_un01_h,'FontSize',07);
set(fig_un01_h,'Box','Off');
plot([0 1],[1 1],'k','LineWidth',0.5)
axis tight
axis square
box on
axis([xmin xmax 0.9*ymin_UN ymax_UN])
xlabel('Individual cluster volume fraction')
ylabel('Unit normalized AGS')
title('Unit normalized AGS vs. individual cluster volume fraction')
set(gca,'yminortick','on','xminortick','on');
print('-depsc',strcat(pwd,'\compiled_results\monte_carlo','\UNAGS_vs_ICVF.eps'))
print('-djpeg100',strcat(pwd,'\compiled_results\monte_carlo','\UNAGS_vs_ICVF.jpeg'))
%% AGS vs CLUSTER VOLUME FRACTION
figure(2)
SizeOfMarkers = 5;
hold on
plot(agsvsvfi_100p_0pnt01250r_300x300(:,1),agsvsvfi_100p_0pnt01250r_300x300(:,2),'kd','LineWidth',1,'MarkerSize',SizeOfMarkers)
plot(agsvsvfi_100p_0pnt00625r_500x500(:,1),agsvsvfi_100p_0pnt00625r_500x500(:,2),'k<','LineWidth',1,'MarkerSize',SizeOfMarkers)
plot(agsvsvfi_100p_0pnt00940r_500x500(:,1),agsvsvfi_100p_0pnt00940r_500x500(:,2),'k^','LineWidth',1,'MarkerSize',SizeOfMarkers)
plot(agsvsvfi_100p_0pnt01250r_500x500(:,1),agsvsvfi_100p_0pnt01250r_500x500(:,2),'ks','LineWidth',1,'MarkerSize',SizeOfMarkers)
plot(agsvsvfi_150p_0pnt01250r_500x500(:,1),agsvsvfi_150p_0pnt01250r_500x500(:,2),'ko','LineWidth',1,'MarkerSize',SizeOfMarkers)
plot(agsvsvfi_150p_0pnt00625r_750x750(:,1),agsvsvfi_150p_0pnt00625r_750x750(:,2),'kh','LineWidth',1,'MarkerSize',SizeOfMarkers)
plot(agsvsvfi_150p_0pnt01250r_750x750(:,1),agsvsvfi_150p_0pnt01250r_750x750(:,2),'k>','LineWidth',1,'MarkerSize',SizeOfMarkers)

%%%%%%%%%%%%%%%%%%%%%%%%%%
% GENERATE CURVE-FITS AND PLOT THEM
ft = fittype('rat31'); % rational polynomials of 3rd and 1st order
opts=fitoptions(ft); opts.Display='Off'; opts.Lower=[-Inf -Inf -Inf -Inf -Inf]; opts.Robust='LAR'; opts.StartPoint=[rand rand rand rand rand]; opts.Upper=[Inf Inf Inf Inf Inf];
[xData_300x300p100r01250, yData_300x300p100r01250] = prepareCurveData( agsvsvfi_100p_0pnt01250r_300x300(:,1),agsvsvfi_100p_0pnt01250r_300x300(:,2) );
[xData_500x500p100r00625, yData_500x500p100r00625] = prepareCurveData( agsvsvfi_100p_0pnt00625r_500x500(:,1),agsvsvfi_100p_0pnt00625r_500x500(:,2) );
[xData_500x500p100r00940, yData_500x500p100r00940] = prepareCurveData( agsvsvfi_100p_0pnt00940r_500x500(:,1),agsvsvfi_100p_0pnt00940r_500x500(:,2) );
[xData_500x500p100r01250, yData_500x500p100r01250] = prepareCurveData( agsvsvfi_100p_0pnt01250r_500x500(:,1),agsvsvfi_100p_0pnt01250r_500x500(:,2) );
[xData_500x500p150r01250, yData_500x500p150r01250] = prepareCurveData( agsvsvfi_150p_0pnt01250r_500x500(:,1),agsvsvfi_150p_0pnt01250r_500x500(:,2) );
[xData_750x750p150r00625, yData_750x750p150r00625] = prepareCurveData( agsvsvfi_150p_0pnt00625r_750x750(:,1),agsvsvfi_150p_0pnt00625r_750x750(:,2) );
[xData_750x750p150r01250, yData_750x750p150r01250] = prepareCurveData( agsvsvfi_150p_0pnt01250r_750x750(:,1),agsvsvfi_150p_0pnt01250r_750x750(:,2) );

[fitresult_300x300p100r01250, gof_300x300p100r01250] = fit( xData_300x300p100r01250, yData_300x300p100r01250, ft, opts );
[fitresult_500x500p100r00625, gof_500x500p100r00625] = fit( xData_500x500p100r00625, yData_500x500p100r00625, ft, opts );
%[fitresult_500x500p100r00940, gof_500x500p100r00940] = fit( xData_500x500p100r00940, yData_500x500p100r00940, ft, opts );
[fitresult_500x500p100r01250, gof_500x500p100r01250] = fit( xData_500x500p100r01250, yData_500x500p100r01250, ft, opts );
[fitresult_500x500p150r01250, gof_500x500p150r01250] = fit( xData_500x500p150r01250, yData_500x500p150r01250, ft, opts );
%[fitresult_750x750p150r00625, gof_750x750p150r00625] = fit( xData_750x750p150r00625, yData_750x750p150r00625, ft, opts );
[fitresult_750x750p150r01250, gof_750x750p150r01250] = fit( xData_750x750p150r01250, yData_750x750p150r01250, ft, opts );

plot(agsvsvfi_100p_0pnt01250r_300x300(:,1),agsvsvfi_100p_0pnt01250r_300x300(:,2),'kd','LineWidth',1)
plot(agsvsvfi_100p_0pnt00625r_500x500(:,1),agsvsvfi_100p_0pnt00625r_500x500(:,2),'k<','LineWidth',1)
plot(agsvsvfi_100p_0pnt00940r_500x500(:,1),agsvsvfi_100p_0pnt00940r_500x500(:,2),'k^','LineWidth',1)
plot(agsvsvfi_100p_0pnt01250r_500x500(:,1),agsvsvfi_100p_0pnt01250r_500x500(:,2),'ks','LineWidth',1)
plot(agsvsvfi_150p_0pnt01250r_500x500(:,1),agsvsvfi_150p_0pnt01250r_500x500(:,2),'ko','LineWidth',1)
plot(agsvsvfi_150p_0pnt00625r_750x750(:,1),agsvsvfi_150p_0pnt00625r_750x750(:,2),'kh','LineWidth',1)
plot(agsvsvfi_150p_0pnt01250r_750x750(:,1),agsvsvfi_150p_0pnt01250r_750x750(:,2),'k>','LineWidth',1)

legend('300x300,p100,r0.01250',...
       '500x500,p100,r0.00625',...
       '500x500,p100,r0.00940',...
       '500x500,p100,r0.01250',...
       '500x500,p150,r0.01250',...
       '750x750,p100,r0.00625',...
       '750x750,p150,r0.01250')
axis([xmin xmax ymin ymax])
axis tight
axis square
box on
xlabel('Individual cluster volume fraction')
ylabel('Average grain size')
title('AGS vs. individual cluster volume fraction')
set(gca,'yminortick','on','xminortick','on');
print('-deps',strcat(pwd,'\compiled_results\monte_carlo','\AGS_vs_ICVF.eps'))
print('-djpeg100',strcat(pwd,'\compiled_results\monte_carlo','\AGS_vs_ICVF.jpeg'))
figure(1)