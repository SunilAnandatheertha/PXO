function [JKT_FIELD] = ConstructJKT_field_v1(JKT_bounds, x, y, DistributionSense, JKT_estimation_parameters_1)

% x = 1:5;
% y = 1:5;

% JKT_bounds = [0 2 0 2];
JKT_xminval = JKT_bounds(1);
JKT_xmaxval = JKT_bounds(2);
JKT_yminval = JKT_bounds(3);
JKT_ymaxval = JKT_bounds(4);

% [JKT_FIELD] = ConstructJKT_field_v1([0 2 0 2], 1:20, 1:20, 'outmax_to_inmin', {'power', 1, -0.1, 'norm_max_yes'});

DistributionBehaviour = JKT_estimation_parameters_1{1};
constant              = JKT_estimation_parameters_1{2};
exponent              = JKT_estimation_parameters_1{3};
normalizetomax        = JKT_estimation_parameters_1{4};

xmin  = min(x);         xmax  = max(x);
ymin  = min(y);         ymax  = max(y);
xincr = abs(x(2)-x(1));
yincr = abs(y(2)-y(1));

[xx, yy] = meshgrid(x,y);

switch DistributionSense
    case 'x-min_to_x+max'
        xbase = JKT_xminval + JKT_xmaxval*[xmin:xincr:xmax]/xmax;
        jkt_x = repmat(xbase, size(xx,1), 1);
%         [jkt_x] = EstimateJKT(jkt_x, JKT_estimation_parameters_1)
        jkt_x = jkt_x.^exponent;
        jkt_x = jkt_x*min([JKT_xmaxval JKT_ymaxval])/max(max(jkt_x));
        contourf(xx,yy,jkt_x)
        JKT_FIELD = jkt_x;
    case 'y-min_to_y+max'
        ybase = JKT_yminval + JKT_ymaxval*[xmin:xincr:xmax]'/xmax;
        jkt_y = repmat(ybase, 1, size(xx,2));
        jkt_y = jkt_y.^exponent;
        jkt_y = jkt_y*min([JKT_xmaxval JKT_ymaxval])/max(max(jkt_y));
        contourf(xx,yy,jkt_y)
        JKT_FIELD = jkt_y;
    case 'x-max_to_x+min'
        xbase = JKT_xminval + JKT_xmaxval*[xmax:-xincr:xmin]/xmax;
        jkt_x = repmat(xbase, size(xx,1), 1);
        jkt_x = jkt_x.^exponent;
        jkt_x = jkt_x*min([JKT_xmaxval JKT_ymaxval])/max(max(jkt_x));
        JKT_FIELD = jkt_x;
        contourf(xx,yy,jkt_x)
    case 'y-max_to_y+min'
        ybase = JKT_yminval + JKT_ymaxval*[ymax:-yincr:ymin]'/ymax;
        jkt_y = repmat(ybase, 1, size(xx,2));
        jkt_y = jkt_y.^exponent;
        jkt_y = jkt_y*min([JKT_xmaxval JKT_ymaxval])/max(max(jkt_y));
        JKT_FIELD = jkt_y;
        contourf(xx,yy,jkt_y)
    case 'x-min_to_x+max_and_y-min_to_y+max'
        xbase = JKT_xminval + JKT_xmaxval*[xmin:xincr:xmax]/xmax;
        jkt_x = repmat(xbase, size(xx,1), 1);
        jkt_x = jkt_x.^exponent;
        ybase = JKT_yminval + JKT_ymaxval*[xmin:xincr:xmax]'/xmax;
        jkt_y = repmat(ybase, 1, size(xx,2));
        jkt_y = jkt_y.^exponent;
        jkt_xy = jkt_x+jkt_y;
        jkt_xy = jkt_xy*min([JKT_xmaxval JKT_ymaxval])/max(max(jkt_xy));
        JKT_FIELD = jkt_xy;
        contourf(xx,yy,jkt_xy)
    case 'x-max_to_x+min_and_y-max_to_y+min'
        xbase = JKT_xminval + JKT_xmaxval*[xmax:-xincr:xmin]/xmax;
        jkt_x = repmat(xbase, size(xx,1), 1);
        jkt_x = jkt_x.^exponent;
        ybase = JKT_yminval + JKT_ymaxval*[ymax:-yincr:ymin]'/ymax;
        jkt_y = repmat(ybase, 1, size(xx,2));
        jkt_y = jkt_y.^exponent;
        jkt_xy = jkt_x+jkt_y;
        jkt_xy = jkt_xy*min([JKT_xmaxval JKT_ymaxval])/max(max(jkt_xy));
        JKT_FIELD = jkt_xy;
        contourf(xx,yy,jkt_xy)
    case 'x-min_to_x+max_and_y-max_to_y+min'
        xbase = JKT_xminval + JKT_xmaxval*[xmin:xincr:xmax]/xmax;
        jkt_x = repmat(xbase, size(xx,1), 1);
        jkt_x = jkt_x.^exponent;
        ybase = JKT_yminval + JKT_ymaxval*[ymax:-yincr:ymin]'/ymax;
        jkt_y = repmat(ybase, 1, size(xx,2));
        jkt_y = jkt_y.^exponent;
        jkt_xy = jkt_x+jkt_y;
        jkt_xy = jkt_xy*min([JKT_xmaxval JKT_ymaxval])/max(max(jkt_xy));
        JKT_FIELD = jkt_xy;
        contourf(xx,yy,jkt_xy)
    case 'x-max_to_x+min_and_y-min_to_y+max'
        xbase = JKT_xminval + JKT_xmaxval*[xmax:-xincr:xmin]/xmax;
        jkt_x = repmat(xbase, size(xx,1), 1);
        jkt_x = jkt_x.^exponent;
        ybase = JKT_yminval + JKT_ymaxval*[xmin:xincr:xmax]'/xmax;
        jkt_y = repmat(ybase, 1, size(xx,2));
        jkt_y = jkt_y.^exponent;
        jkt_xy = jkt_x+jkt_y;
        jkt_xy = jkt_xy*min([JKT_xmaxval JKT_ymaxval])/max(max(jkt_xy));
        JKT_FIELD = jkt_xy;
        contourf(xx,yy,jkt_xy)
    case 'outmax_to_inmin'
        temperature = [2 -2 2 2];
        [JKT_FIELD1] = ConstructJKT_field_v1(JKT_bounds, x, y, 'x-min_to_x+max_and_y-min_to_y+max', {'power', 1, temperature(1), 'norm_max_yes'});
        [JKT_FIELD2] = ConstructJKT_field_v1(JKT_bounds, x, y, 'x-max_to_x+min_and_y-max_to_y+min', {'power', 1, temperature(2), 'norm_max_yes'});
        [JKT_FIELD3] = ConstructJKT_field_v1(JKT_bounds, x, y, 'x-min_to_x+max_and_y-max_to_y+min', {'power', 1, temperature(3), 'norm_max_yes'});
        [JKT_FIELD4] = ConstructJKT_field_v1(JKT_bounds, x, y, 'x-max_to_x+min_and_y-min_to_y+max', {'power', 1, temperature(4), 'norm_max_yes'});
        JKT_FIELD    = JKT_FIELD1 + JKT_FIELD2 + JKT_FIELD3 + JKT_FIELD4;
        JKT_FIELD    = JKT_FIELD*max([JKT_xmaxval JKT_ymaxval])/max(max(JKT_FIELD));
        contourf(xx,yy,JKT_FIELD)
        colorbar
    case 'outmin_to_inmax'
end
end
%00000000000000000000000000000000000000000000
% function  [jkt] = EstimateJKT(jkt, JKT_bounds, JKT_estimation_parameters_1)
% 
% DistributionBehaviour = JKT_estimation_parameters_1{1};
% constant              = JKT_estimation_parameters_1{2};
% exponent              = JKT_estimation_parameters_1{3};
% normalizetomax        = JKT_estimation_parameters_1{4};
% 
% JKT_xminval = JKT_bounds(1);
% JKT_xmaxval = JKT_bounds(2);
% JKT_yminval = JKT_bounds(3);
% JKT_ymaxval = JKT_bounds(4);
% 
% jkt_x = constant*jkt_x.^exponent;
% switch normalizetomax
%     case 'norm_max_yes'
%         jkt = jkt*min([JKT_xmaxval JKT_ymaxval])/max(max(jkt_x));
%     case 'norm_max_yes'
%         
% end
% end
% 
% end
%00000000000000000000000000000000000000000000