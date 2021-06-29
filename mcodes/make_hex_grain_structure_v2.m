function [Xfull, Yfull, xstart, ystart, xend, yend] = make_hex_grain_structure_v2(x_lim, y_lim, h_dist, v_dist_factor)
%-----------------------------------------------------------------------
% FROM: https://uk.mathworks.com/matlabcentral/answers/474193-how-to-generate-points-in-triangular-lattice-pattern
% by Michael Madelaire
%% NOTE: For shortage of time, i am using it. I could have written this myself
% I have, though modified it to get trigris in the way i need and added the
% returen variables - Sunil Anandatheertha
%-----------------------------------------------------------------------
%% Triangular grid information
% h_dist = 1; % Horizontal distance
% v_dist_factor = 1;
v_dist = v_dist_factor*sqrt(h_dist^2-(h_dist/2)^2); % Vertical distance
%% Region size
% x_lim = 10;
% y_lim = 10;

%% Generate grid
trigrid = [];
y_current = 0;
xx = 0;
displacement = 0;
while y_current < y_lim
    if displacement == 0
        xx = [0:h_dist:x_lim]';
        yy = ones(length(xx), 1)*y_current;
        displacement = 1;
    else
        xx = [h_dist/2:h_dist:x_lim]';
        yy = ones(length(xx), 1)*y_current;
        displacement = 0;
    end
    trigrid = [trigrid [xx'; yy']];
    y_current = y_current + v_dist;
end
%% Plot
figure
plot(trigrid(1,:), trigrid(2,:), 'ko', 'markersize', 5);

grid on;
xlim([-h_dist, x_lim+h_dist]);
ylim([-v_dist, y_lim+v_dist]);

Xfull = trigrid(1,:);
Yfull = trigrid(2,:);
xstart = min(min(Xfull));
ystart = min(min(Yfull));
xend = max(max(Xfull));
yend = max(max(Yfull));
axis equal
axis tight
% axis off




end