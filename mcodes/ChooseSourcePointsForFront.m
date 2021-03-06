% function [frontvector_eq, localfrontvector_eq,...
%          Type_of_SP, GrainFull, eq_dyn0, xq_dyn0, yq_dyn0] = ChooseSourcePointsForFront(eq_stat, xq_stat,...
%                                                              yq_stat,...
%                                                              frontvector_eq, Type_of_SP, GrainFull,...
%                                                              xincr, yincr,...
%                                                              eq_dyn0, xq_dyn0, yq_dyn0)
function [frontvector_eq, localfrontvector_eq,...
         Type_of_SP, GrainFull, eq_dyn0, xq_dyn0, yq_dyn0] = ChooseSourcePointsForFront(eq_stat, xq_stat,...
                                                             yq_stat,...
                                                             frontvector_eq, Type_of_SP, GrainFull,...
                                                             xincr, yincr,...
                                                             eq_dyn0, xq_dyn0, yq_dyn0)
%------------------------------------------------------
if Type_of_SP == 1
    %frontvector_eq = frontvector_eq;
    localfrontvector_eq = {frontvector_eq};
end
%------------------------------------------------------
if Type_of_SP == 0
    RE_dyn = randi(numel(eq_dyn0));
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    frontvector_eq      = eq_stat(eq_stat==eq_dyn0(RE_dyn));
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    localfrontvector_eq = {frontvector_eq};
    Type_of_SP = 1;
end
%------------------------------------------------------
% [dist_stat, dist_dyn0, eq_dyn0, xq_dyn0, yq_dyn0] = CalculateDistances(frontvector_eq, localfrontvector_eq, eq_stat,...
%                                                     xq_stat, yq_stat, eq_dyn, eq_dyn0,...
%                                                     xq_dyn, yq_dyn, xq_dyn0, yq_dyn0);
[dist_dyn0, eq_dyn0, xq_dyn0, yq_dyn0] = CalculateDistances(frontvector_eq, localfrontvector_eq, eq_stat,...
                                                             xq_stat, yq_stat, eq_dyn0,...
                                                             xq_dyn0, yq_dyn0);
%------------------------------------------------------
[frontvector_eq, localfrontvector_eq, GrainFull] = IdentifyFrontVector(frontvector_eq,...
                                                                       eq_stat, ...
                                                                       xincr, yincr, GrainFull,...
                                                                       dist_dyn0, eq_dyn0);
%------------------------------------------------------
end