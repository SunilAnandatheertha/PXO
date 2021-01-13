function [frontvector_eq, localfrontvector_eq,...
         Type_of_SP, GrainFull, eq_dyn0, xq_dyn0, yq_dyn0] = ChooseSourcePointsForFront(eq_stat, eq_dyn, xq_stat,...
                                                             yq_stat, xq_dyn, yq_dyn,...
                                                             frontvector_eq, Type_of_SP, GrainFull,...
                                                             xincr, yincr,...
                                                             eq_dyn0, xq_dyn0, yq_dyn0)
% Select a single seed point and put it in frontvector
if Type_of_SP == 1
    frontvector_eq = frontvector_eq;
    localfrontvector_eq = {frontvector_eq};
    %----------------------------
%     [~, plotind1] = intersect(eq_stat, frontvector_eq);
%     [~, plotind2] = intersect(eq_dyn0, frontvector_eq);
%     plotind3 = setdiff(plotind1, plotind2);
%     [~, plotind3a] = setdiff(intersect(eq_stat, frontvector_eq), intersect(eq_dyn0, frontvector_eq));
    
%     aaa = plot(xq_stat(plotind1), yq_stat(plotind1), 'c+', 'markersize', 3);
%     bbb = plot(xq_stat(plotind2), yq_stat(plotind2), 'b+', 'markersize', 3);
%     ccc = plot(xq_stat(plotind3), yq_stat(plotind3), 'r+', 'markersize', 3);
%     
%     delete(aaa)
%     delete(bbb)
%     pause(1)
    %----------------------------
end

if Type_of_SP == 0
    RE_dyn = randi(numel(eq_dyn0));
    frontvector_eq      = eq_stat(find(eq_stat==eq_dyn0(RE_dyn)));
    localfrontvector_eq = {frontvector_eq};
    Type_of_SP = 1; % Update the type of seed point i.e. start point
    % plot(xq_dyn, yq_dyn, '.', 'color', [0.0 0.8 0.8])
%     aa = plot(xq_stat(eq_stat==localfrontvector_eq{1}), yq_stat(eq_stat==localfrontvector_eq{1}), 'rx', 'markersize', 10);
%     delete(aa)
%     pause(0.1)
end

[dist_stat, dist_dyn0, eq_dyn0, xq_dyn0, yq_dyn0] = CalculateDistances(frontvector_eq, localfrontvector_eq, eq_stat,...
                                                    xq_stat, yq_stat, eq_dyn, eq_dyn0,...
                                                    xq_dyn, yq_dyn, xq_dyn0, yq_dyn0);

[frontvector_eq, localfrontvector_eq,...
                              GrainFull] = IdentifyFrontVector(frontvector_eq, dist_stat,...
                                                               eq_stat, xq_stat, yq_stat,...
                                                               eq_dyn,  xq_dyn,  yq_dyn,...
                                                               xincr, yincr, GrainFull,...
                                                               localfrontvector_eq, dist_dyn0, eq_dyn0);

end