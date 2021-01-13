close all
clear all
set(0,'DefaultFigureWindowStyle','docked')

N = 10;

radius = 5;
angle(1) = 0;

noofcnt = 10;
xy = cell(8,noofcnt);
% thetaone = [+00 -45 000 60 00 140];
% thetatwo = [+90 +45 180 90 30 220];

% for aligned CNTs
thetaone = [-36];
thetatwo = [+36];

xmin = -200; xmax = 200;
ymin = -200; ymax = 200;

for cnt = 1:noofcnt
    xy{1,cnt} = zeros(N,2);
    xy{1,cnt}(1,:) = [xmin+(xmax-xmin)*rand ymin+(ymax-ymin)*rand];
    sel = floor(1+(numel(thetaone)+1-1)*rand);
    theta1 = thetaone(sel);
    theta2 = thetatwo(sel);
    xy{2,cnt} = [theta1;theta2];
    for count = 2:N
        mult = rand(1);
        angle(count) = 0.9*rand*angle(count-1) + theta1 +(theta2-theta1)*mult;
        xy{1,cnt}(count,:) = xy{1,cnt}(count-1,:) + radius*[cosd(angle(count)) sind(angle(count))];
    end
end
%%
for count = 1:size(xy,2)
    plot(xy{1,count}(:,1),smooth(xy{1,count}(:,2),10),'-k.');hold on
end
%% Rotate individual CNTs about their origins
rotateallaboutsameangle = 0;
if rotateallaboutsameangle==1
    rotang = rand*36;
end
for count = 1:size(xy,2)
    xy{3,count} = 0; % just a seperator
    xy{4,count} = xy{1,count}(1,:); % origin about which rotation is carried out
    % next line establishes the distance of every point in this cnt from the above origin
    xy{5,count} = sqrt( ( ones(size(xy{1,1},1),1).*xy{1,count}(1,1) - xy{1,count}(:,1)).^2 + ( ones(size(xy{1,1},1),1).*xy{1,count}(1,2) - xy{1,count}(:,2)).^2 );
    % start of rotation algorithm
    if rotateallaboutsameangle==0
        rotang = rand*360;
    end
    origin = xy{1,count}(1,:);
    rot = [cosd(rotang) -sind(rotang);
           sind(rotang)  cosd(rotang)];
    origin = xy{1,count}(1,:);
    xycnt_ori = xy{1,count} - [xy{1,count}(1,1)*ones(size(xy{1,count},1),1) xy{1,count}(1,2)*ones(size(xy{1,count},1),1)];
    for count1 = 2:size(xycnt_ori,1)
        xycnt_ori_trans(count1,:) = rot*xycnt_ori(count1,:)';
    end
    xy_rot = xycnt_ori_trans + [xy{1,count}(1,1)*ones(size(xy{1,count},1),1) xy{1,count}(1,2)*ones(size(xy{1,count},1),1)];
    % end of rotation algorithm
    xy{6,count} = xy_rot;
end

%% plot rotated CNTs
for count = 1:size(xy,2)
    plot(xy{6,count}(:,1),smooth(xy{6,count}(:,2),10),'-b.');
end
%%
axis equal, axis tight
axis([xmin xmax ymin ymax])
hold on, box on