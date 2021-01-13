function [cntxythetainfo] = mcnt2d(latpar,icntinfo)
% THIS FUCTION GENERATES RAW NON-LATTICE CO-ORDINATE DATA FOR CARBON
% NANOTUBES. CO-ORDINATE DATA AND ANGLE VALUES 
xmin                    = latpar{1}{1};
xmax                    = latpar{1}{2};
ymin                    = latpar{1}{3};
ymax                    = latpar{1}{4};
xincr                   = latpar{1}{5};
yincr                   = latpar{1}{6};
noofcnt                 = icntinfo{1}{2};
NpCNT                   = icntinfo{1}{3};
genradiusfactor         = icntinfo{1}{4};
cntinsidefactor         = icntinfo{1}{5};
startingangle           = icntinfo{1}{7};
thetaone                = icntinfo{1}{8};
thetatwo                = icntinfo{1}{9};
ROTATEiCNTs             = icntinfo{1}{11};
rotateallaboutsameangle = icntinfo{1}{12};
icntrotang              = icntinfo{1}{13};
cntxythetainfo          = cell(8,noofcnt); % cell to store CNT geometry values
radius                  = genradiusfactor*0.5*sqrt(xincr^2+yincr^2); % distance between points on the CNT
angle(1)                = startingangle; % starting angle

for cnt = 1:noofcnt
    fprintf('Generating CNT number %d \n',cnt)
    cntxythetainfo{1,cnt} = zeros(NpCNT,2);
    cntxythetainfo{1,cnt}(1,:) = cntinsidefactor*[floor(xmin+(xmax-xmin)*rand) floor(ymin+(ymax-ymin)*rand)];
    sel = floor(1+(numel(thetaone)+1-1)*rand);
    theta1 = thetaone(sel);
    theta2 = thetatwo(sel);
    cntxythetainfo{2,cnt} = [theta1;theta2];
    for count = 2:NpCNT
        mult = rand(1);
        angle(count) = 0.9*rand*angle(count-1) + theta1 +(theta2-theta1)*mult;
        cntxythetainfo{1,cnt}(count,:) = cntxythetainfo{1,cnt}(count-1,:) + radius*[cosd(angle(count)) sind(angle(count))];
    end
end
%% Rotate individual CNTs about their origins

% <---- TO BE INCLUDED IN icntinfo{:}
% ABOVE VALUE DEFAULT IS 1. CHANGE TO 0 IF ALIGNED CNTs ARE NEEDED

if ROTATEiCNTs == 1
    rotateallaboutsameangle = 0;
    if rotateallaboutsameangle==1
        rotang = 45; % <---- INCLUDE THIS IN "icntinfo{:,:}"
    end
    for count = 1:size(cntxythetainfo,2)
        cntxythetainfo{3,count} = 0; % just a seperator
        cntxythetainfo{4,count} = cntxythetainfo{1,count}(1,:); % origin about which rotation is carried out
        % next line establishes the distance of every point in this cnt from the above origin
        cntxythetainfo{5,count} = sqrt(( ones(size(cntxythetainfo{1,1},1),1).*cntxythetainfo{1,count}(1,1) - cntxythetainfo{1,count}(:,1)).^2 +...
                                       ( ones(size(cntxythetainfo{1,1},1),1).*cntxythetainfo{1,count}(1,2) - cntxythetainfo{1,count}(:,2)).^2);
        % start of rotation algorithm
        if rotateallaboutsameangle==0
            rotang = rand*360;
        end
        origin = cntxythetainfo{1,count}(1,:);
        rot = [cosd(rotang) -sind(rotang); sind(rotang)  cosd(rotang)];
        origin = cntxythetainfo{1,count}(1,:);
        xycnt_ori = cntxythetainfo{1,count} - [cntxythetainfo{1,count}(1,1)*ones(size(cntxythetainfo{1,count},1),1) cntxythetainfo{1,count}(1,2)*ones(size(cntxythetainfo{1,count},1),1)];
        for count1 = 2:size(xycnt_ori,1)
            xycnt_ori_trans(count1,:) = rot*xycnt_ori(count1,:)';
        end
        xy_rot = xycnt_ori_trans + [cntxythetainfo{1,count}(1,1)*ones(size(cntxythetainfo{1,count},1),1) cntxythetainfo{1,count}(1,2)*ones(size(cntxythetainfo{1,count},1),1)];
        % end of rotation algorithm
        cntxythetainfo{6,count} = xy_rot;
    end
else
    for count = 1:size(cntxythetainfo,2)
        cntxythetainfo{6,count} = cntxythetainfo{1,count};
    end
end
end