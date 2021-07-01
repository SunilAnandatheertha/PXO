% rng(1)
type = 'rect_hex';
switch type
    case 'rect'
        startx  = 2;
        starty  = 0;
        lengthx = 20;
        widthy  = 4;
        incr_i  = 2.0;
        incr_j  = 0.5;
        
        bs_ext = [startx  starty; lengthx starty; lengthx widthy;
                  startx  widthy; startx  starty];
        xorig = startx+incr_i : incr_i : startx+lengthx-incr_i;
        yorig = starty+incr_j : incr_j : starty+widthy -incr_j;
        [x, y] = meshgrid(xorig, yorig);
    case 'rect_hex'
        startx   = 0;
        starty   = 0;
        lengthx  = 5;
        lengthy  = 5;
        
        incr_i = 1.0;
        incr_i_fac = 0.35;
        incr_j = 1.0;
        incr_j_fac = 0.75;        
        
        rx = startx:incr_i:startx+lengthx;
        ry = starty:incr_j:starty+lengthy;
        [rx, ry] = meshgrid(rx, ry);
        hx = startx+incr_i_fac*incr_i:incr_i:startx+lengthx;
        hy = starty+incr_j_fac*incr_j:incr_j:starty+lengthy;
        [hx, hy] = meshgrid(hx, hy);        
        x = [rx(:); hx(:)];
        y = [ry(:); hy(:)];
        
        bs_ext = [startx  starty;
                  startx+lengthx starty;
                  startx+lengthx starty+lengthy;
                  startx  starty+lengthy;
                  startx  starty];
        bs_ext = [1 1; 4 0; 5 4; 1.5 2; 1 1];
    case 'random'
        startx  = 0;
        starty  = 0;
        lengthx = 8;
        widthy  = 5;
        Nopoints_i = 5;
        Nopoints_j = 5;
        xscale = 1.0; % not equal to zero
        yscale = 1.0; % not equal to zero
        origshiftx = +0.0;
        origshifty = +0.0;

        bs_ext = [startx  starty; lengthx starty; lengthx widthy;
                  startx  widthy; startx  starty];

        xorig = rand(Nopoints_i, Nopoints_j) - origshiftx;
        yorig = rand(Nopoints_i, Nopoints_j) - origshifty;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        x = xscale*lengthx*xorig;
        y = yscale*widthy *yorig;
    case 'hex'
        %[xorig, yorig, xstart, ystart, xend, yend] = make_hex_grain_structure_v1();
        %[xorig, yorig, xstart, ystart, xend, yend] = make_hex_grain_structure_v2();
        
        x_lim = 5;
        y_lim = 10;
        h_dist = 1;
        v_dist_factor = 1;
        [Xfull, Yfull, xstart, ystart, xend, yend] = make_hex_grain_structure_v2(x_lim, y_lim, h_dist, v_dist_factor);
        x = Xfull;
        y = Yfull;
        
        startx  = xstart;
        starty  = ystart;
        lengthx = xend;
        widthy  = yend;

        bs_ext = [startx  starty; lengthx starty; lengthx widthy;
                  startx  widthy; startx  starty];
end
%----------------------------------------------
%----------------------------------------------

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
x = x(:);
y = y(:);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[v, c, xy] = VoronoiLimit(x, y, 'bs_ext', bs_ext, 'figure', 'off');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
plot(v(:,1), v(:,2), 'k.')
axis equal
hold on

figure
hold on
vcn_bound = cell(size(c));
VertOrder = cell(size(c));
vcn_area  = zeros(size(c));
centroids = zeros(size(c,1), 2);

for vcn = 1:numel(c)
    [VertOrder{vcn}, vcn_area(vcn)] = convhull(v(c{vcn}, 1), v(c{vcn}, 2));
    vcn_bound{vcn} = c{vcn}(VertOrder{vcn});

    xtemp = v(c{vcn}(:),1)'; ytemp = v(c{vcn}(:),2)';
    centroids(vcn,:) = [sum(xtemp)/numel(xtemp) sum(ytemp)/numel(ytemp)];
end

color = zeros(numel(c), 3);
color(:, 1) = vcn_area/max(vcn_area);
color(:, 2) = vcn_area/max(vcn_area);
color(:, 3) = 1-vcn_area/max(vcn_area);

for vcn = 1:numel(c)
    patch(v(vcn_bound{vcn}, 1), v(vcn_bound{vcn}, 2), color(vcn,:))
    plot(centroids(vcn,1), centroids(vcn,2), 'kx', 'markerfacecolor', 'k', 'markersize', 7)
end
plot(v(:,1), v(:,2), 'ko', 'markerfacecolor', 'k', 'markersize', 5)
box on
axis equal
axis tight
plot(x, y, 'r+', 'markersize', 4)
figure
histogram(vcn_area, 10)
xlabel('Area of Voronoi cells')
ylabel('Count')