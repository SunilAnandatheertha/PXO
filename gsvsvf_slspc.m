function gsvsvf_slspc
close all
set(0,'DefaultFigureWindowStyle','docked')
close all
figure(1)
% 200 x 200 : 025slspc
vf_vs_gs200x200slspc025 = [0.1250 0.2675 ( (47.783+35.453)/2+(48.662+36.156)/2 )/2;
                           0.2500 1.1125 ( ((29.473+29.038)/2+(31.507+34.248)/2)/2+ ((29.880+28.835)/2+(31.186+34.504)/2)/2 )/2;
                           0.5000 1.1400 ( (25.497+23.765)/2+(25.529+24.052)/2 )/2;
                           0.7500 1.6775 ( (27.599+31.029)/2+(27.361+31.603)/2 )/2;
                           1.0000 2.3125 ( (31.585+28.467)/2+(31.774+28.494)/2 )/2;];
% 300 x 300 : 050slspc
vf_vs_gs300x300slspc050 = [0.2500 0.2778 ( (33.969+39.843)/2+(34.063+39.952)/2 )/2;
                           0.5000 0.5711 ( (30.425+31.421)/2+(30.581+31.595)/2 )/2;];
% 300 x 300 : 100slspc
vf_vs_gs300x300slspc100 = [0.2500 0.5822 ( (25.195+24.604)/2+(25.190+24.638)/2 )/2;
                           0.5000 1.1778 ( (23.100+23.335)/2+(23.070+23.677)/2 )/2;];
% 300 x 300 : 100slspc
vf_vs_gs500x500slspc050 = [0.2500 0.5822 ( (25.195+24.604)/2+(25.190+24.638)/2 )/2;
                           0.5000 1.1778 ( (23.100+23.335)/2+(23.070+23.677)/2 )/2;];
plot(vf_vs_gs200x200slspc025(:,1),...
     vf_vs_gs200x200slspc025(:,3)/vf_vs_gs200x200slspc025(size(vf_vs_gs200x200slspc025,1), size(vf_vs_gs200x200slspc025,2)),...
     'sk-','LineWidth',1,'MarkerFaceColor','r','MarkerSize',5),hold on
plot(vf_vs_gs300x300slspc050(:,1),...
     vf_vs_gs300x300slspc050(:,3)/vf_vs_gs300x300slspc050(size(vf_vs_gs300x300slspc050,1), size(vf_vs_gs300x300slspc050,2)),...
     'ok-','LineWidth',1,'MarkerFaceColor','r','MarkerSize',5)
plot(vf_vs_gs300x300slspc100(:,1),...
     vf_vs_gs300x300slspc100(:,3)/vf_vs_gs300x300slspc100(size(vf_vs_gs300x300slspc100,1), size(vf_vs_gs300x300slspc100,2)),...
     '^k-','LineWidth',1,'MarkerFaceColor','r','MarkerSize',5)
legend_h = legend(strcat('200x200;25slspc;$\langle GS\rangle$', '=',num2str(vf_vs_gs200x200slspc025(size(vf_vs_gs200x200slspc025,1), size(vf_vs_gs200x200slspc025,2)))),...
                  strcat('300x300;25slspc;$\langle GS\rangle$', '=',num2str(vf_vs_gs300x300slspc050(size(vf_vs_gs300x300slspc050,1), size(vf_vs_gs300x300slspc050,2)))),...
                  strcat('300x300;50slspc;$\langle GS\rangle$', '=',num2str(vf_vs_gs300x300slspc050(size(vf_vs_gs300x300slspc050,1), size(vf_vs_gs300x300slspc050,2)))),...
                 'Location','Best');
set(legend_h,'Interpreter','Latex')
set(legend_h,'Box','off')
set(legend_h,'FontSize',10)
title('$$gs_{n}\ vs.\ S_{f.islspc}$$','interpreter','latex','FontSize',15)
xlabel('$$S_f$$, Surface area fraction',...
    'interpreter','latex','FontSize',12)
ylabel('$$GS_{n}\ =\ \frac{\langle GS\rangle}{\langle GS\rangle_{S_{f.islspc} = 1.0}}$$',...
    'interpreter','latex','FontSize',10)
print('-djpeg100',strcat(pwd,'\plot_norm_ags_vs_Sfislspc.jpeg'))
print('-depsc',strcat(pwd,'\plot_norm_ags_vs_Sfislspc.eps'))
%<><><><><><><><><><><><><><>
figure(2)
plot(vf_vs_gs200x200slspc025(:,2),vf_vs_gs200x200slspc025(:,3),...
     'sk-','LineWidth',1,'MarkerFaceColor','r','MarkerSize',5),hold on
plot(vf_vs_gs300x300slspc050(:,2),vf_vs_gs300x300slspc050(:,3),...
     'ok-','LineWidth',1,'MarkerFaceColor','r','MarkerSize',5)
plot(vf_vs_gs300x300slspc100(:,2),vf_vs_gs300x300slspc100(:,3),...
     '^k-','LineWidth',1,'MarkerFaceColor','r','MarkerSize',5)
legend_h = legend(strcat('200x200;25slspc;$\langle GS\rangle$', '=', num2str(vf_vs_gs200x200slspc025(size(vf_vs_gs200x200slspc025,1), size(vf_vs_gs200x200slspc025,2)))),...
                  strcat('300x300;25slspc;$\langle GS\rangle$', '=', num2str(vf_vs_gs300x300slspc050(size(vf_vs_gs300x300slspc050,1), size(vf_vs_gs300x300slspc050,2)))),...
                  strcat('300x300;50slspc;$\langle GS\rangle$', '=', num2str(vf_vs_gs300x300slspc050(size(vf_vs_gs300x300slspc050,1), size(vf_vs_gs300x300slspc050,2)))),...
                 'Location','SouthEast');
set(legend_h,'Interpreter','Latex')
set(legend_h,'Box','off')
set(legend_h,'FontSize',8)
axis([0 2.5 0 45])
title('$$gs_{n}\ vs.\ S_{f.slspc}$$', 'interpreter', 'latex', 'FontSize',15)
xlabel('$$S_f$$, Volume fraction',...
    'interpreter','latex','FontSize',12)
ylabel('$$GS_{n}\ =\ \frac{\langle GS\rangle}{\langle GS\rangle_{S_{f.islspc} = 1.0}}$$',...
    'interpreter','latex','FontSize',10)
print('-djpeg100',strcat(pwd,'\plot_norm_ags_vs_Sfslspc.jpeg'))
print('-depsc',strcat(pwd,'\plot_norm_ags_vs_Sfslspc.eps'))
%<><><><><><><><><><><><><><>
%%
figure(3)
Vfislspc_vs_Vfslspc_200x200_025slsp = [0.250 1.1125;
                                       0.500 1.1400;
                                       0.750 1.6775;
                                       1.000 2.3125];
Vfislspc_vs_Vfslspc_300x300_050slsp = [0.250 0.2778;
                                       0.500 0.5711;];
Vfislspc_vs_Vfslspc_300x300_100slsp = [0.250 0.5822;
                                       0.500 1.1778;];
plot(Vfislspc_vs_Vfslspc_200x200_025slsp(:,1), Vfislspc_vs_Vfslspc_200x200_025slsp(:,2),...
    'ok-','LineWidth' ,1, 'MarkerFaceColor','w', 'MarkerSize',7),hold on
plot(Vfislspc_vs_Vfslspc_300x300_050slsp(:,1), Vfislspc_vs_Vfslspc_300x300_050slsp(:,2),...
    'sk-','LineWidth' ,1, 'MarkerFaceColor','w', 'MarkerSize',7)
plot(Vfislspc_vs_Vfslspc_300x300_100slsp(:,1), Vfislspc_vs_Vfslspc_300x300_100slsp(:,2),...
    'hk-','LineWidth' ,1, 'MarkerFaceColor','w', 'MarkerSize',7)
legend_h = legend(strcat('200x200,25slspc'),...
                  strcat('300x300,50slspc'),...
                  strcat('300x300,100slspc'),...
                  'Location','SouthEast');
% set(legend_h,'Interpreter','Latex')
set(legend_h,'Box','off')
set(legend_h,'FontSize',10)
title('$$S_{f.slspc}\ vs.\ S_{f.islspc}$$','interpreter', 'latex', 'FontSize',15)
xlabel('$$S_{f.islspc}$$','interpreter','latex','FontSize',15)
ylabel('$$S_{f.slspc}$$','interpreter','latex','FontSize',15)
print('-djpeg100',strcat(pwd,'\plot_Sfislspc_vs_Sfslspc.jpeg'))
print('-depsc',strcat(pwd,'\plot_Sfislspc_vs_Sfslspc.eps'))
end