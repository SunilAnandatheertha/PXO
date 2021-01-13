% function CPFEM_Tensile_Spec__2D__GRIPS()
global Lattice
xmin    = Lattice.size.xmin;
xmax    = Lattice.size.xmax;
ymin    = Lattice.size.ymin;
ymax    = Lattice.size.ymax;
xincr   = Lattice.size.i_incr;
yincr   = Lattice.size.j_incr;
xlength = Lattice.size.xlength;
ylength = Lattice.size.ylength;
x       = Lattice.size.x;
y       = Lattice.size.y;
sz1     = Lattice.size.sz1;
sz2     = Lattice.size.sz2;
%---------------------------------------------------------
plot(xmin, ymin, 'ko', 'markersize', 10, 'linewidth', 1)
plot(xmin, ymax, 'ko', 'markersize', 10, 'linewidth', 1)
plot(xmax, ymin, 'ko', 'markersize', 10, 'linewidth', 1)
plot(xmax, ymax, 'ko', 'markersize', 10, 'linewidth', 1)

text(xmin-3*xincr, ymin-3*yincr, [num2str(xmin) ' , ' num2str(ymin)], 'fontweight', 'bold');
text(xmin-3*xincr, ymax+3*yincr, [num2str(xmin) ' , ' num2str(ymax)], 'fontweight', 'bold');

text(xmax-5*xincr, ymin-3*yincr, [num2str(xmax) ' , ' num2str(ymin)], 'fontweight', 'bold');
text(xmax-5*xincr, ymax+3*yincr, [num2str(xmax) ' , ' num2str(ymax)], 'fontweight', 'bold');
%---------------------------------------------------------
% figure
radiusadjfactor = 6;
%---------------------------------------------------------
xleft = (-60:xincr:0) - 1*xincr + xmin;
width = 1.6*(ymax-ymin);
yleft = linspace(-width/2, width/2, width/yincr+1)+(ymin+ymax)/2;
%---------------------------------------------------------
[xleft, yleft] = meshgrid(xleft, yleft);
% plot(xleft, yleft, 'k.')
%---------------------------------------------------------
c_cen_x  = max(max(xleft));
c_cen_y  = ylength/2+(ymax+ymin)/2 + c_radius;
c_radius = 20.0+radiusadjfactor;
% plot(c_cen_x, c_cen_y, 'bo')

np         = 1E3;
th         = linspace(0, 360, np);
c_circum_x = c_cen_x + c_radius*cosd(th);
c_circum_y = c_cen_y + yincr + c_radius*sind(th);
% hp         = plot(c_circum_x, c_circum_y, 'r-');
% delete(hp)
%---------------------------------------------------------
%---------------------------------------------------------
% ALTERNATIVE TO ABOVE METHOD
GS_centroid = [(xmin + xmax)/2 (ymin + ymax)/2];% X,Y of the centroid of grain structure

%---------------------------------------------------------
%---------------------------------------------------------
[IN_left_top, ~] = inpolygon(xleft, yleft, c_circum_x, c_circum_y);
%---------------------------------------------------------
c_cen_y  = -ylength/2-(ymax+ymin)/2 - c_radius;
% plot(c_cen_x, c_cen_y, 'ko')
c_circum_x = c_cen_x + c_radius*cosd(th);
c_circum_y = c_cen_y - yincr + c_radius*sind(th);
% plot(c_circum_x, c_circum_y, 'k-')
%---------------------------------------------------------
[IN_left_bot, ~] = inpolygon(xleft, yleft, c_circum_x, c_circum_y);
%---------------------------------------------------------
grip_x_left                     = xleft./(1-IN_left_top)./(1-IN_left_bot);
grip_y_left                     = yleft./(1-IN_left_top)./(1-IN_left_bot);
grip_x_left(isinf(grip_x_left)) = NaN;
grip_y_left(isinf(grip_y_left)) = NaN;
% plot(grip_x_left, grip_y_left, 'r.')
%---------------------------------------------------------
grip_x_right = (0) + flip(0*max(max(grip_x_left))-grip_x_left+xincr, 2);
grip_y_right = flip(grip_y_left, 2);

grip_x_left                     = reshape(grip_x_left, numel(grip_x_left), 1);
grip_y_left                     = reshape(grip_y_left, numel(grip_y_left), 1);
grip_x_left(isnan(grip_x_left)) = [];
grip_y_left(isnan(grip_y_left)) = [];

grip_x_right                      = reshape(grip_x_right, numel(grip_x_right), 1);
grip_y_right                      = reshape(grip_y_right, numel(grip_y_right), 1);
grip_x_right(isnan(grip_x_right)) = [];
grip_y_right(isnan(grip_y_right)) = [];
%---------------------------------------------------------
h_left_grip  = plot(grip_x_left , grip_y_left , 'k.'); hold on
h_right_grip = plot(grip_x_right, grip_y_right, 'r.');
%---------------------------------------------------------
axis equal
axis tight
% end