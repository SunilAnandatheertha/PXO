DataFilePath = ['C:\Users\anandats\OneDrive - Coventry University\coventry-thesis\PAPERS' filesep 'Paper_Support_PolyXTAL_Data.xlsx'];

Hamiltonian_Vs_MCC = xlsread(DataFilePath, 'Hamiltonian', 'B4:BF100004');

Hamiltonian_Vs_MCC_100x100 = Hamiltonian_Vs_MCC(:, 01:36);
Hamiltonian_Vs_MCC_200x200 = Hamiltonian_Vs_MCC(:, 37:57);

M = size(Hamiltonian_Vs_MCC(:, 1),1)-1;

H_Q_2pwr03_100x100 = mean(Hamiltonian_Vs_MCC_100x100(2:M, 1:4), 2);   H_Q_2pwr03_100x100_norm = H_Q_2pwr03_100x100/max(H_Q_2pwr03_100x100);
H_Q_2pwr04_100x100 = mean(Hamiltonian_Vs_MCC_100x100(2:M, 5:8), 2);   H_Q_2pwr04_100x100_norm = H_Q_2pwr04_100x100/max(H_Q_2pwr04_100x100);
H_Q_2pwr05_100x100 = mean(Hamiltonian_Vs_MCC_100x100(2:M, 9:12), 2);  H_Q_2pwr05_100x100_norm = H_Q_2pwr05_100x100/max(H_Q_2pwr05_100x100);
H_Q_2pwr06_100x100 = mean(Hamiltonian_Vs_MCC_100x100(2:M, 13:15), 2); H_Q_2pwr06_100x100_norm = H_Q_2pwr06_100x100/max(H_Q_2pwr06_100x100);
H_Q_2pwr07_100x100 = mean(Hamiltonian_Vs_MCC_100x100(2:M, 17:20), 2); H_Q_2pwr07_100x100_norm = H_Q_2pwr07_100x100/max(H_Q_2pwr07_100x100);
H_Q_2pwr08_100x100 = mean(Hamiltonian_Vs_MCC_100x100(2:M, 21:24), 2); H_Q_2pwr08_100x100_norm = H_Q_2pwr08_100x100/max(H_Q_2pwr08_100x100);
H_Q_2pwr09_100x100 = mean(Hamiltonian_Vs_MCC_100x100(2:M, 25:28), 2); H_Q_2pwr09_100x100_norm = H_Q_2pwr09_100x100/max(H_Q_2pwr09_100x100);
H_Q_2pwr10_100x100 = mean(Hamiltonian_Vs_MCC_100x100(2:M, 29:32), 2); H_Q_2pwr10_100x100_norm = H_Q_2pwr10_100x100/max(H_Q_2pwr10_100x100);
H_Q_2pwr11_100x100 = mean(Hamiltonian_Vs_MCC_100x100(2:M, 33:36), 2); H_Q_2pwr11_100x100_norm = H_Q_2pwr11_100x100/max(H_Q_2pwr11_100x100);


H_Q_2pwr03_200x200 = mean(Hamiltonian_Vs_MCC_200x200(2:M, 37-36:40-36), 2); H_Q_2pwr03_200x200_norm = H_Q_2pwr03_200x200/max(H_Q_2pwr03_200x200);
H_Q_2pwr04_200x200 = mean(Hamiltonian_Vs_MCC_200x200(2:M, 41-36:44-36), 2); H_Q_2pwr04_200x200_norm = H_Q_2pwr04_200x200/max(H_Q_2pwr04_200x200);
H_Q_2pwr05_200x200 = mean(Hamiltonian_Vs_MCC_200x200(2:M, 45-36:48-36), 2); H_Q_2pwr05_200x200_norm = H_Q_2pwr05_200x200/max(H_Q_2pwr05_200x200);
H_Q_2pwr06_200x200 = mean(Hamiltonian_Vs_MCC_200x200(2:M, 49-36:52-36), 2); H_Q_2pwr06_200x200_norm = H_Q_2pwr06_200x200/max(H_Q_2pwr06_200x200);
H_Q_2pwr07_200x200 = mean(Hamiltonian_Vs_MCC_200x200(2:M, 53-36:56-36), 2); H_Q_2pwr07_200x200_norm = H_Q_2pwr07_200x200/max(H_Q_2pwr07_200x200);

close

figure(1)
plot(1:M-1, H_Q_2pwr03_100x100_norm, '-', 'color', [0 0 0], 'linewidth', 1); hold on
plot(1:M-1, H_Q_2pwr04_100x100_norm, ':', 'color', [0 0 0], 'linewidth', 1);
plot(1:M-1, H_Q_2pwr05_100x100_norm, '-.', 'color', [0 0 0], 'linewidth', 1);
plot(1:M-1, H_Q_2pwr06_100x100_norm, '--', 'color', [0 0 0], 'linewidth', 1);
plot(1:M-1, H_Q_2pwr07_100x100_norm, '-', 'color', [0.25 0.50 0.75], 'linewidth', 1);
plot(1:M-1, H_Q_2pwr08_100x100_norm, ':', 'color', [0.25 0.50 0.75], 'linewidth', 1);
plot(1:M-1, H_Q_2pwr09_100x100_norm, '-.', 'color', [0.25 0.50 0.75], 'linewidth', 1);
plot(1:M-1, H_Q_2pwr10_100x100_norm, '--', 'color', [0.25 0.50 0.75], 'linewidth', 1);
plot(1:M-1, H_Q_2pwr11_100x100_norm, '-', 'color', [0.75 0.50 0.25], 'linewidth', 1);
plot(1:M-1, H_Q_2pwr03_200x200_norm, '-', 'color', [0 0 0], 'linewidth', 3); hold on
plot(1:M-1, H_Q_2pwr04_200x200_norm, ':', 'color', [0 0 0], 'linewidth', 3);
plot(1:M-1, H_Q_2pwr05_200x200_norm, '-.', 'color', [0 0 0], 'linewidth', 3);
plot(1:M-1, H_Q_2pwr06_200x200_norm, '--', 'color', [0 0 0], 'linewidth', 3);
plot(1:M-1, H_Q_2pwr07_200x200_norm, '-', 'color', [0.25 0.50 0.75], 'linewidth', 3);

hxl = xlabel('Simulation time');
hyl = ylabel('$\overline{H} = \frac{H}{max(H)}$', 'interpreter', 'latex');
set(gca, 'fontsize', 14)
set(hxl, 'fontsize', 16)
set(hyl, 'fontsize', 18)
set(gca, 'linewidth', 1)
hleg = legend('100^2, Q = 2^3', '100^2, Q = 2^4', '100^2, Q = 2^5',...
              '100^2, Q = 2^6', '100^2, Q = 2^7', '100^2, Q = 2^8',...
              '100^2, Q = 2^9', '100^2, Q = 2^{10}', '100^2, Q = 2^{11}', ...
              '200^2, Q = 2^3', '200^2, Q = 2^4', '200^2, Q = 2^5',...
              '200^2, Q = 2^6', '200^2, Q = 2^7');
set(hleg, 'box', 'off')
set(hleg, 'fontsize', 13)

figure(2)
plot(1:M-1, H_Q_2pwr03_100x100, '-', 'color', [0 0 0], 'linewidth', 1); hold on
plot(1:M-1, H_Q_2pwr04_100x100, ':', 'color', [0 0 0], 'linewidth', 1);
plot(1:M-1, H_Q_2pwr05_100x100, '-.', 'color', [0 0 0], 'linewidth', 1);
plot(1:M-1, H_Q_2pwr06_100x100, '--', 'color', [0 0 0], 'linewidth', 1);
plot(1:M-1, H_Q_2pwr07_100x100, '-', 'color', [0.25 0.50 0.75], 'linewidth', 1);
plot(1:M-1, H_Q_2pwr08_100x100, ':', 'color', [0.25 0.50 0.75], 'linewidth', 1);
plot(1:M-1, H_Q_2pwr09_100x100, '-.', 'color', [0.25 0.50 0.75], 'linewidth', 1);
plot(1:M-1, H_Q_2pwr10_100x100, '--', 'color', [0.25 0.50 0.75], 'linewidth', 1);
plot(1:M-1, H_Q_2pwr11_100x100, '-', 'color', [0.75 0.50 0.25], 'linewidth', 1);

plot(1:M-1, H_Q_2pwr03_200x200, '-', 'color', [0 0 0], 'linewidth', 3); hold on
plot(1:M-1, H_Q_2pwr04_200x200, ':', 'color', [0 0 0], 'linewidth', 3);
plot(1:M-1, H_Q_2pwr05_200x200, '-.', 'color', [0 0 0], 'linewidth', 3);
plot(1:M-1, H_Q_2pwr06_200x200, '--', 'color', [0 0 0], 'linewidth', 3);
plot(1:M-1, H_Q_2pwr07_200x200, '-', 'color', [0.25 0.50 0.75], 'linewidth', 3);

hxl = xlabel('Simulation time');
hyl = ylabel('$H$', 'interpreter', 'latex');
set(gca, 'fontsize', 14)
set(hxl, 'fontsize', 16)
set(hyl, 'fontsize', 18)
set(gca, 'linewidth', 1)
hleg = legend('100^2, Q = 2^3', '100^2, Q = 2^4', '100^2, Q = 2^5',...
              '100^2, Q = 2^6', '100^2, Q = 2^7', '100^2, Q = 2^8',...
              '100^2, Q = 2^9', '100^2, Q = 2^{10}', '100^2, Q = 2^{11}', ...
              '200^2, Q = 2^3', '200^2, Q = 2^4', '200^2, Q = 2^5',...
              '200^2, Q = 2^6', '200^2, Q = 2^7');
set(hleg, 'box', 'off')
set(hleg, 'fontsize', 13)
set(hleg, 'location', 'eastoutside')


% COMPUTER SOUTION TIME
SOLTIME_Q_2pwr03 = 156.7;
SOLTIME_Q_2pwr04 = ;
SOLTIME_Q_2pwr05 = ;
SOLTIME_Q_2pwr06 = ;
SOLTIME_Q_2pwr07 = ;
SOLTIME_Q_2pwr08 = ;
SOLTIME_Q_2pwr09 = ;
SOLTIME_Q_2pwr10 = ;
SOLTIME_Q_2pwr11 = ;