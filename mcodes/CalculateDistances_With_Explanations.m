function [dist_stat, dist_dyn0, eq_dyn0, xq_dyn0, yq_dyn0] = CalculateDistances(frontvector_eq, localfrontvector_eq, eq_stat,...
                                                             xq_stat, yq_stat, eq_dyn, eq_dyn0,...
                                                             xq_dyn, yq_dyn, xq_dyn0, yq_dyn0)

% [~, Indices_FV_in_eq_stat] = intersect(eq_stat, frontvector_eq);
[~, Indices_FV_in_eq_dyn0] = intersect(eq_dyn0, frontvector_eq);

Indices_LFV_in_eq_dyn0 = [];
for count1 = 1:size(localfrontvector_eq,2)
    for count2 = 1:numel(localfrontvector_eq{1,count1})
        [~, Indices_LFV_in_eq_dyn0_temp]  = intersect(eq_dyn0, localfrontvector_eq{1,count1}(count2));
        Indices_LFV_in_eq_dyn0 = unique([Indices_LFV_in_eq_dyn0; Indices_LFV_in_eq_dyn0_temp]);
    end
end

[~, xyq_stat_indices] = intersect(eq_stat, eq_dyn0(Indices_LFV_in_eq_dyn0));
x = xq_stat(xyq_stat_indices);
y = yq_stat(xyq_stat_indices);
% plot(x, y, 'r.', 'markersize', 15)
% pause(0.1)

eq_dyn0(Indices_FV_in_eq_dyn0) = [];
xq_dyn0(Indices_FV_in_eq_dyn0) = [];
yq_dyn0(Indices_FV_in_eq_dyn0) = [];
%----------------------------
%----------------------------


% % % % % NoElemIn_LFV_eq = [];
% % % % % for count = 1:numel(localfrontvector_eq)
% % % % %     NoElemIn_LFV_eq = [NoElemIn_LFV_eq; numel(localfrontvector_eq{1,count}(:))];
% % % % % end
% % % % % NoElemIn_LFV_eq = sum(NoElemIn_LFV_eq);
% % % % % 
% % % % % dist_stat = cell(1, NoElemIn_LFV_eq);
% % % % % dist_dyn0 = cell(1, NoElemIn_LFV_eq);

dist_stat = cell(1, numel(xyq_stat_indices));
dist_dyn0 = cell(1, numel(xyq_stat_indices));


% for frontpoint = 1:numel(frontvector_eq)
%     dist_stat{:,frontpoint} = sqrt((x(frontpoint)-xq_stat).^2+(y(frontpoint)-yq_stat).^2);
%     dist_dyn{:,frontpoint}  = sqrt((x(frontpoint)-xq_dyn).^2+(y(frontpoint)-yq_dyn).^2);
% end

% % % % % if size(localfrontvector_eq,2)>1
% % % % %     for count = 2:size(localfrontvector_eq,2)
% % % % %         v1 = localfrontvector_eq{count-1};
% % % % %         v2 = localfrontvector_eq{count};
% % % % %         localfrontvector_eq{count} = setdiff(v1, v2);
% % % % %     end
% % % % % end
eq_stat_lfv_eq_indices = [];
for frontpoint = 1:size(localfrontvector_eq,2)
    [~, eq_stat_lfv_eq_indices_temp] = intersect(eq_stat, localfrontvector_eq{1,frontpoint}(:, 1));
    eq_stat_lfv_eq_indices = [eq_stat_lfv_eq_indices; eq_stat_lfv_eq_indices_temp];
%     dist_dyn{:,frontpoint}  = sqrt((x(frontpoint)-xq_dyn).^2+(y(frontpoint)-yq_dyn).^2);
end
eq_stat_lfv_eq_indices = unique(eq_stat_lfv_eq_indices);

for count = 1:numel(eq_stat_lfv_eq_indices)
    dist_stat{:,count} = sqrt((xq_stat(eq_stat_lfv_eq_indices(count))-xq_stat).^2 +...
                              (yq_stat(eq_stat_lfv_eq_indices(count))-yq_stat).^2);

    dist_dyn0{:,count} = sqrt((xq_stat(eq_stat_lfv_eq_indices(count))-xq_dyn0).^2 +...
                              (yq_stat(eq_stat_lfv_eq_indices(count))-yq_dyn0).^2);
end