close all; clear all
%% GET USER INPUT DATA
% 11111111111111111111111111111111111111111111111111111111
prompt1 = {01, '01: UNIFORM-RECT-01'    , '';...
           02, '02: UNIFORM-RECT-HEX-01', '';...
           03, '03: UNIFORM-RANDOM-01'  , '';...
           04, '04: UNIFORM-HEX-01'     , '';...
           05, '05: GRAD-RECT-01-LOG'   , '';...
           06, '06: GRAD-RECT-02-LOG'   , '';...
           07, '07: GRAD-RECT-03-EXP'   , '';...
           08, '08: GRAD-RAND-01-EXP'   , '';...
           };
dlgtitle = 'Type 1 below the option to use it.';
LatType  = prompt1{~cellfun(@isempty,inputdlg(prompt1(:,2)',dlgtitle, [1 60], prompt1(:,3)')), 2};
% 11111111111111111111111111111111111111111111111111111111
prompt2 = {01, '01: VISUALIZE VORNOI CELLS: AREA COLOURING'         , 'ColourGrainsByArea';...
           02, '02: VISUALIZE VORNOI CELLS: ASPECT RATIO COLOURING' , 'ColourGrainsByAspectRatio';...
          };
dlgtitle = 'Set flag for visualizing voronoi cells by area colouring';
PlotGrainAspects = inputdlg(prompt2(:,2)',dlgtitle, [1 60], prompt2(:,3)');
% 11111111111111111111111111111111111111111111111111111111
if strcmp(PlotGrainAspects{1}, 'ColourGrainsByArea') == 1
    prompt3 = {01, '01: BrightCyan (LOW) to Bright red (HIGH)', '1';...
               02, '02: Black (LOW) to WHite (HIGH)'          , '';...
               03, 'Colouring option - 3'   , '';...
               04, 'Colouring option - 4'   , '';...
               05, 'Colouring option - 5'   , '';...
               06, 'Colouring option - 6'   , '';...
               07, 'Colouring option - 7'   , '';...
               };
    dlgtitle = 'Select colouring option for area wise plotting';
    AreaWiseGrainColours = prompt3{~cellfun(@isempty,inputdlg(prompt3(:,2)',dlgtitle, [1 100], prompt3(:,3)')), 2};
end
if strcmp(PlotGrainAspects{2}, 'ColourGrainsByAspectRatio') == 1
    prompt3 = {01, '01: BrightCyan (LOW) to Bright red (HIGH)', '1';...
               02, '02: Black (LOW) to WHite (HIGH)'          , '';...
               03, 'Colouring option - 3'   , '';...
               04, 'Colouring option - 4'   , '';...
               05, 'Colouring option - 5'   , '';...
               06, 'Colouring option - 6'   , '';...
               07, 'Colouring option - 7'   , '';...
               };
    dlgtitle = 'Select colouring option for aspect ratio wise plotting';
    AspectRatioWiseGrainColours = prompt3{~cellfun(@isempty,inputdlg(prompt3(:,2)',dlgtitle, [1 100], prompt3(:,3)')), 2};
end
% 22222222222222222222222222222222222222222222222222222222
%% SELECT LATTICE TYPE, SET PARAMETERS, LIMITS AND MAKE THE LATTICE
switch LatType
    case '01: UNIFORM-RECT-01'
        startx  = 2;
        starty  = 0;
        lengthx = 20;
        lengthy = 4;
        incr_i  = 2.0;
        incr_j  = 0.5;
        bs_ext  = [startx  starty; lengthx starty; lengthx lengthy;
                   startx  lengthy; startx  starty];
        xorig   = startx+incr_i : incr_i : startx+lengthx-incr_i;
        yorig   = starty+incr_j : incr_j : starty+lengthy-incr_j;
        [x, y]  = meshgrid(xorig, yorig);
    case '02: UNIFORM-RECT-HEX-01'
        startx     = 0;
        starty     = 0;
        lengthx    = 5;
        lengthy    = 5;
        
        incr_i     = 1.0;
        incr_i_fac = 0.35;
        incr_j     = 1.0;
        incr_j_fac = 0.75;
        
        rx         = startx:incr_i:startx+lengthx;
        ry         = starty:incr_j:starty+lengthy;
        [rx, ry]   = meshgrid(rx, ry);
        hx         = startx+incr_i_fac*incr_i:incr_i:startx+lengthx;
        hy         = starty+incr_j_fac*incr_j:incr_j:starty+lengthy;
        [hx, hy]   = meshgrid(hx, hy);        
        x          = [rx(:); hx(:)];
        y          = [ry(:); hy(:)];
        
        bs_ext     = [startx         starty;
                      startx+lengthx starty;
                      startx+lengthx starty+lengthy;
                      startx         starty+lengthy;
                      startx         starty];
%         bs_ext   = [1 1; 4 0; 5 4; 1.5 2; 1 1];
    case '03: UNIFORM-RANDOM-01'
        startx     = 0;
        starty     = 0;
        lengthx    = 8;
        lengthy    = 5;
        Nopoints_i = 5;
        Nopoints_j = 5;
        xscale     = 1.0; % not equal to zero
        yscale     = 1.0; % not equal to zero
        origshiftx = +0.0;
        origshifty = +0.0;

        bs_ext = [startx  starty; lengthx starty; lengthx lengthy;
                  startx  lengthy; startx  starty];
        xorig  = rand(Nopoints_i, Nopoints_j) - origshiftx;
        yorig  = rand(Nopoints_i, Nopoints_j) - origshifty;

        x = xscale*lengthx*xorig;
        y = yscale*lengthy *yorig;
    case '04: UNIFORM-HEX-01'
        x_lim         = 5;
        y_lim         = 10;
        h_dist        = 1;
        v_dist_factor = 1;
        [Xfull, Yfull,...
            xstart, ystart,...
            xend, yend] = make_hex_grain_structure_v2(x_lim, y_lim,...
                                                      h_dist, v_dist_factor);
        x       = Xfull;
        y       = Yfull;
        startx  = xstart;
        starty  = ystart;
        lengthx = xend;
        lengthy = yend;
        bs_ext = [startx  starty; lengthx starty; lengthx lengthy;
                  startx  lengthy; startx  starty];
    case '05: GRAD-RECT-01-LOG'
        startx  = 1;
        starty  = 1;
        lengthx = 10;
        lengthy = 10;
        xincr   = 1;
        yincr   = 1;
        x       = startx:xincr:lengthx+startx;
        y       = starty:yincr:lengthy+starty;
        [x, y]  = meshgrid(x,y);
        x       = log10(x); x = x/max(max(x));
        y       = log10(y); y = y/max(max(y));
        bs_ext  = log10([startx  starty; lengthx starty; lengthx lengthy;
                         startx  lengthy; startx  starty]);
    case '06: GRAD-RECT-02-LOG'
        startx  = 2;
        starty  = 2;
        lengthx = 10;
        lengthy = 10;
        xincr   = 1;
        yincr   = 1;
        x       = startx:xincr:lengthx+startx; 
        y       = starty:yincr:lengthy+starty;
        [x, y]  = meshgrid(x,y);
        x       = 1./log10(x); x = x/max(max(x));
        y       = 1./log10(y); y = y/max(max(y));
        bs_ext  = log10([startx  starty; lengthx starty; lengthx lengthy;
                         startx  lengthy; startx  starty]);
    case '07: GRAD-RECT-03-EXP'
        startx    = 0;
        starty    = 0;
        lengthx   = 1;
        lengthy   = 1;
        xincr     = 0.1;
        yincr     = 0.1;
        
        constantx = 0.5;
        exponentx = 3;
        
        constanty = 2;
        exponenty = 0.8;
        
        x         = startx:xincr:lengthx+startx; 
        y         = starty:yincr:lengthy+starty;
        [x, y]    = meshgrid(x,y);
        x         = constantx*x.^exponentx; x = x/max(max(x));
        y         = constanty*y.^exponenty; y = y/max(max(y));
        bs_ext    = [min(min(x))  min(min(y)); max(max(x)) min(min(y)); max(max(x)) max(max(y));
                     min(min(x))  max(max(y)); min(min(x))  min(min(y))];
    case '08: GRAD-RAND-01-EXP'
        startx     = 0;
        starty     = 0;
        lengthx    = 10;
        lengthy    = 10;
        Nopoints_i = 25;
        Nopoints_j = 25;
        xscale     = 1.0; % not equal to zero
        yscale     = 1.0; % not equal to zero
        origshiftx = +0.0;
        origshifty = +0.0;

        constantx  = 1;
        exponentx  = 0.8;
        
        constanty  = 1;
        exponenty  = 0.8;
        
        xorig      = rand(Nopoints_i, Nopoints_j) - origshiftx;
        yorig      = rand(Nopoints_i, Nopoints_j) - origshifty;
        
        x          = xscale*lengthx*xorig;
        y          = yscale*lengthy*yorig;
        
        x          = constantx*x.^exponentx; x = (x/max(max(x)))*(lengthx-startx);
        y          = constanty*y.^exponenty; y = (y/max(max(y)))*(lengthy-starty);
        bs_ext     = [min(min(x))  min(min(y)); max(max(x)) min(min(y)); max(max(x)) max(max(y));
                      min(min(x))  max(max(y)); min(min(x))  min(min(y))];
end
x = x(:);
y = y(:);
% plot(x,y,'k.')
%% CLIP THE DOMAIN TO SUBSET OF INTEREST
% 44444444444444444444444444444444444444444444444444444444
[v, c, xy] = VoronoiLimit(x, y, 'bs_ext', bs_ext, 'figure', 'off');
% plot(v(:,1), v(:,2), 'k.')
% axis equal
% hold on
%% CALCULATE PROPERTIES OF VORONOI PARTITIONS
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
%% CALCULATE COLOURS FOR GRAIN STRUCTURE VISULIZATION
color = zeros(numel(c), 3);
switch AreaWiseGrainColours
    case '01: BrightCyan (LOW) to Bright red (HIGH)'
        color(:, 1) = (vcn_area/max(vcn_area)).^1;
        color(:, 2) = (1-vcn_area/max(vcn_area)).^10;
        color(:, 3) = (1-vcn_area/max(vcn_area)).^10;
    case '02: Black (LOW) to WHite (HIGH)'
end
%% VISUALIZE GRAIN STRUCTURE WITH COLOURS INDICATING GRAIN SIZES and GRAIN AREA STATISTICS
figure
hold on
for vcn = 1:numel(c)
    patch(v(vcn_bound{vcn}, 1), v(vcn_bound{vcn}, 2), color(vcn,:))
%     plot(centroids(vcn,1), centroids(vcn,2), 'kx', 'markerfacecolor', 'k', 'markersize', 7)
end
% plot(v(:,1), v(:,2), 'ko', 'markerfacecolor', 'k', 'markersize', 5)
box on
axis equal
axis tight
% plot(x, y, 'r+', 'markersize', 4)
figure
histogram(vcn_area, 10)
xlabel('Area of Voronoi cells')
ylabel('Count')
%% CALCULATE PIXELLATED GRAIN STRUCTURE EQUIVALENT FOR VORONOI TESSELLATION
prompt4      = {01, 'Create pixellated equivalent', '1';...
                02, '# of points - x'             , '100';...
                03, '# of points - y'             , '100';...
                04, 'Plot PXL.GS'                 , '1';...
                05, 'Plot PXL.GS histogram'       , '1';...
                };
dlgtitle     = 'Options for generating pixel.GS from VT.GS';
PXL_GS_Param = inputdlg(prompt4(:,2)',dlgtitle, [1 60], prompt4(:,3)');

if str2double(PXL_GS_Param{1}) == 1
    latx         = linspace(startx, startx+lengthx, str2double(PXL_GS_Param{2}));
    laty         = linspace(starty, starty+lengthy, str2double(PXL_GS_Param{3}));
    pixelarea    = abs(latx(1)-latx(2))*abs(laty(1)-laty(2));
    [latx, laty] = meshgrid(latx, laty);
    LATpointgrainIDgrid = zeros(size(latx));
    latx = latx(:);
    laty = laty(:);
    pixellatedgrainarea = zeros(size(c));
    for vcn = 1:numel(c)
        thisgrain_bound_x = v(vcn_bound{vcn}, 1);
        thisgrain_bound_y = v(vcn_bound{vcn}, 2);
% %         %patch(thisgrain_bound_x, thisgrain_bound_y, color(vcn,:), 'facealpha', 0.5)

        thisgrain_bound_reduced_x = thisgrain_bound_x(1:end-1);
        thisgrain_bound_reduced_y = thisgrain_bound_y(1:end-1);

        [ingrain, ongrainboundary] = inpolygon(latx, laty, thisgrain_bound_reduced_x, thisgrain_bound_reduced_y);
        grainlatpoints             = ingrain+ongrainboundary;
        grainlatpoints             = grainlatpoints/max(grainlatpoints);
        pointsinthisgrain          = find(grainlatpoints~=0);
        pixellatedgrainarea(vcn)   = pixelarea*numel(pointsinthisgrain);
        thispixelcolor             = rand(1,3);
        if str2double(PXL_GS_Param{4}) == 1
            if vcn == 1
                figure; hold on; % plot(latx, laty, 'c.')
            end
            plot(latx(ingrain), laty(ingrain), 'ks', 'markerfacecolor', thispixelcolor, 'markeredgecolor', thispixelcolor)
            axis equal
            axis tight
            box on
            pause(0.05)
        end
        LATpointgrainIDgrid(grainlatpoints~=0) = vcn;
    end
    if str2double(PXL_GS_Param{5}) == 1
        figure
        histogram(pixellatedgrainarea, 10)
        axis([0 1 0 50])
    end
end