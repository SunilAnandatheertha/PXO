

% Version 2.00 started on 28.01.2014
tic
close all
clear all
set(0, 'DefaultFigureWindowStyle', 'docked')

xincr = 1;
yincr = 1;


xmax = 100;
ymax = 100;
[X, Y] = meshgrid(1:xincr:xmax,1:yincr:ymax);

if numel(X) < (50^2+1)
    Partitions = 1;
elseif numel(X) >= (50^2+1) && numel(X) < (100^2+1)
    Partitions = 2; % either a V or a H
elseif numel(X) >= (100^2+1) && numel(X) < (200^2+1)
    Partitions = 4; % both
elseif numel(X) >= (200^2+1) && numel(X) < (300^2+1)
    Partitions = 6;
end
PartitionType = 'H'; % H: horizontal. other options: 'V': vertical, 'HV'; both H and V




[x,y] = meshgrid(1:xincr:25,1:yincr:25);
% plot(x,y,'k.');axis square;axis tight; hold on

Q = 10;
sm = floor(1+Q*rand(size(x,1),size(x,2)));


% stateim = dlmread(strcat(pwd,'\results','\datafiles','\statematrices','\s',num2str(50),'mcs1','.txt'));
% sm = stateim;
dist = 0.9*sqrt(xincr^2+yincr^2);

qgrains = cell(1,Q);

for q = 1:Q
    qstate = find(sm==q);
    color = [rand rand rand];
    for countcrazy = 1:1E5 % JUST ANY REALLY BIG NUMBER like this would do!!
        if countcrazy == 1
            sel = qstate(1);
            e = [];
            xq10 = x(qstate); 
            yq10 = y(qstate);
            szxq10 = size(xq10);
            szyq10 = size(yq10);
            GrainsInThisq = [];
            for count1 = 1:numel(qstate)
                if count1 == 1
                    sel = qstate(1);
                end
                for count2 = 1:numel(sel)
                    e = [e; qstate(sqrt( ( repmat(x(sel(count2)),szxq10) - xq10).^2+( repmat(y(sel(count2)),szyq10) - yq10).^2 ) < dist)];
                end
                e = unique(e);
                sel = [sel; e];
                sel = unique(sel);
                %plot(x(sel), y(sel),'ks','MarkerFaceColor',color,'MarkerSize',10);
            end
            GrainsInThisq = [GrainsInThisq; sel; -1]; % NOTE : here, -1 IS A MARKER FOR THE END OF A GRAIN
            Common = [];
            for count = 1:numel(sel)
                Common = [Common;find(qstate==repmat(sel(count),size(qstate)))];
            end
            remaining = qstate;
            remaining(Common) = [];
%             numel(remaining)
        else
            sel = remaining(1);
            e = [];
            xq10 = x(remaining);
            yq10 = y(remaining);
            szxq10 = size(xq10);
            szyq10 = size(yq10);
            for count1 = 1:numel(remaining)
                if count1 == 1
                    sel = remaining(1);
                end
                for count2 = 1:numel(sel)
                    e = [e; remaining(sqrt( (repmat(x(sel(count2)),szxq10) - xq10).^2 + (repmat(y(sel(count2)),szyq10) - yq10).^2 ) < dist)];
                end
                e = unique(e);
                sel = [sel; e];
                sel = unique(sel);
                %plot(x(e), y(e),'ks','MarkerFaceColor',color,'MarkerSize',10);
            end
            GrainsInThisq = [GrainsInThisq; sel; -1]; % NOTE : -1 IS A MARKER FOR THE END OF A GRAIN
            Common = [];
            for count = 1:numel(sel)
                Common = [Common;find(remaining==repmat(sel(count),size(remaining)))];
            end
            remaining(Common) = [];
            if numel(remaining) == 0
                break
            end
        end
    end
    qgrains{1,q} = GrainsInThisq;
end

temp = 0;
for count = 1:numel(qgrains)
    temp = temp + numel(qgrains{1,count});
end

GRAINSe = -2; % Start with the separator value

for count = 1:numel(qgrains)
    GRAINSe = [GRAINSe; qgrains{1,count}(:); -2];
end

% No Of Grains in the present Monte-Carlo Step: NOG (see next line)
NOG = numel(find(GRAINSe == -1)) - numel(find(GRAINSe == -2));

GRAINSq = GRAINSe; % intitialize
GRAINSx = GRAINSe; % intitialize
GRAINSy = GRAINSe; % intitialize
for count = 1:numel(GRAINSe)
    if GRAINSe(count)~=-1 && GRAINSe(count)~=-2
        GRAINSq(count) = sm(GRAINSe(count));
        GRAINSx(count) = x(GRAINSe(count));
        GRAINSy(count) = y(GRAINSe(count));
    end
end

% Estimate individual grain sizes
GrainSizes = cell(1,Q);
agsq = zeros(Q,0); % Average Grain Size of all grains belongoing ro qth state
for count = 1:Q
    if ((numel(qgrains{1,count})) - (numel(find(qgrains{1,count}(:)==-1)))) ~= 0
        iomo = find(qgrains{1,count}(:)==-1); % Indices Of Minus Ones
        qGrainSizes = [];% Sizes of all grains bel to state q
        flag = 0;
        for count2 = 1:numel(iomo)
            if count2 == 1
                qGrainSizes(count2) = numel(find(qgrains{1,count}(1:iomo(count2))~=-1));
            else
                qGrainSizes(count2) = numel(find(qgrains{1,count}(iomo(count2-1):iomo(count2))~=-1));
            end
        end
    else
        qGrainSizes = 0;
        agsq(count,1) = 0;
    end
    GrainSizes{1,count} = qGrainSizes';
    agsq(count,1) = sum(qGrainSizes)/numel(qGrainSizes);
end

avgqNonZeros = find(agsq~=0);
AGS = sum(agsq(avgqNonZeros))/numel(avgqNonZeros);

fprintf('There are a total of %d grains and the AGS is %4.4f\n',...
    NOG, AGS)
toc
%-----------------------------------------------------------------
hold on
for count = 1:numel(qgrains)
    plot(x(qgrains{1,count}( qgrains{1,count}(:)~=-1 )),...
         y(qgrains{1,count}( qgrains{1,count}(:)~=-1 )),'ks','MarkerFaceColor',[rand rand rand])
end
axis equal
axis tight