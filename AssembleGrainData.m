function [Grains] = AssembleGrainData(x_new, v, c_new, GrainArea, GrainSize, data, Terminate, Retain)

Grains = cell(numel(c_new), 15);
for count = 1:numel(c_new)
        Grains{count, 1}  = numel(c_new{count,1}); % No. of vertices in this grain
        Grains{count, 2}  = x_new(:,1);
        Grains{count, 3}  = x_new(:,2);
        Grains{count, 4}  = zeros(size(Grains{count, 3}));
        Grains{count, 5}  = c_new{count,1}'; % Vertex numbers in order
        Grains{count, 6}  = v(c_new{count}, 1); % X-coordinates of vertices
        Grains{count, 7}  = v(c_new{count}, 2); % Y-coordinates of vertices
        Grains{count, 8}  = zeros(size(Grains{count, 4})); % Z-coordinates of vertices (This line is for 2D)
        Grains{count, 9}  = GrainArea; % Areas
        Grains{count, 10} = zeros(size(Grains{count, 9})); % Volumes
        Grains{count, 11} = 0;
        Grains{count, 12} = GrainSize;
        Grains{count, 13} = 0;
        Grains{count, 14} = 0;
        Grains{count, 15} = 0;
end
% 1.  No. of vertices
% 2.  Centroid x-coordinate
% 3.  Centroid y-coordinate
% 4.  Centroid z-coordinate
% 5.  Vertex numbers in order
% 6.  X-coordinates of vertices
% 7.  Y-coordinates of vertices
% 8.  Z-coordinates of vertices
% 9.  Grain area
% 10. Grain volume
% 11. Aspect ratio
% 12. Grain Size
% 13. Euler Angle - 1
% 14. Euler Angle - 2
% 15. Euler Angle - 3
end