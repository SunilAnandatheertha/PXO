function [CFN, GA] = GASTAT(All_GrainAreas_Q, ogn, nbins, CFN, titlestring1)

Q = size(All_GrainAreas_Q,2);

GA = zeros(ogn, 1);
grain = 1;
for q = 1:Q
    for ng = 1:size(All_GrainAreas_Q{q})
        GA(grain,1) = All_GrainAreas_Q{q}{1, ng};
        grain = grain + 1;
    end
end
GA(GA==0) = [];

% figure(CFN+1)
figure
h1 = histogram(GA, nbins, 'BinWidth', 2);
hold on
h1.Normalization = 'probability';
h1.FaceColor = [100, 255, 100]/255;

% max_ind = find(h1.Values==max(h1.Values));
% y_of_maximum = h1.Values(max_ind);
% x_of_maximum = h1.BinEdges(max_ind);
% text(x_of_maximum, 1.1*y_of_maximum, ['P(' num2str(x_of_maximum) ' unit^2) = ' num2str(y_of_maximum)], 'FontSize', 12)

% axis square
title(titlestring1, 'fontsize', 10)
xl1 = xlabel('Grain area, unit^2');
yl1 = ylabel('Probability');

set(gca, 'fontsize', 12)
set([xl1 yl1], 'fontsize', 14)
axis([0 200 0 0.25])
CFN = length(findobj('type','figure'));
end