function [c_new, x_new, Terminate, Retain] = CalculateReducedVoronoi(x, v, c)
Terminate = zeros(length(c), 1);
counti = 1;
for i = 1:length(c)
    if sum(v(c{i}(1:numel(c{i})),1)'<min(min(x(:,1))))~=0
        Terminate(counti) = i; counti = counti+1;
    elseif sum(v(c{i}(1:numel(c{i})),1)'>max(max(x(:,1))))~=0
        Terminate(counti) = i; counti = counti+1;
    elseif sum(v(c{i}(1:numel(c{i})),2)'<min(min(x(:,2))))~=0
        Terminate(counti) = i; counti = counti+1;
    elseif sum(v(c{i}(1:numel(c{i})),2)'>max(max(x(:,2))))~=0
        Terminate(counti) = i; counti = counti+1;
    else
    end
end
Terminate(Terminate==0)=[];
Retain = setdiff(1:1:numel(c),Terminate);
c_new = c(Retain);
x_new = x(Retain,:);
end