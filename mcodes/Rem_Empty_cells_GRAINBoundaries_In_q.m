function [GrainBoundaries_In_q] = Rem_Empty_cells_GRAINBoundaries_In_q(GrainBoundaries_In_q)
% Once all grains in q have been identified, remove empty cell locations in GRAINS_In_q
empty = [];
for count = 1:size(GrainBoundaries_In_q,2)
    empty = [empty isempty(GrainBoundaries_In_q{1,count})];
end
GrainBoundaries_In_q(empty==1) = [];
end