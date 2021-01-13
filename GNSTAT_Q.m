function [Number_of_grains_this_slice] = GNSTAT_Q(All_GrainAreas_Q, Q, nbins, CFN, titlestring1, cm)

% This function returns statistics of number of grains for q
GN_q = [];
for q = 1:Q
    if numel(All_GrainAreas_Q{q})~=0
        GN_q = [GN_q; numel(All_GrainAreas_Q{q})];
    end
end

Number_of_grains_this_slice = sum(GN_q);

% GA(GA==0) = [];

figure
h1 = histogram(GN_q, Q, 'BinWidth', 0.50);
hold on
h1.Normalization = 'probability';
h1.FaceColor = [00, 50, 250]/300;
% axis square
title(titlestring1, 'fontsize', 10)
xl1 = xlabel('Number of grains');
yl1 = ylabel('Probability');
set(gca, 'fontsize', 12)
set([xl1 yl1], 'fontsize', 14)
axis([0 10 0 0.75])
clear h1 xl1 yl1
% CFN = length(findobj('type','figure'));
%-------------------------------------------------
%  Do not remove this pause !!
pause(0.1)
%-------------------------------------------------
figure% Do not remove
BarGraphBarWidth = 1.0;
[barlength, sortedid] = sort(GN_q, 'descend');
% xtemp = reshape(1:Q, size(GN_q));
xtemp = 1:Q; xtemp = xtemp';
xtemp = xtemp(sortedid);
cm_sorted = cm(sortedid,:);
for count = 1:numel(xtemp)
    barcolor = cm_sorted(count,:);
    if barlength(count)~=0
        bar(xtemp(count), barlength(count), BarGraphBarWidth,...
            'facecolor', barcolor, 'edgecolor', barcolor, 'linewidth', 1)
    end
    if count == 1
        hold on
    end
%     pause(0.001)
end
%---------------------------------------------------------------
if numel(xtemp)<=100
    axis off
    text(xtemp, 1.05*barlength,...
        [repmat('N_g = ', size(xtemp)),...
         num2str(barlength),...
         repmat(', q = ', size(xtemp)) num2str(xtemp)],...
         'rotation', 90,...
         'fontsize', 8);
    set(gca,'XTick',floor(linspace(0, Q, 8)))
    axis([0 Q 0 1.25*max(barlength)])
else
    % To do
end
CFN = length(findobj('type','figure'));
% pause(0.001)
end
