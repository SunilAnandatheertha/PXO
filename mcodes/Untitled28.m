% THIS FUNCTION MAKES THE TENSILE TESTING SPECIMEN
figure
xincr = 0.05;
yincr = 0.05;

xleft = -1.5:xincr:0;
yleft = -0.5:yincr:0.5;
[xleft, yleft] = meshgrid(xleft, yleft);
% plot(xleft, yleft, 'c.'); hold on

%-------------------------------------------
c_cen_x = max(max(xleft));
c_cen_y = 0.75; np = 1E3;
th = linspace(0, 360, np);
c_radius = 0.6;
c_circum_x = c_cen_x + c_radius*cosd(th);
c_circum_y = c_cen_y + c_radius*sind(th);
% plot(c_circum_x, c_circum_y, 'r-')

[IN_left_top, ~] = inpolygon(xleft, yleft, c_circum_x, c_circum_y);

% grip_e_num = reshape(1:numel(xleft), size(xleft)).*(1-IN_left_top);
% grip_e_num = reshape(grip_e_num, numel(grip_e_num), 1);
% 
% grip_e_num(grip_e_num == 0 ) = [];
% xgrip = xleft(grip_e_num);
% ygrip = yleft(grip_e_num);
% plot(xgrip, ygrip, 'k.')
% 
% plot(c_cen_x, c_cen_y, 'ko')
%-------------------------------------------
c_cen_x = max(max(xleft));
c_cen_y = -0.75; np = 1E3;
c_circum_x = c_cen_x + c_radius*cosd(th);
c_circum_y = c_cen_y + c_radius*sind(th);
% plot(c_circum_x, c_circum_y, 'r-')

[IN_left_bot, ~] = inpolygon(xleft, yleft, c_circum_x, c_circum_y);
%-------------------------------------------
% grip_e_num_left  = reshape(1:numel(xleft), size(xleft)).*(1-IN_left_top).*(1-IN_left_bot);
grip_x_left = xleft./(1-IN_left_top)./(1-IN_left_bot);
grip_y_left = yleft./(1-IN_left_top)./(1-IN_left_bot);

grip_x_left(isinf(grip_x_left)) = NaN;
grip_y_left(isinf(grip_y_left)) = NaN;

% plot(grip_x_left, grip_y_left, 'r.')

grip_x_right = 2 + flip(max(max(grip_x_left))-grip_x_left, 2);
grip_y_right = flip(grip_y_left, 2);

grip_x_left = reshape(grip_x_left, numel(grip_x_left), 1);
grip_x_left(isnan(grip_x_left)) = [];
grip_y_left = reshape(grip_y_left, numel(grip_y_left), 1);
grip_y_left(isnan(grip_y_left)) = [];

grip_x_right = reshape(grip_x_right, numel(grip_x_right), 1);
grip_x_right(isnan(grip_x_right)) = [];
grip_y_right = reshape(grip_y_right, numel(grip_y_right), 1);
grip_y_right(isnan(grip_y_right)) = [];

plot(grip_x_left, grip_y_left, 'ks'); hold on
plot(grip_x_right, grip_y_right, 'ks')

axis equal
axis tight


% k = boundary(grip_x_right, grip_y_right, 1.0);
% plot(grip_x_right(k), grip_y_right(k), 'r-', 'linewidth', 2)
% 
% plot(grip_x_right, grip_y_right, 'k.')



%-------------------------------------------
%-------------------------------------------
