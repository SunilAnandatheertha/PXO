function [grain, eq_dyn, xq_dyn, yq_dyn,...
                 eq_dyn0, xq_dyn0, yq_dyn0] = Identify_one_Grain_In_q(ng, eq_stat, xq_stat,...
                                                                     yq_stat, eq_dyn, xq_dyn,...
                                                                     yq_dyn, xincr, yincr,...
                                                                     Type_of_SP, GrainFull,...
                                                                     eq_dyn0, xq_dyn0, yq_dyn0)
% sps       : Iterator variable #1
% Type_of_SP: Flag variable #1
% ITERATOR 1 ====sps==== iterator for front points
%          sps stands for source point set. It is nothing but the set number
%          of the front. 
%          It could be a single number in eq
%          OR it could be a bunch of numbers in eq
%          For former case, it is for the first seed point for one grain
%          For latter case, it is for the evolving front of the current grain
% FLAG 1  ====Type_of_SP====    0, 1, 2
%           SP stands for Source Point from where the front can grow
%           Depending on how it selected, it can be 0, 1 or 2
%               0: SP is the first in LS(q). It is chosen randomly
%               1: When the front is growing, each front element is a SP
%               2. When a grain has been identified in LS(q), the next SP is chosen randomly in LS(q)
grain   = [];
if ng==1
    eq_dyn0 = eq_dyn;
    xq_dyn0 = xq_dyn;
    yq_dyn0 = yq_dyn;
end

% for sps = 1:1E3
for sps = 1:1E3
    
    if GrainFull == 1; break; end
%     disp('i am here')
    if sps == 1; frontvector_eq = 0; end % Just an initialization
    [frontvector_eq, localfrontvector_eq,...
     Type_of_SP, GrainFull, eq_dyn0, xq_dyn0,yq_dyn0] = ChooseSourcePointsForFront(eq_stat, eq_dyn, xq_stat,...
                                                                                   yq_stat, xq_dyn, yq_dyn,...
                                                                                   frontvector_eq, Type_of_SP, GrainFull,...
                                                                                   xincr, yincr,...
                                                                                   eq_dyn0, xq_dyn0, yq_dyn0);
    grain = unique([grain; frontvector_eq]);
%     size(grain)
% % % % %     for frontcount = 1:size(localfrontvector_eq,2)
% % % % %         [~, exyind_toremove] = intersect(eq_dyn, localfrontvector_eq{frontcount});
% % % % %         eq_dyn(exyind_toremove)  = [];
% % % % %         xq_dyn(exyind_toremove)  = [];
% % % % %         yq_dyn(exyind_toremove)  = [];
% % % % %     end
% %     [~, bcz_i_missed] = intersect(eq_dyn, grain);
% %     eq_dyn(bcz_i_missed) = [];
% %     xq_dyn(bcz_i_missed) = [];
% %     yq_dyn(bcz_i_missed) = [];
end

end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%