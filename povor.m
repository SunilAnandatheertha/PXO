function [vx, vy] = povor(x, plotvororiginal)
% This function plots the originally created voronoi tessellation
if plotvororiginal~=0
    plot(x(:,1), x(:,2),'k.'); hold on
    [vx,vy] = voronoi(x(:,1),x(:,2));
    plot(vx,vy,'k'); axis tight
else
    vx = 0;
    vy = 0;
end

end