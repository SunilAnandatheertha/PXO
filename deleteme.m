function deleteme(varargin)
[x,y] = meshgrid(1:10,1:10);
plot(x,y,'k.');axis square;axis tight; hold on

Q = 32;
sm = floor(Q*rand(10,10)+1);

sm(3:6,3:6) = repmat(10,4,4);


for i = 2:size(x,1)-1
    for j = 2:size(x,2)-1
        fh1 = plot(x(i,j), y(i,j), 'bs');
        fh2 = text(x(i,j)+0.1, y(i,j)+0.1,num2str(sm(i,j)),'FontSize',8,'EdgeColor','k');
        pause(0.1)
        delete(fh1)
    end
end

q10 = find(sm==10);

for count = 1:numel(q10)
    fh2 = plot(x(q10(count)), y(q10(count)),'ro','MarkerFaceColor','r');
    pause(0.2)
end


qgrains = cell(1,Q);
for q = 10
    q10 = find(sm==10);
    for gc = 1:10000 % grain coiunt
        
        forstop = 0;
        whilestop = 0;
        e_q10 = []; % initialize
        while whilestop == 1
            [e_q10] = identify(q10, e_q10);
        end
        % if total number of elements in the grains identified are equak to numel(q10), then
        % set forstop = 1, bcz, all grains blonging to q10 would have been found
        if forstop == 1
            break
        end
        
    end
end

end

function [e_q10] = identify(q10, e_q10)

for count = 1:numel(q10)
    if numel(eq10) == 0
        
    else
        
    end
end
end