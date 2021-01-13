close
global Lattice
x = Lattice.size.x;
y = Lattice.size.y;
xincr = Lattice.size.i_incr;
yincr = Lattice.size.j_incr;

xc = x;
yc = y;

plot(x, y, 'c.', 'markersize', 12)
hold on
xbl = x-xincr/2; ybl = y-yincr/2;
xbr = x+xincr/2; ybr = y-yincr/2;
xbr(:,1:size(xbr,2)-1) = [];
ybr(:,1:size(ybr,2)-1) = [];
plot(xbl, ybl, 'b.')
plot(xbr, ybr, 'b.')

xtl = x-xincr/2; ytl = y+yincr/2;
xtl(1:size(xtl,1)-1,:)=[];
ytl(1:size(ytl,1)-1,:)=[];
plot(xtl, ytl, 'b.')

xtr = x+xincr/2; ytr = y+yincr/2;
xtr(1:size(xtr,1)-1,:)=[];
ytr(1:size(ytr,1)-1,:)=[];
xtr(1:end-1)=[];
ytr(1:end-1)=[];
plot(xtr, ytr, 'b.')

xl = x-xincr/2; yl = y;
plot(xl, yl, 'm.')
xr = x+xincr/2; yr = y;
xr(:,1:size(xr,2)-1)=[];
yr(:,1:size(yr,2)-1)=[];
plot(xr, yr, 'm.')

xb = x; yb = y - yincr/2;
plot(xb, yb, 'm.')
xt = x; yt = y + yincr/2;
xt(1:size(xr,1)-1,:)=[];
yt(1:size(yr,1)-1,:)=[];
plot(xt, yt, 'm.')

axis equal



% CPS3: 3-node linear plane stress triangle
% CPS6: 6-node quadratic plane stress triangle

element_Type = 'CPS6'; % CPS4, CPS4R, CPS8, CPS8R, CPS3, CPS6
tritype      = 'llur'; % llur, ullr, lurb
switch element_Type
    case {'CPS4', 'CPS4R'}
        nd_x = [xbl(:); xbr(:); xtl(:); xtr(:)];
        nd_y = [ybl(:); ybr(:); ytl(:); ytr(:)];
        nd_xy = unique([nd_x nd_y], 'rows');
        nd_x = nd_xy(:,1);
        nd_y = nd_xy(:,2);
        ElTable = zeros(numel(x),5);
    case {'CPS8', 'CPS8R'}
        nd_x = [xbl(:); xbr(:); xtl(:); xtr(:); xl(:); xr(:); xb(:); xt(:)];
        nd_y = [ybl(:); ybr(:); ytl(:); ytr(:); yl(:); yr(:); yb(:); yt(:)];
        nd_xy = unique([nd_x nd_y], 'rows');
        nd_x = nd_xy(:,1);
        nd_y = nd_xy(:,2);
        ElTable = zeros(numel(x), 9);
    case 'CPS3'
        switch tritype
            case {'llur', 'ullr'}
                nd_x = [xbl(:); xbr(:); xtl(:); xtr(:)];
                nd_y = [ybl(:); ybr(:); ytl(:); ytr(:)];
                nd_xy = unique([nd_x nd_y], 'rows');
                nd_x = nd_xy(:,1);
                nd_y = nd_xy(:,2);
                ElTable = zeros(2*numel(x),4);
            case 'lurb'
                nd_x = [xbl(:); xbr(:); xtl(:); xtr(:); x(:)];
                nd_y = [ybl(:); ybr(:); ytl(:); ytr(:); y(:)];
                nd_xy = unique([nd_x nd_y], 'rows');
                nd_x = nd_xy(:,1);
                nd_y = nd_xy(:,2);
        end
    case 'CPS6'
        switch tritype
            case {'llur', 'ullr'}
                nd_x = [xbl(:); xbr(:); xtl(:); xtr(:); xl(:); xr(:); xb(:); xt(:); x(:)];
                nd_y = [ybl(:); ybr(:); ytl(:); ytr(:); yl(:); yr(:); yb(:); yt(:); y(:)];
                nd_xy = unique([nd_x nd_y], 'rows');
                nd_x = nd_xy(:,1);
                nd_y = nd_xy(:,2);
                ElTable = zeros(numel(x), 7);
            case 'lurb'
                nd_x = [xbl(:); xbr(:); xtl(:); xtr(:); x(:)];
                nd_y = [ybl(:); ybr(:); ytl(:); ytr(:); y(:)];
                nd_xy = unique([nd_x nd_y], 'rows');
                nd_x = nd_xy(:,1);
                nd_y = nd_xy(:,2);
        end
    otherwise
        disp('invalid element type input. Creating 4-node quad')
        nd_x = [xbl(:); xbr(:); xtl(:); xtr(:)];
        nd_y = [ybl(:); ybr(:); ytl(:); ytr(:)];
        nd_xy = unique([nd_x nd_y], 'rows');
        nd_x = nd_xy(:,1);
        nd_y = nd_xy(:,2);
end

% plot(nd_x, nd_y, 'co')

enum = reshape(1:numel(x), size(x));
% for count = 1:numel(x)
%    text(x(count), y(count), num2str(enum(count)), 'fontweight', 'bold', 'color', 'r', 'fontsize', 8)
% end

switch element_Type
    case {'CPS8', 'CPS4'}
        for count = 1:numel(x)
            enumcount = count;
            xe = x(enumcount);
            ye = y(enumcount);
            % ebox: element bounding box
            xfactor = 1.2*xincr/2;
            yfactor = 1.2*yincr/2;
            ebbox_x = xe + xfactor*[-1 +1 +1 -1];
            ebbox_y = ye + yfactor*[-1 -1 +1 +1];
            % plot(ebbox_x, ebbox_y, 'ks', 'markerfacecolor', 'k')
% % % % %             left_x  = find(nd_x>ebbox_x(1));
% % % % %             right_x = find(nd_x<ebbox_x(2));
% % % % %             top_y   = find(nd_y>ebbox_y(1));
% % % % %             bot_y   = find(nd_y<ebbox_y(3));
% % % % %             subset  = intersect(intersect(intersect(left_x, right_x), top_y), bot_y);
            left_x  = nd_x>ebbox_x(1);
            right_x = nd_x<ebbox_x(2);
            top_y   = nd_y>ebbox_y(1);
            bot_y   = nd_y<ebbox_y(3);
            subset  = find(left_x.*right_x.*top_y.*bot_y==1);
            ElTable(count,:) = [count subset'];
            subsetxy = unique([nd_x(subset) nd_y(subset)], 'rows');
            plot(subsetxy(:,1), subsetxy(:,2), 'r*', 'markersize', 4)
            

            k = boundary(subsetxy(:,1), subsetxy(:,2));
            subset = subset(k);
            subsetxy = unique([nd_x(subset) nd_y(subset)], 'rows');
%             plot(subsetxy(:,1), subsetxy(:,2), 'bx', 'markersize', 10, 'linewidth', 2)%, 'markerfacecolor', rand(1,3))
%             ElTable(2*count,:) = [2*count subsetxy'];
            patch(nd_x(subset), nd_y(subset), 'b')

            
            
%             subsetxy = [subsetxy(k,1) subsetxy(k,2)];
%             patch(subsetxy(:,1), subsetxy(:,2))
%             patch(nd_x(ll_subset), nd_y(ll_subset), 'b')
            pause(0.001)
        end
        NodeMatrix = [transpose(1:numel(nd_x)) nd_x nd_y];
%         *Element, type=CPS8
    case 'CPS3'
        for count = 1:numel(x)
            enumcount = count;
            xe = x(enumcount);
            ye = y(enumcount);
            % ebox: element bounding box
            xfactor = 1.2*xincr/2;
            yfactor = 1.2*yincr/2;
            ebbox_x = xe + xfactor*[-1 +1 +1 -1];
            ebbox_y = ye + yfactor*[-1 -1 +1 +1];
            % plot(ebbox_x, ebbox_y, 'ks', 'markerfacecolor', 'k')
            
            switch tritype
                case 'llur' % lower left upper right
                    left_x  = (nd_x>ebbox_x(1)).*(nd_x<x(count));
                    left_y  = (nd_y>ebbox_y(1)).*(nd_y<ebbox_y(3));
                    right_x = (nd_x<ebbox_x(2)).*(nd_x>x(count));
                    right_y = (nd_y>ebbox_y(1)).*(nd_y<y(count));
                    ll_subset_a = find(left_x.*left_y==1);
                    ll_subset_b = find(right_x.*right_y==1);
                    ll_subset = [ll_subset_a; ll_subset_b];
                    llsubsetxy = unique([nd_x(ll_subset) nd_y(ll_subset)], 'rows');
%                     plot(llsubsetxy(:,1), llsubsetxy(:,2), 'kx', 'markersize', 13, 'linewidth', 2)%, 'markerfacecolor', rand(1,3))
                    pause(0.001)
                    ElTable(2*count-1,:) = [2*count-1 ll_subset'];
                    patch(nd_x(ll_subset), nd_y(ll_subset), 'c')
                    
                    right_x = (nd_x<ebbox_x(2)).*(nd_x>x(count));
                    right_y = (nd_y>ebbox_y(1)).*(nd_y<ebbox_y(3));
                    left_x  = (nd_x>ebbox_x(1)).*(nd_x<x(count));
                    left_y  = (nd_y>y(count)).*(nd_y<ebbox_y(3));
                    ur_subset_a = find(left_x.*left_y==1);
                    ur_subset_b = find(right_x.*right_y==1);
                    ur_subset = [ur_subset_a; ur_subset_b];
                    ursubsetxy = unique([nd_x(ur_subset) nd_y(ur_subset)], 'rows');
%                     plot(ursubsetxy(:,1), ursubsetxy(:,2), 'rx', 'markersize', 13, 'linewidth', 2)%, 'markerfacecolor', rand(1,3))
                    ElTable(2*count,:) = [2*count ll_subset'];
                    patch(nd_x(ur_subset), nd_y(ur_subset), 'c')
                    pause(0.001)
                    
                case 'ullr' % upper left lower right
                    left_x  = (nd_x>ebbox_x(1)).*(nd_x<x(count));
                    left_y  = (nd_y>ebbox_y(1)).*(nd_y<ebbox_y(3));
                    right_x = (nd_x<ebbox_x(2)).*(nd_x>x(count));
                    right_y = (nd_y>y(count)).*(nd_y<ebbox_y(3));
                    ll_subset_a = find(left_x.*left_y==1);
                    ll_subset_b = find(right_x.*right_y==1);
                    ll_subset = [ll_subset_a; ll_subset_b];
                    llsubsetxy = unique([nd_x(ll_subset) nd_y(ll_subset)], 'rows');
%                     plot(llsubsetxy(:,1), llsubsetxy(:,2), 'kx', 'markersize', 13, 'linewidth', 2)%, 'markerfacecolor', rand(1,3))
                    pause(0.001)
                    ElTable(2*count-1,:) = [2*count-1 ll_subset'];
                    patch(nd_x(ll_subset), nd_y(ll_subset), 'c')
                    
                    right_x = (nd_x<ebbox_x(2)).*(nd_x>x(count));
                    right_y = (nd_y>ebbox_y(1)).*(nd_y<ebbox_y(3));
                    left_x  = (nd_x>ebbox_x(1)).*(nd_x<x(count));
                    left_y  = (nd_y<y(count)).*(nd_y>ebbox_y(1));
                    ur_subset_a = find(left_x.*left_y==1);
                    ur_subset_b = find(right_x.*right_y==1);
                    ur_subset = [ur_subset_a; ur_subset_b];
                    ursubsetxy = unique([nd_x(ur_subset) nd_y(ur_subset)], 'rows');
%                     plot(ursubsetxy(:,1), ursubsetxy(:,2), 'rx', 'markersize', 13, 'linewidth', 2)%, 'markerfacecolor', rand(1,3))
                    ElTable(2*count,:) = [2*count ll_subset'];
                    patch(nd_x(ur_subset), nd_y(ur_subset), 'c')
                    pause(0.001)
                case 'lurb' % left up right bottom
                    left_x  = (nd_x>ebbox_x(1)).*(nd_x<x(count));
                    left_y  = (nd_y>ebbox_y(1)).*(nd_y<ebbox_y(3));
                    right_x = nd_x==x(count);
                    right_y = nd_y==y(count);
                    ll_subset_a = find(left_x.*left_y==1);
                    ll_subset_b = find(right_x.*right_y==1);
                    ll_subset = [ll_subset_a; ll_subset_b];
                    llsubsetxy = unique([nd_x(ll_subset) nd_y(ll_subset)], 'rows');
%                     plot(llsubsetxy(:,1), llsubsetxy(:,2), 'kx', 'markersize', 13, 'linewidth', 2)%, 'markerfacecolor', rand(1,3))
                    pause(0.001)
                    ElTable(2*count-1,:) = [2*count-1 ll_subset'];
                    patch(nd_x(ll_subset), nd_y(ll_subset), 'c')
                    
                    
                    
                    up_x  = (nd_x>ebbox_x(1)).*(nd_x<ebbox_x(2));
                    up_y  = (nd_y>y(count)).*(nd_y<ebbox_y(3));
                    down_x = nd_x==x(count);
                    down_y = nd_y==y(count);
                    ll_subset_a = find(up_x.*up_y==1);
                    ll_subset_b = find(down_x.*down_y==1);
                    ll_subset = [ll_subset_a; ll_subset_b];
                    llsubsetxy = unique([nd_x(ll_subset) nd_y(ll_subset)], 'rows');
%                     plot(llsubsetxy(:,1), llsubsetxy(:,2), 'rx', 'markersize', 13, 'linewidth', 2)%, 'markerfacecolor', rand(1,3))
                    pause(0.001)
                    ElTable(2*count-1,:) = [2*count-1 ll_subset'];
                    patch(nd_x(ll_subset), nd_y(ll_subset), 'b')
                    
                    
                    left_x  = nd_x==x(count);
                    left_y  = nd_y==y(count);
                    right_x = (nd_x>x(count)).*(nd_x<ebbox_x(2));
                    right_y = (nd_y>ebbox_y(1)).*(nd_y<ebbox_y(3));
                    ll_subset_a = find(left_x.*left_y==1);
                    ll_subset_b = find(right_x.*right_y==1);
                    ll_subset = [ll_subset_a; ll_subset_b];
                    llsubsetxy = unique([nd_x(ll_subset) nd_y(ll_subset)], 'rows');
%                     plot(llsubsetxy(:,1), llsubsetxy(:,2), 'gx', 'markersize', 13, 'linewidth', 2)%, 'markerfacecolor', rand(1,3))
                    pause(0.001)
                    ElTable(2*count-1,:) = [2*count-1 ll_subset'];
                    patch(nd_x(ll_subset), nd_y(ll_subset), 'm')


                    up_x   = nd_x==x(count);
                    up_y   = nd_y==y(count);
                    down_x = (nd_x>ebbox_x(1)).*(nd_x<ebbox_x(2));
                    down_y = (nd_y>ebbox_y(1)).*(nd_y<y(count));
                    ll_subset_a = find(up_x.*up_y==1);
                    ll_subset_b = find(down_x.*down_y==1);
                    ll_subset = [ll_subset_a; ll_subset_b];
                    llsubsetxy = unique([nd_x(ll_subset) nd_y(ll_subset)], 'rows');
%                     plot(llsubsetxy(:,1), llsubsetxy(:,2), 'yx', 'markersize', 13, 'linewidth', 2)%, 'markerfacecolor', rand(1,3))
                    
                    ElTable(2*count-1,:) = [2*count-1 ll_subset'];
                    patch(nd_x(ll_subset), nd_y(ll_subset), 'r')
                    
                    pause(0.001)
            end
%             pause(0.001)
        end
        NodeMatrix = [transpose(1:numel(nd_x)) nd_x nd_y];        
    case 'CPS6'
        for count = 1:numel(x)
            enumcount = count;
            xe = x(enumcount);
            ye = y(enumcount);
            % ebox: element bounding box
            xfactor = 1.2*xincr/2;
            yfactor = 1.2*yincr/2;
            ebbox_x = xe + xfactor*[-1 +1 +1 -1];
            ebbox_y = ye + yfactor*[-1 -1 +1 +1];
            % plot(ebbox_x, ebbox_y, 'ks', 'markerfacecolor', 'k')
            switch tritype
                case 'llur' % lower left upper right
                    left_x  = (nd_x>ebbox_x(1)).*(nd_x<x(count));
                    left_y  = (nd_y>ebbox_y(1)).*(nd_y<ebbox_y(3));
                    centre_x = (nd_x==x(count));
                    centre_y = (nd_y>ebbox_y(1)).*(nd_y<=y(count));
                    right_x = (nd_x<ebbox_x(2)).*(nd_x>x(count));
                    right_y = (nd_y>ebbox_y(1)).*(nd_y<y(count));
                    ll_subset_a = find(left_x.*left_y==1);
                    ll_subset_b = find(right_x.*right_y==1);
                    ll_subset_c = find(centre_x.*centre_y==1);
                    ll_subset = [ll_subset_a; ll_subset_c; ll_subset_b];
                    llsubsetxy = unique([nd_x(ll_subset) nd_y(ll_subset)], 'rows');
                    k = boundary(llsubsetxy(:,1), llsubsetxy(:,2));
                    ll_subset = ll_subset(k);
                    llsubsetxy = unique([nd_x(ll_subset) nd_y(ll_subset)], 'rows');
%                     plot(llsubsetxy(:,1), llsubsetxy(:,2), 'kx', 'markersize', 10, 'linewidth', 2)%, 'markerfacecolor', rand(1,3))
                    pause(0.001)
%                     ElTable(2*count-1,:) = [2*count-1 ll_subset'];
                    patch(nd_x(ll_subset), nd_y(ll_subset), 'c')
                    
                    left_x  = (nd_x>ebbox_x(1)).*(nd_x<x(count));
                    left_y  = (nd_y>y(count)).*(nd_y<ebbox_y(3));
                    centre_x = (nd_x==x(count));
                    centre_y = (nd_y>=y(count)).*(nd_y<ebbox_y(3));
                    right_x = (nd_x<ebbox_x(2)).*(nd_x>x(count));
                    right_y = (nd_y>ebbox_y(1)).*(nd_y<ebbox_y(3));
                    ll_subset_a = find(left_x.*left_y==1);
                    ll_subset_b = find(right_x.*right_y==1);
                    ll_subset_c = find(centre_x.*centre_y==1);
                    ll_subset = [ll_subset_a; ll_subset_c; ll_subset_b];
                    llsubsetxy = unique([nd_x(ll_subset) nd_y(ll_subset)], 'rows');
                    k = boundary(llsubsetxy(:,1), llsubsetxy(:,2));
                    ll_subset = ll_subset(k);
                    llsubsetxy = unique([nd_x(ll_subset) nd_y(ll_subset)], 'rows');
%                     plot(llsubsetxy(:,1), llsubsetxy(:,2), 'rx', 'markersize', 10, 'linewidth', 2)%, 'markerfacecolor', rand(1,3))
%                     ElTable(2*count,:) = [2*count ll_subset'];
                    patch(nd_x(ll_subset), nd_y(ll_subset), 'b')
                    pause(0.001)
                case 'ullr' % upper left lower right
                    left_x  = (nd_x>ebbox_x(1)).*(nd_x<x(count));
                    left_y  = (nd_y>ebbox_y(1)).*(nd_y<ebbox_y(3));
                    right_x = (nd_x<ebbox_x(2)).*(nd_x>x(count));
                    right_y = (nd_y>y(count)).*(nd_y<ebbox_y(3));
                    
%                     left_x   = (nd_x>ebbox_x(1)).*(nd_x<x(count));
%                     left_y   = (nd_y>ebbox_y(1)).*(nd_y<ebbox_y(3));
                    centre_x = (nd_x==x(count));
                    centre_y = (nd_y>=y(count)).*(nd_y<ebbox_y(3));
%                     right_x  = (nd_x>ebbox_x(1)).*(nd_x<ebbox_x(2));
%                     right_y  = (nd_y>ebbox_y(1)).*(nd_y<ebbox_y(3));

%                     left_x   = (nd_x>ebbox_x(1)).*(nd_x<x(count));
%                     left_y   = (nd_y>ebbox_y(1)).*(nd_y<ebbox_y(3));
%                     right_x  = (nd_x>x(count)).*(nd_x<ebbox_x(3));
%                     right_y  = (nd_y>y(count)).*(nd_y<ebbox_y(3));
                    ll_subset_a = find(left_x.*left_y==1);
                    ll_subset_b = find(right_x.*right_y==1);
                    ll_subset_c = find(centre_x.*centre_y==1);
                    ll_subset = [ll_subset_a; ll_subset_c; ll_subset_b];
                    llsubsetxy = unique([nd_x(ll_subset) nd_y(ll_subset)], 'rows');
                    k = boundary(llsubsetxy(:,1), llsubsetxy(:,2));
                    ll_subset = ll_subset(k);
                    llsubsetxy = unique([nd_x(ll_subset) nd_y(ll_subset)], 'rows');
%                     plot(llsubsetxy(:,1), llsubsetxy(:,2), 'kx', 'markersize', 10, 'linewidth', 2)%, 'markerfacecolor', rand(1,3))
                    pause(0.001)
%                     ElTable(2*count-1,:) = [2*count-1 ll_subset'];
                    patch(nd_x(ll_subset), nd_y(ll_subset), 'm')
                    
                    left_x   = (nd_x>ebbox_x(1)).*(nd_x<x(count));
                    left_y   = (nd_y<y(count)).*(nd_y>ebbox_y(1));
                    centre_x = (nd_x==x(count));
                    centre_y = (nd_y<=y(count)).*(nd_y>ebbox_y(1));
                    right_x  = (nd_x>x(count)).*(nd_x<ebbox_x(3));
                    right_y  = (nd_y>ebbox_y(1)).*(nd_y<ebbox_y(3));
                    ll_subset_a = find(left_x.*left_y==1);
                    ll_subset_b = find(right_x.*right_y==1);
                    ll_subset_c = find(centre_x.*centre_y==1);
                    ll_subset = [ll_subset_a; ll_subset_c; ll_subset_b];
                    llsubsetxy = unique([nd_x(ll_subset) nd_y(ll_subset)], 'rows');
                    k = boundary(llsubsetxy(:,1), llsubsetxy(:,2));
                    ll_subset = ll_subset(k);
                    llsubsetxy = unique([nd_x(ll_subset) nd_y(ll_subset)], 'rows');
%                     plot(llsubsetxy(:,1), llsubsetxy(:,2), 'bx', 'markersize', 10, 'linewidth', 2)%, 'markerfacecolor', rand(1,3))
%                     ElTable(2*count,:) = [2*count ll_subset'];
                    patch(nd_x(ll_subset), nd_y(ll_subset), 'b')
                    pause(0.001)
                case 'lurb' % left up right bottom
%                     left_x  = (nd_x>ebbox_x(1)).*(nd_x<x(count));
%                     left_y  = (nd_y>ebbox_y(1)).*(nd_y<ebbox_y(3));
%                     centre_x = (nd_x==x(count));
%                     centre_y = (nd_y<=y(count)).*(nd_y>ebbox_y(1));
%                     right_x = nd_x==x(count);
%                     right_y = nd_y==y(count);
%                     ll_subset_a = find(left_x.*left_y==1);
%                     ll_subset_b = find(right_x.*right_y==1);
%                     ll_subset_c = find(centre_x.*centre_y==1);
%                     ll_subset = [ll_subset_a; ll_subset_b; ll_subset_c];
%                     llsubsetxy = unique([nd_x(ll_subset) nd_y(ll_subset)], 'rows');
% %                     plot(llsubsetxy(:,1), llsubsetxy(:,2), 'kx', 'markersize', 13, 'linewidth', 2)%, 'markerfacecolor', rand(1,3))
%                     pause(0.001)
%                     ElTable(2*count-1,:) = [2*count-1 ll_subset'];
%                     patch(nd_x(ll_subset), nd_y(ll_subset), 'm')
%                     
%                     
%                     up_x  = (nd_x>ebbox_x(1)).*(nd_x<ebbox_x(2));
%                     up_y  = (nd_y>y(count)).*(nd_y<ebbox_y(3));
%                     centre_x = (nd_x==x(count));
%                     centre_y = (nd_y>=y(count)).*(nd_y<ebbox_y(3));
%                     down_x = nd_x==x(count);
%                     down_y = nd_y==y(count);
%                     ll_subset_a = find(up_x.*up_y==1);
%                     ll_subset_b = find(down_x.*down_y==1);
%                     ll_subset = [ll_subset_a; ll_subset_b];
%                     llsubsetxy = unique([nd_x(ll_subset) nd_y(ll_subset)], 'rows');
% %                     plot(llsubsetxy(:,1), llsubsetxy(:,2), 'rx', 'markersize', 13, 'linewidth', 2)%, 'markerfacecolor', rand(1,3))
%                     pause(0.001)
%                     ElTable(2*count-1,:) = [2*count-1 ll_subset'];
%                     patch(nd_x(ll_subset), nd_y(ll_subset), 'b')
%                     
%                     
%                     left_x  = nd_x==x(count);
%                     left_y  = nd_y==y(count);
%                     right_x = (nd_x>x(count)).*(nd_x<ebbox_x(2));
%                     right_y = (nd_y>ebbox_y(1)).*(nd_y<ebbox_y(3));
%                     ll_subset_a = find(left_x.*left_y==1);
%                     ll_subset_b = find(right_x.*right_y==1);
%                     ll_subset = [ll_subset_a; ll_subset_b];
%                     llsubsetxy = unique([nd_x(ll_subset) nd_y(ll_subset)], 'rows');
% %                     plot(llsubsetxy(:,1), llsubsetxy(:,2), 'gx', 'markersize', 13, 'linewidth', 2)%, 'markerfacecolor', rand(1,3))
%                     pause(0.001)
%                     ElTable(2*count-1,:) = [2*count-1 ll_subset'];
%                     patch(nd_x(ll_subset), nd_y(ll_subset), 'm')
% 
% 
%                     up_x   = nd_x==x(count);
%                     up_y   = nd_y==y(count);
%                     down_x = (nd_x>ebbox_x(1)).*(nd_x<ebbox_x(2));
%                     down_y = (nd_y>ebbox_y(1)).*(nd_y<y(count));
%                     ll_subset_a = find(up_x.*up_y==1);
%                     ll_subset_b = find(down_x.*down_y==1);
%                     ll_subset = [ll_subset_a; ll_subset_b];
%                     llsubsetxy = unique([nd_x(ll_subset) nd_y(ll_subset)], 'rows');
% %                     plot(llsubsetxy(:,1), llsubsetxy(:,2), 'yx', 'markersize', 13, 'linewidth', 2)%, 'markerfacecolor', rand(1,3))
%                     
%                     ElTable(2*count-1,:) = [2*count-1 ll_subset'];
%                     patch(nd_x(ll_subset), nd_y(ll_subset), 'r')
%                     
%                     pause(0.001)
            end
        end
    otherwise
        disp('Invalid input')
end

% for count = 1:size(NodeMatrix,1)
%    text(NodeMatrix(count,2), NodeMatrix(count,3), num2str(NodeMatrix(count,1)), 'fontweight', 'bold', 'color', 'g', 'fontsize', 8)
% end

Strings_02 = {'*Element, type='; element_Type};
axis equal
axis tight

