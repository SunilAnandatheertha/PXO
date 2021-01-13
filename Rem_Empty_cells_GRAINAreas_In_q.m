function [GrainAreas_In_q] = Rem_Empty_cells_GRAINAreas_In_q(GrainAreas_In_q)
% Once all grains in q have been identified, remove empty cell locations in GRAINS_In_q
empty = [];
for count = 1:size(GrainAreas_In_q,2)
    empty = [empty isempty(GrainAreas_In_q{1,count})];
end
GrainAreas_In_q(empty==1) = [];
end