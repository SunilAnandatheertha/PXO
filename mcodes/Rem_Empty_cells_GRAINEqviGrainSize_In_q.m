function [GrainEqGrainSize_q] = Rem_Empty_cells_GRAINEqviGrainSize_In_q(GrainEqGrainSize_q)
% Once all grains in q have been identified, remove empty cell locations in GRAINS_In_q
empty = [];
for count = 1:size(GrainEqGrainSize_q,2)
    empty = [empty isempty(GrainEqGrainSize_q{1,count})];
end
GrainEqGrainSize_q(empty==1) = [];
end