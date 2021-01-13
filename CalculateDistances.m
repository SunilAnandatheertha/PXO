function [dist_dyn0, eq_dyn0, xq_dyn0, yq_dyn0] = CalculateDistances(frontvector_eq, localfrontvector_eq, eq_stat,...
                                                             xq_stat, yq_stat, eq_dyn0,...
                                                             xq_dyn0, yq_dyn0)
%------------------------------------------------------
[~, Indices_FV_in_eq_dyn0] = intersect(eq_dyn0, frontvector_eq);
Indices_LFV_in_eq_dyn0     = [];

% In this loop, the cell arrays can be replaced by temporarily assigned matrices to speed up the element access
for count1 = 1:size(localfrontvector_eq,2)
    for count2 = 1:numel(localfrontvector_eq{1,count1})
        [~, Indices_LFV_in_eq_dyn0_temp]  = intersect(eq_dyn0, localfrontvector_eq{1, count1}(count2));
        Indices_LFV_in_eq_dyn0 = unique([Indices_LFV_in_eq_dyn0; Indices_LFV_in_eq_dyn0_temp]);
    end
end
%------------------------------------------------------
[~, xyq_stat_indices] = intersect(eq_stat, eq_dyn0(Indices_LFV_in_eq_dyn0));
% x = xq_stat(xyq_stat_indices);
% y = yq_stat(xyq_stat_indices);
%------------------------------------------------------
eq_dyn0(Indices_FV_in_eq_dyn0) = [];
xq_dyn0(Indices_FV_in_eq_dyn0) = [];
yq_dyn0(Indices_FV_in_eq_dyn0) = [];
%------------------------------------------------------
% % % % dist_stat = cell(1, numel(xyq_stat_indices));
dist_dyn0 = cell(1, numel(xyq_stat_indices));
%------------------------------------------------------
eq_stat_lfv_eq_indices = [];
for frontpoint = 1:size(localfrontvector_eq,2)
    [~, eq_stat_lfv_eq_indices_temp] = intersect(eq_stat, localfrontvector_eq{1,frontpoint}(:, 1));
    eq_stat_lfv_eq_indices = [eq_stat_lfv_eq_indices; eq_stat_lfv_eq_indices_temp];
end
eq_stat_lfv_eq_indices = unique(eq_stat_lfv_eq_indices);
%------------------------------------------------------
for count = 1:numel(eq_stat_lfv_eq_indices)
% % % %     dist_stat{:,count} = sqrt((xq_stat(eq_stat_lfv_eq_indices(count))-xq_stat).^2 +...
% % % %                               (yq_stat(eq_stat_lfv_eq_indices(count))-yq_stat).^2);

    dist_dyn0{:,count} = sqrt((xq_stat(eq_stat_lfv_eq_indices(count))-xq_dyn0).^2 +...
                              (yq_stat(eq_stat_lfv_eq_indices(count))-yq_dyn0).^2);
end
%------------------------------------------------------