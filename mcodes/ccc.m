% zener cnt generation code: development
%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%
clear all
%% DEFINE IMPORTANT PARAMETERS
amin = -30; aincr = 0.33; amax = 30;
bmin = -30; bincr = 0.33;bmax = 30;

r = 0.5*sqrt(aincr^2+bincr^2);
theta = [-45 -90 10 20 30 45 90 135 180 225 250 360];
length = 40;

thicknessfactor = 2;
%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%
%% FIGURE SETTINGS
close all;set(0,'DefaultFigureWindowStyle','docked')
figure(1);hold on;grid on, hold on, axis square
axis equal
title('Carbon Nanotube : For MC simulation')
%%
seedfactor = 1.1; % default value shuould be 1.00::: greater the "length/r" greater the seedfactor
for count = 1:floor(length/r)
    if count == 1
        xxx(count) = [rand*seedfactor*amin  +  rand*seedfactor*amax]; 
        yyy(count) = [rand*seedfactor*bmin  +  rand*seedfactor*bmax];
    else
        xxx(count) = xxx(count-1)+r*cosd(rand*theta(floor(1+numel(theta)*rand)));
        yyy(count) = yyy(count-1)-r*sind(rand*theta(floor(1+numel(theta)*rand)));
    end
end

xxmin = min(xxx); xxmax = max(xxx);
yymin = min(yyy); yymax = max(yyy);

 a = amin:aincr:amax;
 b = bmin:bincr:bmax;
[xx,yy] = meshgrid(a,b);
ele1 = find(xx>=xxmin-r & xx<=xxmax+r);    xxa = xx(ele1);    yya = yy(ele1);
% plot(xxa,yya,'yo')
ele2 = find(yya>=yymin-r & yya<=yymax+r);
% plot(xxa(ele2),yya(ele2),'ko')

cntele1 = [];
for count1 = ele2(1):ele2(numel(ele2))
    for count2 = 1:numel(xxx)
        dist = sqrt((xxa(count1)-xxx(count2))^2 + (yya(count1)-yyy(count2))^2);
        if dist<=thicknessfactor*sqrt(aincr^2+bincr^2)
            cntele1 = [cntele1; count1];
        end
    end
end

plot(xxa(cntele1),yya(cntele1),'k.','MarkerFaceColor','k')

cntele = cntele1;
clear cntele1
cntele2 = cntele;
for count0=1:100
    cntele = cntele2;
    for count = 1:numel(cntele)-1
        if count == numel(cntele)
            break
        end
        if count<numel(cntele)
            if cntele(count)==cntele(count+1)
                cntele(count)=[];
            end
        end
    end
%     cntele2 = cntele;
end

% axis equal
xcnt = xxa(cntele); ycnt = yya(cntele);
plot(xcnt,ycnt,'k.','MarkerFaceColor','k')
plot([xxx(1:numel(xxx)-1)' xxx(2:numel(xxx))'],[yyy(1:numel(yyy)-1)' yyy(2:numel(yyy))'],'y','LineWidth',3)
axis([amin amax bmin bmax])

print('-djpeg100',strcat(pwd,'\results\plots\CNT','\','CNT','.jpeg'))