function [eq, xq, yq,...
          GRAINS_In_q, GrainBoundaries_In_q,...
          GrainAreas_In_q, GrainEqGrainSize_q] = Initialize_eq_xyq_GRAINS_In_q(q, s,...
                                                                               x, y, guessnoofgrains)

eq = find(s==q);
xq = x(eq);
yq = y(eq);

GRAINS_In_q          = cell(1,guessnoofgrains); 
GrainBoundaries_In_q = cell(1,guessnoofgrains);
GrainAreas_In_q      = cell(1,guessnoofgrains);
GrainEqGrainSize_q   = cell(1,guessnoofgrains);

end