function [GrainArea] = CalculateGrainArea(c_new, v)

GrainArea = zeros(size(c_new));
for count = 1:numel(c_new)
    GrainArea(count) = polyarea(v(c_new{count,1},1), v(c_new{count,1},2));
end

end