a = [10 2 3;
     1 12 45;
     1 21 6;
     3 0 43;
     4 5 987];
[o1, o2] = sort(a(:,1),1,'ascend');
% [a o1 o2]

aa = zeros(size(a));
aa(:,1) = o1;
for count = 1:size(a,1)
    aa(count,2:size(a,2)) = a(o2(count,1),2:size(a,2));
end