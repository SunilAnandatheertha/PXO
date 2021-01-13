numoftests = 10000;
tic
N = 10000;
plotme  = 1;
for count = 1:numoftests
    xypnt   = 10*rand(N,2);
    coc     = 10*rand(3,1);
    [INpnt] = pointsincircle(xypnt, coc);
    if plotme==0
        if count == 1
            p1 = plot(xypnt(:,1),xypnt(:,2),'c.');
        end
        hold on
        p2 = plot(xypnt(INpnt,1),xypnt(INpnt,2),'k.');
        axis([0 10 0 10]), axis square
        pause(0.1); delete(p2)
    end
end
toc
% NOTE: use plotme=0, to kow a better estimate of time elapsed