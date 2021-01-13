function [WM51_dist, WM52_dist, WM53_dist, WM54_dist, WM56_dist, WM57_dist, WM58_dist, WM59_dist, Wsum] = CalcPlotWeights_V_1(x, y, sign, xconst, yconst, xpower, ypower, power, MultipleOfNorm)

xoffset = min(min(x));
yoffset = min(min(y));
xx       = x + abs(xoffset);
yy       = y + abs(yoffset);
%^^^^^^^^^^^^^^
% 1st column
WM51_dist = sign(1,1)*(xconst(1,1)./(xx.^xpower(1,1)) + yconst(1,1)./(yy.^ypower(1,1))).^power(1,1);
WM52_dist = sign(2,1)*(xconst(2,1)./(xx.^xpower(2,1)) + yconst(2,1)./(yy.^ypower(2,1))).^power(2,1);
WM53_dist = sign(3,1)*(xconst(3,1)./(xx.^xpower(3,1)) + yconst(3,1)./(yy.^ypower(3,1))).^power(3,1);
% 2nd column
WM54_dist = sign(1,2)*(xconst(1,2)./(xx.^xpower(1,2)) + yconst(1,2)./(yy.^ypower(1,2))).^power(1,2);
WM56_dist = sign(3,2)*(xconst(3,2)./(xx.^xpower(3,2)) + yconst(3,2)./(yy.^ypower(3,2))).^power(3,2);
% 3rd column
WM57_dist = sign(1,3)*(xconst(1,3)./(xx.^xpower(1,3)) + yconst(1,3)./(yy.^ypower(1,3))).^power(1,3);
WM58_dist = sign(2,3)*(xconst(2,3)./(xx.^xpower(2,3)) + yconst(2,3)./(yy.^ypower(2,3))).^power(2,3);
WM59_dist = sign(3,3)*(xconst(3,3)./(xx.^xpower(3,3)) + yconst(3,3)./(yy.^ypower(3,3))).^power(3,3);
%^^^^^^^^^^^^^^
WM51_dist = MultipleOfNorm(1,1)*WM51_dist./max(max(abs(WM51_dist)));
WM52_dist = MultipleOfNorm(2,1)*WM52_dist./max(max(abs(WM52_dist)));
WM53_dist = MultipleOfNorm(3,1)*WM53_dist./max(max(abs(WM53_dist)));
WM54_dist = MultipleOfNorm(1,2)*WM54_dist./max(max(abs(WM54_dist)));
WM56_dist = MultipleOfNorm(3,2)*WM56_dist./max(max(abs(WM56_dist)));
WM57_dist = MultipleOfNorm(1,3)*WM57_dist./max(max(abs(WM57_dist)));
WM58_dist = MultipleOfNorm(2,3)*WM58_dist./max(max(abs(WM58_dist)));
WM59_dist = MultipleOfNorm(3,3)*WM59_dist./max(max(abs(WM59_dist)));
%^^^^^^^^^^^^^^
dataind_incr_i = 5;
dataind_incr_j = 5;
%^^^^^^^^^^^^^^
dataindi = 1:dataind_incr_i:size(x, 1);
dataindj = 1:dataind_incr_j:size(x, 2);
figure
subplot(3,3,1); surf(x(dataindi, dataindj), y(dataindi, dataindj), WM51_dist(dataindi, dataindj), 'edgecolor', 'none'); xlabel('x'); ylabel('y'); zlabel('$\overline{W}_{51}$', 'interpreter', 'latex');set(gca, 'fontsize', 10);axis square; axis tight; grid on; box on; zlim([-1 1]);  axis tight; colorbar
subplot(3,3,2); surf(x(dataindi, dataindj), y(dataindi, dataindj), WM54_dist(dataindi, dataindj), 'edgecolor', 'none'); xlabel('x'); ylabel('y'); zlabel('$\overline{W}_{54}$', 'interpreter', 'latex');set(gca, 'fontsize', 10);axis square; axis tight; grid on; box on; zlim([-1 1]);  axis tight; colorbar
subplot(3,3,3); surf(x(dataindi, dataindj), y(dataindi, dataindj), WM57_dist(dataindi, dataindj), 'edgecolor', 'none'); xlabel('x'); ylabel('y'); zlabel('$\overline{W}_{57}$', 'interpreter', 'latex');set(gca, 'fontsize', 10);axis square; axis tight; grid on; box on; zlim([-1 1]);  axis tight; colorbar
subplot(3,3,4); surf(x(dataindi, dataindj), y(dataindi, dataindj), WM52_dist(dataindi, dataindj), 'edgecolor', 'none'); xlabel('x'); ylabel('y'); zlabel('$\overline{W}_{52}$', 'interpreter', 'latex');set(gca, 'fontsize', 10);axis square; axis tight; grid on; box on; zlim([-1 1]);  axis tight; colorbar
subplot(3,3,6); surf(x(dataindi, dataindj), y(dataindi, dataindj), WM58_dist(dataindi, dataindj), 'edgecolor', 'none'); xlabel('x'); ylabel('y'); zlabel('$\overline{W}_{58}$', 'interpreter', 'latex');set(gca, 'fontsize', 10);axis square; axis tight; grid on; box on; zlim([-1 1]);  axis tight; colorbar
subplot(3,3,7); surf(x(dataindi, dataindj), y(dataindi, dataindj), WM53_dist(dataindi, dataindj), 'edgecolor', 'none'); xlabel('x'); ylabel('y'); zlabel('$\overline{W}_{53}$', 'interpreter', 'latex');set(gca, 'fontsize', 10);axis square; axis tight; grid on; box on; zlim([-1 1]);  axis tight; colorbar
subplot(3,3,8); surf(x(dataindi, dataindj), y(dataindi, dataindj), WM56_dist(dataindi, dataindj), 'edgecolor', 'none'); xlabel('x'); ylabel('y'); zlabel('$\overline{W}_{56}$', 'interpreter', 'latex');set(gca, 'fontsize', 10);axis square; axis tight; grid on; box on; zlim([-1 1]);  axis tight; colorbar
subplot(3,3,9); surf(x(dataindi, dataindj), y(dataindi, dataindj), WM59_dist(dataindi, dataindj), 'edgecolor', 'none'); xlabel('x'); ylabel('y'); zlabel('$\overline{W}_{59}$', 'interpreter', 'latex');set(gca, 'fontsize', 10);axis square; axis tight; grid on; box on; zlim([-1 1]);  axis tight; colorbar
pause(0.25)
Wsum = WM51_dist+WM52_dist+WM53_dist+WM54_dist+WM56_dist+WM57_dist+WM58_dist+WM59_dist;
Wsum = Wsum/max(max(Wsum));
subplot(3,3,5); surf(x(dataindi, dataindj), y(dataindi, dataindj), Wsum(dataindi, dataindj), 'edgecolor', 'k'); xlabel('x'); ylabel('y'); zlabel('$\Sigma\overline{W}_{ij}$', 'interpreter', 'latex');set(gca, 'fontsize', 10);axis tight; grid off; box on;axis square;colorbar
colormap jet
% hp4 = get(subplot(3,3,9),'Position');
% c = colorbar('Position', [hp4(1)+0.22  hp4(2)+0.05  0.02  0.7]);
% c.Label.String = 'unit normalized weight';
% c.Label.FontSize = 12;
% set(c, 'fontsize', 12)
pause(0.2)
%^^^^^^^^^^^^^^
end