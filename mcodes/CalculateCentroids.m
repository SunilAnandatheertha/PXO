function [xyzcent] = CalculateCentroids(c_new, v, GrainArea)

xyzcent = zeros(numel(c_new), 3);
K = 1./(6*GrainArea);
for i = 1:numel(c_new)
    cx = zeros(numel(c_new{i})-1, 1);
    cy = cx;
    cz = cx;
    for j = 1:numel(c_new{i})-1
        % (xj + xj+1)(xj*yj+1 - xj+1*yj)
        % (yj + yj+1)(xj*yj+1 - xj+1*yj)
        Term1a = v(c_new{i,1}(j),1) + v(c_new{i,1}(j+1),1);
        Term1b = v(c_new{i,1}(j),2) + v(c_new{i,1}(j+1),2);
        Term2  = v(c_new{i,1}(j),1)*v(c_new{i,1}(j+1),2) - v(c_new{i,1}(j+1),1)*v(c_new{i,1}(j),2);
        cx(j) = Term1a*Term2;
        cy(j) = Term1b*Term2;
    end
    xyzcent(i, :) = [sum(cx) sum(cy) sum(cz)];
end
xyzcent = K*xyzcent;
end