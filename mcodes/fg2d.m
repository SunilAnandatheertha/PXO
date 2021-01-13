function [grains] = fg2d(matrix,x,y,xincr,yincr)

elem = find(matrix~=0);

plot(x(elem),y(elem),'c.'), axis equal, axis tight, hold on

elemtemp = elem;

rif = 1; % radius increment factor
mrf = sqrt((max(max(x)))^2 + (max(max(y)))^2); % maximum radius factor -- length of lattice diagonal
for count1 = 1:100*numel(elem)
    cre = elem(floor(1+rand*numel(elemtemp))); % choose random element
    for count2 = sqrt(xincr^2 + yincr^2):rif:mrf
        A = 