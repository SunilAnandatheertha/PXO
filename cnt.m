close all
clear all
set(0,'DefaultFigureWindowStyle','docked')
hold on
acc = 0.1412; % nm

xn = 50;
yn = 2;

xi(1,:) = 0:acc*cosd(30):acc*cosd(30)*xn;
theta = 0:180:180*(numel(xi(1,:))-1);
yi(1,:) = (0.5*acc*sind(30))*cosd(theta+180);
yi(1,:) = yi(1,:) + acc*sind(30);

figure_handle = figure(1);
set(figure_handle,'Renderer','OpenGL')

xi(2,:) = xi(1,:);
yi(2,:) = (0.5*acc*sind(30))*cosd(theta+180*2);
yi(2,:) = yi(2,:) + acc*sind(30);
yi(2,:) = yi(2,:) + acc*sind(30) + acc;

xf = []; yf = [];
for copies = 1:yn
    xf = [xf; xi];
    yincr =  copies*2*(acc*sind(30)+acc);
    yf = [yf; yi + yincr];
end
yf = yf - min(min(yf));
zf = zeros(size(xf));
%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%
% plot3(xf,yf,zf,'r.')

%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%
xf1 = []; yf1 = []; zf1 = [];
for countr = 1:size(xf,1)
    xf1 = [xf1; xf(countr,:)];
    yf1 = [yf1; yf(countr,:)];
    zf1 = [zf1; zf(countr,:)];
end

count = 0;
numbering = zeros(size(xf1));
for count1 = 1:size(xf1,1)
    for count2 = 1:size(xf1,2)
        count = count+1;
        numbering(count1,count2) = count;
%         plot3(xf1(count1,count2),yf1(count1,count2),zf1(count1,count2),'ks','MarkerFaceColor','k');
%         pause(0.001);
    end
end
% plot3(xf1(numbering),yf1(numbering),zf1(numbering),'ro')

% for count = 1:numel(xf)
%     text(xf(count),yf(count),zf(count),num2str(numbering(count)),'BackGroundColor',[1 1 1])
% end

sphereradiusmax = 1.1*acc;
sphereradiusmin = 0.9*acc;

% for count1 = 1:size(xf1,1)
%     for count2 = 1:size(xf1,2)
%         atom = (count1-1)*size(xf1,2)+count2;
%         dist = sqrt((xf1(count1,count2)-xf1).^2 + (yf1(count1,count2)-yf1).^2 + (zf1(count1,count2)-zf1).^2);
%         [ele] = find(dist<sphereradiusmax & dist>sphereradiusmin);
%         count = count+1;
%         if numel(ele)==1
%             elements(count,:) = [ele(1) 0 0];
%         elseif numel(ele)==2
%             elements(count,:) = [ele(1) ele(2) 0];
%         elseif numel(ele)==3
%             elements(count,:) = [ele(1) ele(2) ele(3)];
%         end
%     end
% %     ccbonds = [ccbonds;elements];
% end
count = 0;
ccbonds = [];
for count1 = 1:size(xf1,1)
    for count2 = 1:size(xf1,2)
        count = count+1;
        atom(count) = (count1-1)*size(xf1,2)+count2;
        dist = sqrt((xf1(count1,count2)-xf1).^2 + (yf1(count1,count2)-yf1).^2 + (zf1(count1,count2)-zf1).^2);
        [ele] = find(dist<sphereradiusmax & dist>sphereradiusmin);
        if numel(ele) == 0
            dummmy = 1; clear dummy
        elseif numel(ele) == 1
            elements(count,:) = [atom(count) numbering(ele(1)) 0 0];
        elseif numel(ele) == 2
            elements(count,:) = [atom(count) numbering(ele(1)) numbering(ele(2)) 0];
        elseif numel(ele) == 3
            elements(count,:) = [atom(count) numbering(ele(1)) numbering(ele(2)) numbering(ele(3))];
        end
    end
%     ccbonds = [ccbonds;elements];
end
% plot()
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
circum = max(max(xf));
radius = circum/2/pi;
axisx = [0 0]; axisy = [min(min(yf)) max(max(yf))]; axisz = [radius radius];
plot3(axisx,axisy,axisz,'b','LineWidth',2);
hold on

lengthratios = xf/max(max(xf));
angles = -90+lengthratios*2*180;
xft = radius.*cosd(angles);
yft = yf;
zft = radius+radius.*sind(angles);

hold on
axis tight
% grid on

% renumbering
currentnum = reshape(1:numel(xft),size(xft));
newnum = zeros(size(currentnum));
dum = 1:1:size(xft,2);
for counta = 1:size(xft,1)
   newnum(counta,:) = (counta -1)*size(xft,2) + dum;
end
for count = 1:numel(xft)
    xft1(count) = xft(newnum(count));
    yft1(count) = yft(newnum(count));
    zft1(count) = zft(newnum(count));
end
xft1 = reshape(xft1,size(xft));
yft1 = reshape(yft1,size(yft));
zft1 = reshape(zft1,size(zft));



for count2 = 1:size(xf,1)
    for count1a = 1:size(xf,2)-1
        %     plot3([xf(count2,count1a) xf(count2,count1a+1)],...
%         [yf(count2,count1a) yf(count2,count1a+1)],[zf(count2,count1a) zf(count2,count1a+1)],'r')
        plot3([xft(count2,count1a) xft(count2,count1a+1)],[yft(count2,count1a) yft(count2,count1a+1)],[zft(count2,count1a) zft(count2,count1a+1)],'k','LineWidth',1)
        %       plot3([xft1(count2,count1a) xft1(count2,count1a+1)],...
%         [yft1(count2,count1a) yft1(count2,count1a+1)],[zft1(count2,count1a) zft1(count2,count1a+1)],'k')
    end
end

for count2 = 1:size(xf,1)
    if mod(count2,2)==0
        if count2~=size(xf,1)
            for count1b = 1:2:size(xf,2)
                %             plot3([xf(count2,count1b)  xf(count2+1,count1b)],...
%                 [yf(count2,count1b)  yf(count2+1,count1b)],[zf(count2,count1b)  zf(count2+1,count1b)],'r')
                plot3([xft(count2,count1b)  xft(count2+1,count1b)],[yft(count2,count1b)  yft(count2+1,count1b)],[zft(count2,count1b)  zft(count2+1,count1b)],'k','LineWidth',1)
                %               plot3([xft1(count2,count1b)  xft1(count2+1,count1b)],...
%                 [yft1(count2,count1b)  yft1(count2+1,count1b)],[zft1(count2,count1b)  zft1(count2+1,count1b)],'k')
            end
        end
    else
        for count1b = 2:2:size(xf,2)
            %             plot3([xf(count2,count1b)  xf(count2+1,count1b)],...
%             [yf(count2,count1b)  yf(count2+1,count1b)],[zf(count2,count1b)  zf(count2+1,count1b)],'r')
            plot3([xft(count2,count1b)  xft(count2+1,count1b)],[yft(count2,count1b)  yft(count2+1,count1b)],[zft(count2,count1b)  zft(count2+1,count1b)],'k','LineWidth',1)
            %             plot3([xft1(count2,count1b)  xft1(count2+1,count1b)],...
%             [yft1(count2,count1b)  yft1(count2+1,count1b)],[zft1(count2,count1b)  zft1(count2+1,count1b)],'k')
        end
    end
end
axis equal,axis tight,view(3), xlabel('x-axis'), ylabel('y-axis'), zlabel('z-axis'),box on