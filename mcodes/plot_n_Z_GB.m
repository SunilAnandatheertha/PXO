function sppongb()
close all
set(0,'DefaultFigureWindowStyle','docked')
%% 200 X 200
% Volume fraction = 1.50% or 0.015
% TRIAL 1,2,3
figure(1),hold on
totalZPT1_200sq      =  606;
nslspgb200sq_mcsT1   = [000 0  ;041 5E2;058 1E3;081 2E3;111 4E3;122 7.5E3;126 1E4;127 2E4;...
                        131 4E4;131 6E4;129 8E4;133 1E5]; %1st col is no of slsp not on gb. This is easier to count using printout.
totalZPT2_200sq      =  606;
nslspgb200sq_mcsT2   = [000 0  ;035 5E2;049 1E3;091 2E3;119 4E3;118 7.5E3;121 1E4;120 2E4;...
                        121 4E4;120 6E4;118 8E4;120 1E5];
totalZPT3_200sq      =  606;
nslspgb200sq_mcsT3   = [000 0  ;048 5E2;061 1E3;087 2E3;106 4E3;111 7.0E3;118 1E4;125 2E4;...
                        127 4E4;129 6E4;125 8E4;121 1E5];
totalZPav_200sq      = (totalZPT1_200sq + totalZPT2_200sq + totalZPT3_200sq)/3;
nslspgb_mcs_av_200sq = (nslspgb200sq_mcsT1 + nslspgb200sq_mcsT2 + nslspgb200sq_mcsT3)/3;
plot(nslspgb200sq_mcsT1(:,2)/max(nslspgb200sq_mcsT1(:,2)),(totalZPT1_200sq-nslspgb200sq_mcsT1(:,1))/totalZPT1_200sq,...
    'xk','MarkerFaceColor','w','MarkerSize',4),hold on
plot(nslspgb200sq_mcsT2(:,2)/max(nslspgb200sq_mcsT2(:,2)),(totalZPT2_200sq-nslspgb200sq_mcsT2(:,1))/totalZPT2_200sq,...
    'xk','MarkerFaceColor','k','MarkerSize',5)
plot(nslspgb200sq_mcsT3(:,2)/max(nslspgb200sq_mcsT3(:,2)),(totalZPT2_200sq-nslspgb200sq_mcsT3(:,1))/totalZPT3_200sq,...
    'xk','MarkerFaceColor','k','MarkerSize',8)
plot(nslspgb_mcs_av_200sq(:,2)/max(nslspgb_mcs_av_200sq(:,2)),(totalZPav_200sq-nslspgb_mcs_av_200sq(:,1))/totalZPav_200sq,...
    'ok-','MarkerFaceColor','k','MarkerSize',5)
%% 500 X 500
% Volume fraction = 0.20% or 0.002
totalZPT2_500sq      = 500;
nslspgb500sq_mcsT2   = [000 0  ;058 2E3;114 1E4;149 2E4;166 5E4;174 6E4;168 7.5E4;175 1E5];
totalZP_av_500sq     = (totalZPT2_500sq)/1;
nslspgb_mcs_av_500sq = (nslspgb500sq_mcsT2)/1;
plot(nslspgb500sq_mcsT2(:,2)/max(nslspgb500sq_mcsT2(:,2)),(totalZPT2_500sq-nslspgb500sq_mcsT2(:,1))/totalZPT2_500sq,...
    'sk','MarkerFaceColor','w','MarkerSize',4)
plot(nslspgb_mcs_av_500sq(:,2)/max(nslspgb_mcs_av_500sq(:,2)),(totalZP_av_500sq-nslspgb_mcs_av_500sq(:,1))/totalZP_av_500sq,...
    'sk-','MarkerFaceColor','g','MarkerSize',5)
legend('200sq.Trial.1.Vf = 1.5%','200sq.Trial.2.Vf = 1.5%','200sq.Trial.3.Vf = 1.5%','\langle 200sq.Trials.1,2,3 \rangle.Vf=1.5%',...
       '500sq.Trial.1.Vf = 0.2%','\langle 500sq.Trials.2 \rangle.Vf = 0.2%','Location','NorthEast')
title('$$\phi_{p}$$ vs. $$t$$','interpreter','latex','FontSize',15)
xlabel('$$t = \left(\frac{t_{sim}}{M}\right)$$, Unit normalized simulation time $$(M=1 X 10^5)$$','interpreter','latex')
ylabel('$$\phi_{p}$$ = Fraction of slsp pinning the GB','interpreter','latex')
axis tight
axis square
print('-djpeg100',strcat(pwd,'\plot_n_Z_GB.jpeg'))
print('-depsc',strcat(pwd,'\plot_n_Z_GB.eps'))
%% PHI vs PSI -- SLSP
figure(2),hold on
%vf slsp = 0.0080
plot(1*[200^2 300^2].^(-1),[(320-(080+092+76)/3)/320 (720-(198)/1)/720],...
    'sk-','LineWidth',1,'MarkerFaceColor','w','MarkerSize',4)
%vf slsp = 0.0120
plot(1*[200^2].^(-1),(480-(111+080)/2)/480,...
    'ok-','LineWidth',1,'MarkerFaceColor','g','MarkerSize',4)
%vf slsp = 0.0150
plot(1*[200^2;500^2].^(-1),...
    [(totalZPav_200sq-nslspgb_mcs_av_200sq(size(nslspgb_mcs_av_200sq,1),1))/totalZPav_200sq;
     (totalZP_av_500sq-nslspgb_mcs_av_500sq(size(nslspgb_mcs_av_500sq,1),1))/totalZP_av_500sq],...
    'sk-','LineWidth',1,'MarkerFaceColor','r','MarkerSize',4)
%vf slsp = 0.0175
plot(1*[200^2].^(-1),(700-(158+128)/2)/700,...
    '^k-','LineWidth',1,'MarkerFaceColor','g','MarkerSize',4)
%vf slsp = 0.0200
plot(1*[200^2 300^2].^(-1),[(800-(136+162)/2)/800 (1800-(334)/1)/1800],...
    '^k-','LineWidth',1,'MarkerFaceColor','b','MarkerSize',4)
%----------------
%slspc specification parameters: 
% slspc.vfi.lsv.lss.cft.np.pr
% slspc - single lattice site particle cluster
% vft - vf of all slspc in lattice
% lsv - no of lattice sites in volume
% lss - no of lattice sites on
% vfi - vf of individual slspc
% np - number of particles
% slspc_n - number of slspc
% slspc_r - radius of each slspc (the value defined in procureinputs2d)
%----------------
%slspc.vft=0.0762,lsv61,lss32,vfi=1.0000.slspc_n=50,slspc_r=0.022
plot(32*[200^2].^(-1),(50-(0)/1)/50,...
    '^k-','LineWidth',1,'MarkerFaceColor','w','MarkerSize',6)
%----------------
legend_h = legend('spp.0.0080,1,1',...
                  'spp.0.0120,1,1',...
                  'spp.0.0150,1,1',...
                  'spp.0.0175,1,1',...
                  'spp.0.0200,1,1',...
                  'spp.0.0762,61,32,1.00',...
                  'Location','SouthEast');
set(legend_h,'Interpreter','Latex')
set(legend_h,'Box','off')
set(legend_h,'FontSize',8)
text(0.40*200^(-2),1.02*(totalZPav_200sq-nslspgb_mcs_av_200sq(size(nslspgb_mcs_av_200sq,1),1))/totalZPav_200sq,...
    '$$t_{sim}=1X10^5,V_f = 0.015$$','interpreter','latex','FontSize',8)
text(0.80*500^(-2),0.97*(totalZP_av_500sq-nslspgb_mcs_av_500sq(size(nslspgb_mcs_av_500sq,1),1))/totalZP_av_500sq,...
    '$$t_{sim}=1X10^5,V_f = 0.01$$','interpreter','latex','FontSize',8)
title('$$\phi_{p}$$ vs. $$\psi.$$','interpreter','latex','FontSize',12.5)
xlabel('$$\psi = \frac{A_{spp}}{A_{l}}$$','interpreter','latex')
ylabel('$$\phi_{p}$$ = Fraction of slsp pinning the GB','interpreter','latex')
box on
axis square
print('-djpeg100',strcat(pwd,'\plot_n_Z_GB_vslatticesize.jpeg'))
print('-depsc',strcat(pwd,'\plot_n_Z_GB_vslatticesize.eps'))
%% PHI vs PSI -- SLSPC
figure(3),hold on
plot(32*[200^2].^(-1),(50-(0)/1)/50,...
    'ok-','LineWidth',1,'MarkerFaceColor','k','MarkerSize',6)
legend_h = legend('slspc.0.762,61,32,1.00',...
                  'Location','NorthWest');
set(legend_h,'Interpreter','Latex')
set(legend_h,'Box','off')
set(legend_h,'FontSize',8)
title('$$\phi_{p}$$ vs. $$\psi.$$','interpreter','latex','FontSize',12.5)
xlabel('$$\psi = \frac{A_{spp}}{A_{l}}$$','interpreter','latex')
ylabel('$$\phi_{p}$$ = Fraction of slsp pinning the GB','interpreter','latex')
box on
axis square
axis tight
print('-djpeg100',strcat(pwd,'\plot_n_Z_GB_vslatticesize_slspc.jpeg'))
print('-depsc',strcat(pwd,'\plot_n_Z_GB_vslatticesize_slspc.eps'))
end