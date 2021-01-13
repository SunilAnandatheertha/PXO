function [x, v, c] = create_voronoi(data, dim)

x = data;
if dim == 2
    [v,c] = voronoin(x);
elseif dim == 3
    [v,c] = voronoin(x, {'Qxx'});
end
end

% Older version
% function [x, v, c] = create_voronoi(n, dim)
% x = 200*rand(n,dim);
% if dim == 2
%     [v,c] = voronoin(x);
% elseif dim == 3
%     [v,c] = voronoin(x, {'Qxx'});
% end
% end