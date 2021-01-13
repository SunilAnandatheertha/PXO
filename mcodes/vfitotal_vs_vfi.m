% (predicted SLSPC total volume fraction and obtained SLSPC total volume
% fraction) vs. individual SSPC volume fraction
% FOR 500x500, p100, r0.00625----:
if isdir(strcat(pwd,'\compiled_results'))==0
    mkdir(strcat(pwd,'\compiled_results'))
end
if isdir(strcat(pwd,'\compiled_results\monte_carlo'))==0
    mkdir(strcat(pwd,'\compiled_results\monte_carlo'))
end
set(0,'DefaultFigureWindowStyle','docked')
% To get the first two columns, use, next two lines with appropriate inputs:
% vfi=[0.0200    0.0250    0.0300    0.0350    0.0400    0.0500    0.0750    0.1000    0.2500    0.5000    0.7500    1.0000];
% Vftotal = pi*(0.0125*500)^2*100*vfi/(500^2);[vfi;Vftotal]'
% To get the therid column, read from file pwd\simparameters\volumefraction.txt

vfi_vs_vftotal_500x500_p100_r0pnt00625 = [0.020000000000000   0.000245436926062               0.0264E-2;
0.025000000000000   0.000306796157577               0.0280E-2;
0.030000000000000   0.000368155389093               0.0392E-2 ;
0.035000000000000   0.000429514620608               0.0468E-2 ;
0.040000000000000   0.000490873852123               0.0432E-2 ;
0.050000000000000   0.000613592315154               0.0604E-2 ;
0.075000000000000   0.000920388472731               0.0968E-2 ;
0.100000000000000   0.001227184630309               0.1088E-2 ;
0.250000000000000   0.003067961575771               0.2900E-2 ;
0.500000000000000   0.006135923151543               0.5736E-2 ;
0.750000000000000   0.009203884727314               0.8664E-2 ;
1.000000000000000   0.012271846303085               1.1428E-2];
fig01a.h = plot(vfi_vs_vftotal_500x500_p100_r0pnt00625(:,1), vfi_vs_vftotal_500x500_p100_r0pnt00625(:,2), 'sk--','Linewidth',0.5, 'MarkerSize',3, 'MarkerFaceColor','w'); hold on
fig01b.h = plot(vfi_vs_vftotal_500x500_p100_r0pnt00625(:,1), vfi_vs_vftotal_500x500_p100_r0pnt00625(:,3), 'sk-','Linewidth',0.5, 'MarkerSize',3, 'MarkerFaceColor','w');

vfi_vs_vftotal_500x500_p100_r0pnt0125 = [0.020000000000000   0.000981747704247               0.0988E-2;
0.030000000000000   0.001472621556370               0.1460E-2;
0.035000000000000   0.001718058482432               0.1780E-2;
0.040000000000000   0.001963495408494               0.2080E-2;
0.050000000000000   0.002454369260617               0.2384E-2;
0.075000000000000   0.003681553890926               0.3744E-2;
0.100000000000000   0.004908738521234               0.4876E-2;
0.250000000000000   0.012271846303085               1.2056E-2;
0.500000000000000   0.024543692606170               2.3928E-2;
0.750000000000000   0.036815538909255               3.5392E-2;
1.000000000000000   0.049087385212341               4.7320E-2];

fig02a_h = plot(vfi_vs_vftotal_500x500_p100_r0pnt0125(:,1), vfi_vs_vftotal_500x500_p100_r0pnt0125(:,2), 'ok--','Linewidth',0.5, 'MarkerSize',3, 'MarkerFaceColor', 'w');
fig02b_h = plot(vfi_vs_vftotal_500x500_p100_r0pnt0125(:,1), vfi_vs_vftotal_500x500_p100_r0pnt0125(:,3), 'ok-','Linewidth',0.5, 'MarkerSize',3, 'MarkerFaceColor', 'w');

fig02_legend_h = legend('500x500,p100,r0.00625,predicted',...
                        '500x500,p100,r0.00625,obtained',...
                        '500x500,p100,r0.0125,predicted',...
                        '500x500,p100,r0.0125,obtained',...
                        'Location','NorthWest');
set(fig02_legend_h,'FontSize',07);
set(fig02_legend_h,'Box','Off');

xlabel('V_{fi}')
ylabel('V_{f}^{total}')
title('V_{f}^{total} vs V_{fi}')
set(gca,'yminortick','on','xminortick','on');
axis square, axis tight
print('-depsc',strcat(pwd,'\compiled_results\monte_carlo','\vfi_vs_vftotal.eps'))