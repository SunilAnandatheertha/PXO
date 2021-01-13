function [NGRAINS] = Plot__Ng__with__Temporal_Slices(Number_of_grains)

NGRAINS = zeros(numel(Number_of_grains),1);
for countng = 1:numel(Number_of_grains)
    NGRAINS(countng) = Number_of_grains{countng};
end
figure
slicenumbers = 1:numel(Number_of_grains);
plot(slicenumbers, NGRAINS, 'ks', 'MarkerFaceColor', 'c', 'linewidth', 1, 'markersize', 12); hold on
for temp = 1:numel(Number_of_grains)
    text(slicenumbers(temp), 150+Number_of_grains{temp}, num2str(NGRAINS(temp)), 'fontsize', 10)
end
hxl = xlabel('s_t, Temporal slice #');
hyl = ylabel('N_g, # of grains');
xlim([0 numel(Number_of_grains)])
ylim([0 ceil(max(NGRAINS)*1.25/1000)*1000])
set(gca, 'linewidth', 2)
set(gca, 'fontsize', 12)
set([hxl hyl], 'fontsize', 14)
end