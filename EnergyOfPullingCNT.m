clear; close all; set(0,'DefaultFigureWindowStyle','docked')
% set(figure,'color',[0 1 1])   % camproj('perspective')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 %%%%%%% Define Nanotube properties  %%%%%%%
n=15; m=15;
acc=0.1412;   r1=sqrt(3) * acc * sqrt(n^2+m^2+n*m)/pi/2;
% Define equivalent cylinder properties
relativelead1 = 0;   alp1 = relativelead1 + 360*(0:0.05:1.00); alp1(numel(alp1))=[];
x1 = r1*cosd(alp1);      y1 = r1*sind(alp1);
z1min = -2.50;
z1max = 2.50;
z1 = (z1min:0.25:z1max)'; 
x1=repmat(x1,numel(z1),1);      y1=repmat(y1,numel(z1),1);      z1=repmat(z1,1,size(x1,2));
% plot3(x1(:,1:size(x1,2)),y1(:,1:size(x1,2)),z1(:,1:size(x1,2)),'r')
% plot3(x1(2,:),y1(2,:),z1(2,:),'b')
%%%%%%% FOR THE MATRIX %%%%%%%
relativelead2 = 0.00;    alp2 = relativelead2 + 360*(0:0.05:1.00); alp2(numel(alp2))=[];
r2 = r1 + 0.34;    x2 = r2*cosd(alp2);     y2 = r2*sind(alp2);
z2min = -2.00;
z2max =  2.00;
z2 = (z2min:0.25:z2max)';
x2 = repmat(x2,numel(z2),1);      y2 = repmat(y2,numel(z2),1);      z2 = repmat(z2,1,size(x2,2));
r3 = (r2*(1:0.25:2))';
x3 = r3*cosd(alp2);      y3 = r3*sind(alp2);
z3a = min(z2(:,1))*ones(size(x3));      z3b = max(z2(:,1))*ones(size(x3));
% plot3(x1,y1,z1,'k.','Markersize',20);
% surface(x1,y1,z1);     box on;   hold on
% plot3(x2,y2,z2,'k.','Markersize',20);
% surface(x2,y2,z2);     surface(x3,y3,z3a);     surface(x3,y3,z3b)
% axis equal;    view(80,20)
%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%
fig=figure('units','pixels','name', 'CNT_Pullout', 'renderer', 'opengl', 'visible','on');


box on;   hold on
zincr=-5.00:0.1:5.00;
for count=1:numel(zincr)
    z1new=z1+zincr(count);
    mesh(x1,y1,z1new);     hold on;
    plot3(x1,y1,z1new,'b.','Markersize',12.5);
    mesh(x2,y2,z2);
    plot3(x2,y2,z2,'k.','Markersize',12.5);
    mesh(x3,y3,z3a);   %   plot3(x3,y3,z3a,'k.','Markersize',12.5);
    mesh(x3,y3,z3b);    %  plot3(x3,y3,z3b,'k.','Markersize',12.5);    %     axis equal;
    acount = (count/numel(zincr))*100;
    method = 1;
    for count1=1:numel(x1)
        acount1 = acount + (count1/numel(x1)/numel(zincr))*100;
        if method == 1
            for count2=1:numel(x2)
                if mod(count2,floor(numel(x2)/3))==0
                    acount2 = acount1 + (count2/numel(x2)/numel(x1)/numel(zincr))*100;
                    disp(acount2)
                end
                dist=sqrt((x1(count1)-x2(count2))^2 + (y1(count1)-y2(count2))^2 + (z1new(count1)-z2(count2))^2  );
                if dist>0.94*(0.34) && dist<1.06*(0.34)
                    plot3([x1(count1) x2(count2)],[y1(count1) y2(count2)],[z1new(count1) z2(count2)],'k','LineWidth',3);
                    hold on; axis([-3 3 -3 3 -4 4]);view(88,24);hidden off;box on;axis square
                    pause(0.005)
                end
            end
        end
        if method == 2
            dist = sqrt(   (x1(count1)-x2).^2   +   (y1(count1)-y2).^2   +   (z1new(count1)-z2).^2  )   ;
            ind = find(dist>0.30 & dist<0.38);
            plot3( [x1(count1)*ones(numel(ind),1) x2(ind)],...
                       [y1(count1)*ones(numel(ind),1) y2(ind)],...
                       [z1new(count1)*ones(numel(ind),1) z2(ind)],'k','LineWidth',3)
            hold on; axis([-3 3 -3 3 -4 4]);view(90,0);hidden off;box on;axis square % pause(0.001)
        end
    end
    axis equal
    axis([-3 3 -3 3 -4 4]);     
    hidden off;    box on;    hold off;    pause(0.001)
    axis square
    disp('printing figure to image file')
    print('-djpeg100',num2str(count))
end