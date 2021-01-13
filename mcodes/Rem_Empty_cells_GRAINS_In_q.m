function [GRAINS_In_q] = Rem_Empty_cells_GRAINS_In_q(GRAINS_In_q)
% Once all grains in q have been identified, remove empty cell locations in GRAINS_In_q
empty = [];
for count = 1:size(GRAINS_In_q,2)
    empty = [empty isempty(GRAINS_In_q{1,count})];
end
GRAINS_In_q(empty==1) = [];
end