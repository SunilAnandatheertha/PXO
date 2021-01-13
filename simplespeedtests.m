clear all
n = 100000;
d(1) = 0;
c{1} = 0;

tic
for i = 1:n
    d(1) = i;
end
toc

tic
for i = 1:n
    c{1} = i;
end
toc
