theta = 0:pi/30:2*pi;
r = 1*pi:pi/20:2*pi;
[R,T] = meshgrid(r,theta);
%%Create top and bottom halves
Z_top = 2*sin(R);
Z_bottom = -2*sin(R);
%%Convert to Cartesian coordinates and plot
[X,Y,Z] = pol2cart(T,R,Z_top);
surf(X,Y,Z, 'linewidth', 2);
hold on;
[X,Y,Z] = pol2cart(T,R,Z_bottom);
surf(X,Y,Z, 'linewidth', 2);
axis equal
% shading interp
% lighting gouraud
% colormap bone
axis off