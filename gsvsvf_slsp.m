function gsvsvf_slsp

close all
set(0,'DefaultFigureWindowStyle','docked')
%% 200 X 200
figure(1)
vf_vs_gs200x200 = [0.0020 ( (29.473+31.507)/2+(29.880+31.186)/2 )/2;
                   0.0040 ( (18.917+17.767)/2+(18.865+17.868)/2 )/2;
                   0.0080 ( ((15.0880+17.9100)/2 + (15.0550+15.0100)/2)/2 + ((17.1870+15.4260)/2 + (16.8660+15.0740)/2)/2 + ((14.397+14.826)/2 + (14.268+14.529)/2)/2 )/3;
                   0.0120 ( ((11.6460+11.5630)/2 + (11.7030+11.5260)/2)/2 + ((11.0030+11.3890)/2 + (11.0440+11.0970)/2)/2)/2;
                   0.0175 ( ((10.0190+10.0250)/2 + (10.0170+09.9443)/2)/2 + ((09.5447+09.2952)/2 + (09.5479+09.2577)/2)/2)/2;
                   0.0200 ( ((08.8617+09.0485)/2 + (08.9662+08.9725)/2)/2 + ((08.8502+08.9461)/2 + (08.6885+08.9473)/2)/2)/2;
                   0.0300 ( (6.8409+6.8031)/2+(6.8407+6.8679)/2 )/2;
                   0.0400 ( (5.8855+5.8726)/2+(5.9320+5.8851)/2 )/2;];
plot(vf_vs_gs200x200(:,1),vf_vs_gs200x200(:,2)/min(vf_vs_gs200x200(:,2)), 'sk','LineWidth',1, 'MarkerFaceColor', 'r','MarkerSize',7), hold on
%% 300 X 300
vf_vs_gs300x300 = [0.0020 ( (32.585+29.765)/2+(32.716+30.148)/2 )/2;
                   0.0040 ( (22.022+21.775)/2+(22.575+21.673)/2 )/2;
                   0.0080 ( (15.142+15.348)/2+(15.246+15.398)/2 )/2;
                   0.0100 ( 13.034+12.481 )/2;
                   0.0120 ( (11.846+11.841)/2+(11.954+11.897)/2 )/2;
                   0.0175 ( (9.3291+9.2845)/2+(9.3097+9.2992)/2 )/2;
                   0.0200 ( ((8.6964+8.6828)/2+(8.7145+8.7099)/2)/2 + ((8.6078+8.8156)/2+(8.6842+8.8423)/2)/2 )/2;
                   0.0300 ( 6.8101 );
                   0.0400 ( 5.9096 );];
plot(vf_vs_gs300x300(:,1),vf_vs_gs300x300(:,2)/min(vf_vs_gs300x300(:,2)),'ok', 'LineWidth',1, 'MarkerFaceColor','w', 'MarkerSize',6), hold on
%% 500 X 500
vf_vs_gs500x500 = [0.0010 ( ((40.235+40.466)/2+(40.069+40.647)/2)/2 + ((40.020+40.489)/2+(40.255+40.583)/2)/2 )/2;
                   0.0020 ( (29.935+30.394)/2+(30.124+30.586)/2 )/2;
                   0.0030 ( (24.555+24.909)/2+(24.527+24.923)/2 )/2;
                   0.0040 ( (21.406+21.805)/2+(21.463+21.827)/2 )/2;
                   0.0080 ( (14.663+14.734)/2+(14.724+14.745)/2 )/2;
                   0.0120 ( (11.662+11.805)/2+(11.723+11.845)/2 )/2;
                   0.0200 ( (8.8669+8.8421)/2+(8.8865+8.8875)/2 )/2;];
plot(vf_vs_gs500x500(:,1),vf_vs_gs500x500(:,2)/min(vf_vs_gs500x500(:,2)),'^k', 'LineWidth',1,'MarkerFaceColor', 'k','MarkerSize',6), hold on
%% 750 X 750
vf_vs_gs750x750 = [0.0020 ( (31.449+31.618)/2+(31.459+31.511)/2 )/2;
                   0.0040 ( (22.091+21.793)/2+(22.160+21.778)/2 )/2;
                   0.0080 ( (14.791+14.601)/2+(14.839+14.653)/2 )/2;
                   0.0120 ( (12.131+12.086)/2+(12.168+12.095)/2 )/2;
                   0.0200 ( (8.9278+8.9404)/2+(8.9448+8.9448)/2 )/2];
plot(vf_vs_gs750x750(:,1),vf_vs_gs750x750(:,2)/min(vf_vs_gs750x750(:,2)),'>k', 'LineWidth',1, 'MarkerFaceColor','g', 'MarkerSize',6), hold on
%% 1000 X 250
vf_vs_gs1000x250 =[0.0010 ( (35.953+35.818)/2+(35.976+35.981)/2 )/2;
                   0.0100 ( (13.150+13.392)/2+(13.186+13.375)/2 )/2;
                   0.0200 ( (8.7108+8.6773)/2+(8.7213+8.6776)/2 )/2];
plot(vf_vs_gs1000x250(:,1),vf_vs_gs1000x250(:,2)/min(vf_vs_gs1000x250(:,2)),'<k', 'LineWidth',1, 'MarkerFaceColor','c', 'MarkerSize',6), hold on
%%
legend_h = legend(strcat('200x200|$\langle GS\rangle_{S_f=0.02}=\ $',num2str(vf_vs_gs200x200(5,2))),...
                  strcat('300x300|$\langle GS\rangle_{S_f=0.02}=\ $',num2str(vf_vs_gs300x300(6,2))),...
                  strcat('500x500|$\langle GS\rangle_{S_f=0.02}=\ $',num2str(vf_vs_gs500x500(7,2))),...
                  strcat('750x750|$\langle GS\rangle_{S_f=0.02}=\ $',num2str(vf_vs_gs750x750(5,2))),...
                  strcat('1000x250|$\langle GS\rangle_{S_f=0.02}=\ $',num2str(vf_vs_gs1000x250(3,2))),...
                 'Location','NorthEast');
set(legend_h,'Interpreter','Latex')
set(legend_h,'Box','off')
set(legend_h,'FontSize',10)
title('$$gs_{n}\ vs.\ S_f$$','interpreter','latex','FontSize',15)
xlabel('$$S_f$$, Surface area fraction',...
    'interpreter','latex','FontSize',12)
ylabel('$$GS_{n}\ =\ \frac{\langle GS\rangle}{\langle GS\rangle_{S_f = 0.02}}$$ = Normalized $$\langle GS\rangle$$ (intercept method)',...
    'interpreter','latex','FontSize',10)
print('-djpeg100',strcat(pwd,'\plot_norm_ags_vs_vf.jpeg'))
print('-depsc',strcat(pwd,'\plot_norm_ags_vs_vf.eps'))
%% ZENER LIMIT
figure(2)
plot(vf_vs_gs200x200(:,1),vf_vs_gs200x200(:,2), 'sk','LineWidth',1,'MarkerFaceColor', 'k','MarkerSize',6),hold on
plot(vf_vs_gs300x300(:,1),vf_vs_gs300x300(:,2), 'ok','LineWidth',1,'MarkerFaceColor', 'g','MarkerSize',6)
plot(vf_vs_gs500x500(:,1),vf_vs_gs500x500(:,2), '^k','LineWidth',1,'MarkerFaceColor', 'r','MarkerSize',6)
plot(vf_vs_gs750x750(:,1),vf_vs_gs750x750(:,2), '>k','LineWidth',1,'MarkerFaceColor', 'w','MarkerSize',6)
plot(vf_vs_gs1000x250(:,1),vf_vs_gs1000x250(:,2), '<k','LineWidth',1,'MarkerFaceColor', 'c','MarkerSize',6)
legend_h = legend('200x200','300x300','500x500','750x750', '1000x250', 'Location', 'NorthEast');
%set(legend_h,'Interpreter','Latex')
set(legend_h,'Box','off')
set(legend_h,'FontSize',10)
title('Average grain size vs. $$V_f$$','interpreter','latex','FontSize',10)
xlabel('V_f, Volume fraction','FontSize',10)
ylabel('Average grain size','FontSize',10)
print('-djpeg100',strcat(pwd,'\plot_ags_vs_vf.jpeg'))
print('-depsc',strcat(pwd,'\plot_ags_vs_vf.eps'))
% equations:
% 200x200
% General model:
%      f(x) = a*x^(b)
% Coefficients (with 95% confidence bounds):
%        a =       1.138  (0.8079, 1.469)
%        b =     -0.5292  (-0.5806, -0.4777)
% 
% Goodness of fit:
%   SSE: 0.8861
%   R-square: 0.9972
%   Adjusted R-square: 0.9963
%   RMSE: 0.5435
% ==============================================
% 300x300
% General model:
%      f(x) = a*x^b
% Coefficients (with 95% confidence bounds):
%        a =       1.088  (0.877, 1.3)
%        b =     -0.5405  (-0.575, -0.506)
% 
% Goodness of fit:
%   SSE: 0.7146
%   R-square: 0.9981
%   Adjusted R-square: 0.9977
%   RMSE: 0.4227
% ==============================================
% 500x500
% General model:
%      f(x) = a*x^b
% Coefficients (with 95% confidence bounds):
%        a =       1.207  (1.024, 1.389)
%        b =      -0.518  (-0.5422, -0.4938)
% 
% Goodness of fit:
%   SSE: 1.118
%   R-square: 0.9985
%   Adjusted R-square: 0.9982
%   RMSE: 0.4729
% ==============================================
% k = [1.138 1.088 1.207];
% m = [-0.5292 -0.5405 -0.5180];
% plot(1:numel(k),k),hold on
% plot(1:numel(m),m)
end