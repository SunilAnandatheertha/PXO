%% development of ea matrix. ea:appended element matrix. 
% when boundary wrap condition is applied to e, we get ea.
% temporarily, 'e' in mcsolver3d is called 'a' and 'ea' mcsolver3d is called 'aa'
a  = zeros(4,3,2);
a(:,:,1) = [1 5 9
            2 6 10
            3 7 11
            4 8 12];
a(:,:,2) = [13 17 21
            14 18 22
            15 19 23
            16 20 24];

aa = zeros(size(a,1)+2,size(a,2)+2,size(a,3)+2);

aa(2:(size(aa,1)-1),2:(size(aa,2)-1),2:(size(aa,3)-1)) = a;
aa(2:(size(aa,1)-1),2:(size(aa,2)-1),1) = a(:,:,size(a,3));
aa(2:(size(aa,1)-1),2:(size(aa,2)-1),size(aa,3)) = a(:,:,1);

aa(1,2:(size(aa,2)-1),2:(size(aa,3)-1)) = a(size(a,1),:,:);
aa(size(aa,1),2:(size(aa,2)-1),2:(size(aa,3)-1)) = a(1,:,:);
aa(2:(size(aa,1)-1),1,2:(size(aa,3)-1)) = a(:,size(a,2),:);
aa(2:(size(aa,1)-1),size(aa,2),2:(size(aa,3)-1)) = a(:,1,:);

aa(1,1,2:(size(aa,3)-1)) = a(size(a,1),size(a,2),:);
aa(size(aa,1),1,2:(size(aa,3)-1)) = a(1,size(a,2),:);
aa(1,size(aa,2),2:(size(aa,3)-1)) = a(size(a,1),1,:);
aa(size(aa,1),size(aa,2),2:(size(aa,3)-1)) = a(1,1,:);

aa(1,2:(size(aa,2)-1),1) = a(size(a,1),:,size(a,3));
aa(size(aa,1),2:(size(aa,2)-1),1) = a(1,:,size(a,3));
aa(2:(size(aa,1)-1),size(aa,2),1) = a(:,1,size(a,3));
aa(2:(size(aa,1)-1),1,1) = a(:,size(a,2),size(a,3));

aa(1,1,1) = a(size(a,1),size(a,2),size(a,3));
aa(size(aa,1),1,1) = a(1,size(a,2),size(a,3));
aa(1,size(aa,2),1) = a(size(a,1),1,size(a,3));
aa(size(aa,1),size(aa,2),1) = a(1,1,size(a,3));

aa(2:(size(aa,1)-1),1,size(aa,3)) = a(:,size(a,2),1);
aa(2:(size(aa,1)-1),size(aa,2),size(aa,3)) = a(:,1,1);
aa(1,2:(size(aa,2)-1),size(aa,3)) = a(size(a,1),:,1);
aa(size(aa,1),2:(size(aa,2)-1),size(aa,3)) = a(1,:,1);

aa(size(aa,1),size(aa,2),size(aa,3)) = a(1,1,1);
aa(1,1,size(aa,3)) = a(size(a,1),size(a,2),1);
aa(1,size(aa,2),size(aa,3)) = a(size(a,1),1,1);
aa(size(aa,1),1,size(aa,3)) = a(1,size(a,2),1);

xarray = 1:size(a,2);
yarray = 1:size(a,1);
zarray = 1:size(a,3);
[x,y,z] = meshgrid(xarray,yarray,zarray);

for count = 1:numel(x)
    text(x(count),y(count),z(count),num2str(count)),hold on
    axis square
    pause(0.25)
end
%%
% lattice site numbers
figure(1)
axis([-50 50 -50 50 -50 50])
xlabel('X')
ylabel('Y')
zlabel('Z')
axis square,box on
for count = 1:numel(x)
    plot3(x(count),y(count),z(count),'r.'),hold on
axis([-50 50 -50 50 -50 50])
xlabel('X')
ylabel('Y')
zlabel('Z')
axis square,box on
    pause(0.002)
end
%%
ea               = zeros(sz1+2,sz2+2,sz3+2);
ea(2:(size(ea,1)-1),2:(size(ea,2)-1),2:(size(ea,3)-1)) = e;
ea(2:(size(ea,1)-1),2:(size(ea,2)-1),1) = e(:,:,size(e,3));
ea(2:(size(ea,1)-1),2:(size(ea,2)-1),size(ea,3)) = e(:,:,1);
ea(1,2:(size(ea,2)-1),2:(size(ea,3)-1)) = e(size(e,1),:,:);
ea(size(ea,1),2:(size(ea,2)-1),2:(size(ea,3)-1)) = e(1,:,:);
ea(2:(size(ea,1)-1),1,2:(size(ea,3)-1)) = e(:,size(e,2),:);
ea(2:(size(ea,1)-1),size(ea,2),2:(size(ea,3)-1)) = e(:,1,:);
ea(1,1,2:(size(ea,3)-1)) = e(size(e,1),size(e,2),:);
ea(size(ea,1),1,2:(size(ea,3)-1)) = e(1,size(e,2),:);
ea(1,size(ea,2),2:(size(ea,3)-1)) = e(size(e,1),1,:);
ea(size(ea,1),size(ea,2),2:(size(ea,3)-1)) = e(1,1,:);
ea(1,2:(size(ea,2)-1),1) = e(size(e,1),:,size(e,3));
ea(size(ea,1),2:(size(ea,2)-1),1) = e(1,:,size(e,3));
ea(2:(size(ea,1)-1),size(ea,2),1) = e(:,1,size(e,3));
ea(2:(size(ea,1)-1),1,1) = e(:,size(e,2),size(e,3));
ea(1,1,1) = e(size(e,1),size(e,2),size(e,3));
ea(size(ea,1),1,1) = e(1,size(e,2),size(e,3));
ea(1,size(ea,2),1) = e(size(e,1),1,size(e,3));
ea(size(ea,1),size(ea,2),1) = e(1,1,size(e,3));
ea(2:(size(ea,1)-1),1,size(ea,3)) = e(:,size(e,2),1);
ea(2:(size(ea,1)-1),size(ea,2),size(ea,3)) = e(:,1,1);
ea(1,2:(size(ea,2)-1),size(ea,3)) = e(size(e,1),:,1);
ea(size(ea,1),2:(size(ea,2)-1),size(ea,3)) = e(1,:,1);
ea(size(ea,1),size(ea,2),size(ea,3)) = e(1,1,1);
ea(1,1,size(ea,3)) = e(size(e,1),size(e,2),1);
ea(1,size(ea,2),size(ea,3)) = e(size(e,1),1,1);
ea(size(ea,1),1,size(ea,3)) = e(1,size(e,2),1);
xa               = zeros(sz1+2,sz2+2,sz3+2);
xa(2:(size(xa,1)-1),2:(size(xa,2)-1),2:(size(xa,3)-1)) = x;
xa(2:(size(xa,1)-1),2:(size(xa,2)-1),1) = x(:,:,size(x,3));
xa(2:(size(xa,1)-1),2:(size(xa,2)-1),size(xa,3)) = x(:,:,1);
xa(1,2:(size(xa,2)-1),2:(size(xa,3)-1)) = x(size(x,1),:,:);
xa(size(xa,1),2:(size(xa,2)-1),2:(size(xa,3)-1)) = x(1,:,:);
xa(2:(size(xa,1)-1),1,2:(size(xa,3)-1)) = x(:,size(x,2),:);
xa(2:(size(xa,1)-1),size(xa,2),2:(size(xa,3)-1)) = x(:,1,:);
xa(1,1,2:(size(xa,3)-1)) = x(size(x,1),size(x,2),:);
xa(size(xa,1),1,2:(size(xa,3)-1)) = x(1,size(x,2),:);
xa(1,size(xa,2),2:(size(xa,3)-1)) = x(size(x,1),1,:);
xa(size(xa,1),size(xa,2),2:(size(xa,3)-1)) = x(1,1,:);
xa(1,2:(size(xa,2)-1),1) = x(size(x,1),:,size(x,3));
xa(size(xa,1),2:(size(xa,2)-1),1) = x(1,:,size(x,3));
xa(2:(size(xa,1)-1),size(xa,2),1) = x(:,1,size(x,3));
xa(2:(size(xa,1)-1),1,1) = x(:,size(x,2),size(x,3));
xa(1,1,1) = x(size(x,1),size(x,2),size(x,3));
xa(size(xa,1),1,1) = x(1,size(x,2),size(x,3));
xa(1,size(xa,2),1) = x(size(x,1),1,size(x,3));
xa(size(xa,1),size(xa,2),1) = x(1,1,size(x,3));
xa(2:(size(xa,1)-1),1,size(xa,3)) = x(:,size(x,2),1);
xa(2:(size(xa,1)-1),size(xa,2),size(xa,3)) = x(:,1,1);
xa(1,2:(size(xa,2)-1),size(xa,3)) = x(size(x,1),:,1);
xa(size(xa,1),2:(size(xa,2)-1),size(xa,3)) = x(1,:,1);
xa(size(xa,1),size(xa,2),size(xa,3)) = x(1,1,1);
xa(1,1,size(xa,3)) = x(size(x,1),size(x,2),1);
xa(1,size(xa,2),size(xa,3)) = x(size(x,1),1,1);
xa(size(xa,1),1,size(xa,3)) = x(1,size(x,2),1);
ya               = zeros(sz1+2,sz2+2,sz3+2);
ya(2:(size(ya,1)-1),2:(size(ya,2)-1),2:(size(ya,3)-1)) = y;
ya(2:(size(ya,1)-1),2:(size(ya,2)-1),1) = y(:,:,size(y,3));
ya(2:(size(ya,1)-1),2:(size(ya,2)-1),size(ya,3)) = y(:,:,1);

ya(1,2:(size(ya,2)-1),2:(size(ya,3)-1)) = y(size(y,1),:,:);
ya(size(ya,1),2:(size(ya,2)-1),2:(size(ya,3)-1)) = y(1,:,:);
ya(2:(size(ya,1)-1),1,2:(size(ya,3)-1)) = y(:,size(y,2),:);
ya(2:(size(ya,1)-1),size(ya,2),2:(size(ya,3)-1)) = y(:,1,:);
ya(1,1,2:(size(ya,3)-1)) = y(size(y,1),size(y,2),:);
ya(size(ya,1),1,2:(size(ya,3)-1)) = y(1,size(y,2),:);
ya(1,size(ya,2),2:(size(ya,3)-1)) = y(size(y,1),1,:);
ya(size(ya,1),size(ya,2),2:(size(ya,3)-1)) = y(1,1,:);
ya(1,2:(size(ya,2)-1),1) = y(size(y,1),:,size(y,3));
ya(size(ya,1),2:(size(ya,2)-1),1) = y(1,:,size(y,3));
ya(2:(size(ya,1)-1),size(ya,2),1) = y(:,1,size(y,3));
ya(2:(size(ya,1)-1),1,1) = y(:,size(y,2),size(y,3));
ya(1,1,1) = y(size(y,1),size(y,2),size(y,3));
ya(size(ya,1),1,1) = y(1,size(y,2),size(y,3));
ya(1,size(ya,2),1) = y(size(y,1),1,size(y,3));
ya(size(ya,1),size(ya,2),1) = y(1,1,size(y,3));
ya(2:(size(ya,1)-1),1,size(ya,3)) = y(:,size(y,2),1);
ya(2:(size(ya,1)-1),size(ya,2),size(ya,3)) = y(:,1,1);
ya(1,2:(size(ya,2)-1),size(ya,3)) = y(size(y,1),:,1);
ya(size(ya,1),2:(size(ya,2)-1),size(ya,3)) = y(1,:,1);
ya(size(ya,1),size(ya,2),size(ya,3)) = y(1,1,1);
ya(1,1,size(ya,3)) = y(size(y,1),size(y,2),1);
ya(1,size(ya,2),size(ya,3)) = y(size(y,1),1,1);
ya(size(ya,1),1,size(ya,3)) = y(1,size(y,2),1);
za               = zeros(sz1+2,sz2+2,sz3+2);
za(2:(size(za,1)-1),2:(size(za,2)-1),2:(size(za,3)-1)) = z;
za(2:(size(za,1)-1),2:(size(za,2)-1),1) = z(:,:,size(z,3));
za(2:(size(za,1)-1),2:(size(za,2)-1),size(za,3)) = z(:,:,1);
za(1,2:(size(za,2)-1),2:(size(za,3)-1)) = z(size(z,1),:,:);
za(size(za,1),2:(size(za,2)-1),2:(size(za,3)-1)) = z(1,:,:);
za(2:(size(za,1)-1),1,2:(size(za,3)-1)) = z(:,size(z,2),:);
za(2:(size(za,1)-1),size(za,2),2:(size(za,3)-1)) = z(:,1,:);
za(1,1,2:(size(za,3)-1)) = z(size(z,1),size(z,2),:);
za(size(za,1),1,2:(size(za,3)-1)) = z(1,size(z,2),:);
za(1,size(za,2),2:(size(za,3)-1)) = z(size(z,1),1,:);
za(size(za,1),size(za,2),2:(size(za,3)-1)) = z(1,1,:);
za(1,2:(size(za,2)-1),1) = z(size(z,1),:,size(z,3));
za(size(za,1),2:(size(za,2)-1),1) = z(1,:,size(z,3));
za(2:(size(za,1)-1),size(za,2),1) = z(:,1,size(z,3));
za(2:(size(za,1)-1),1,1) = z(:,size(z,2),size(z,3));
za(1,1,1) = z(size(z,1),size(z,2),size(z,3));
za(size(za,1),1,1) = z(1,size(z,2),size(z,3));
za(1,size(za,2),1) = z(size(z,1),1,size(z,3));
za(size(za,1),size(za,2),1) = z(1,1,size(z,3));
za(2:(size(za,1)-1),1,size(za,3)) = z(:,size(z,2),1);
za(2:(size(za,1)-1),size(za,2),size(za,3)) = z(:,1,1);
za(1,2:(size(za,2)-1),size(za,3)) = z(size(z,1),:,1);
za(size(za,1),2:(size(za,2)-1),size(za,3)) = z(1,:,1);
za(size(za,1),size(za,2),size(za,3)) = z(1,1,1);
za(1,1,size(za,3)) = z(size(z,1),size(z,2),1);
za(1,size(za,2),size(za,3)) = z(size(z,1),1,1);
za(size(za,1),1,size(za,3)) = z(1,size(z,2),1);

hold on
axis equal
axis tight
axis([min(min(min(xa))) max(max(max(xa))) min(min(min(ya))) max(max(max(ya))) min(min(min(za))) max(max(max(za)))])
xlabel('X-axis')
ylabel('Y-axis')
zlabel('Z-axis')
title('Particle distribution in lattice')
box on
for count = 1:numel(ea)
    text(xa(ea(count)),y(ea(count)),z(ea(count)),num2str(ea(count)))
    axis
    pause(0.01)
end