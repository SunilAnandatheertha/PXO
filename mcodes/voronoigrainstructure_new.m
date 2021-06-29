DataFolder = 'C:\Users\anandats\OneDrive - Coventry University\coventry-thesis\MATLAB codes\Grain_Structure_data_Repository\';
%----------------------------------------------
rng(1)
type = 'random';
switch type
    case 'random'
    startx  = 0;
    starty  = 0;
    lengthx = 5;
    widthy  = 5;
    Nopoints_i = 10;
    Nopoints_j = 10;
    xscale = 1.0; % not equal to zero
    yscale = 1.0; % not equal to zero
    origshiftx = +0.0;
    origshifty = +0.0;

    bs_ext = [startx  starty;
              lengthx starty;
              lengthx widthy;
              startx  widthy;
              startx  starty];


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

        bs_ext = [startx  starty;
                  lengthx starty;
                  lengthx widthy;
                  startx  widthy;
                  startx  starty];
end
%----------------------------------------------

%----------------------------------------------
randomfilenumber = num2str(randi(1e10));

unscaledfilename_x = [DataFolder randomfilenumber '_xoriginal_unscaled_2dvor.txt'];
unscaledfilename_y = [DataFolder randomfilenumber '_yoriginal_unscaled_2dvor.txt'];

dlmwrite(unscaledfilename_x, xorig, '-append', 'delimiter', ',', 'roffset', 0)
dlmwrite(unscaledfilename_y, yorig, '-append', 'delimiter', ',', 'roffset', 0)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Set the scale/. Greater the values, lesser
% will be the number of grains

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
scaledfilename_x = [DataFolder randomfilenumber '_xoriginal_scaled_2dvor.txt'];
scaledfilename_y = [DataFolder randomfilenumber '_yoriginal_scaled_2dvor.txt'];

dlmwrite(scaledfilename_x, x, '-append', 'delimiter', ',', 'roffset', 0)
dlmwrite(scaledfilename_y, y, '-append', 'delimiter', ',', 'roffset', 0)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
x = x(:);
y = y(:);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[v, c, xy] = VoronoiLimit(x, y, 'bs_ext', bs_ext);
axis equal
hold on
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% maxsize = [];
xdata = v(:,1); ydata = v(:,2);

ax = ones(size(xdata));
ay = ones(size(ydata));

ax(xdata == min(xdata)) = 0;
ax(xdata == max(xdata)) = 0;
ay(ydata == min(ydata)) = 0;
ay(ydata == max(ydata)) = 0;

plot(xdata(ax==0), ydata(ax==0), 'kx')
plot(xdata(ay==0), ydata(ay==0), 'gx')

for count = 1:size(c, 1)
% %     for countint = 1:size(c{count},1)
        %xdata = v(c{count}(:),1);
        maxsize = [maxsize; numel(c{count})];
        %ydata = v(c{count}(:),2);
% %         plot(v(c{count}(countint),1), v(c{count}(countint),2), 'ks', ...
% %             'markerfacecolor', rand(1,3), 'markersize', 15)
% %         pause(0.001)
% %     end
%     dlmwrite('xdata.txt', xdata', '-append', 'delimiter', ',', 'roffset', 0)
%     dlmwrite('ydata.txt', ydata', '-append', 'delimiter', ',', 'roffset', 0)
end
xdata = repmat(999, size(maxsize,1), max(maxsize));
ydata = repmat(999, size(maxsize,1), max(maxsize));

centroids = zeros(size(c,1),2);

for count = 1:size(c, 1)
    xtemp = v(c{count}(:),1)';
    ytemp = v(c{count}(:),2)';
    xdata(count,1:numel(xtemp)) = xtemp;
    ydata(count,1:numel(ytemp)) = ytemp;
    centroids(count,:) = [sum(xtemp)/numel(xtemp) sum(ytemp)/numel(ytemp)];
end

xdata = round(xdata, 4);
ydata = round(ydata, 4);

filename = [DataFolder randomfilenumber ];


VorData_filename_x = [DataFolder randomfilenumber '_x_data_tess_2dvor.txt'];
VorData_filename_y = [DataFolder randomfilenumber '_y_data_tess_2dvor.txt'];
VorData_filename_c = [DataFolder randomfilenumber '_c_data_tess_2dvor.txt'];

dlmwrite(VorData_filename_x, xdata, '-append', 'delimiter', ',', 'roffset', 0)
dlmwrite(VorData_filename_y, ydata, '-append', 'delimiter', ',', 'roffset', 0)
dlmwrite(VorData_filename_c, centroids, '-append', 'delimiter', ',', 'roffset', 0)

dlmwrite(scaledfilename_x, x, '-append', 'delimiter', ',', 'roffset', 0)
dlmwrite(scaledfilename_y, y, '-append', 'delimiter', ',', 'roffset', 0)


haha = dlmread('xdata.txt');
hihi = dlmread('ydata.txt');
hoho = dlmread('centroid_xy.txt');
hold on

% figure
% hold on
% for count = 1:size(c, 1)
%     for countint = 1:size(c{count},1)
%         xdata = v(c{count}(:),1);
%         ydata = v(c{count}(:),2);
%         plot(v(c{count}(countint),1), v(c{count}(countint),2), 'ks', ...
%             'markerfacecolor', rand(1,3), 'markersize', 15)
%         pause(0.001)
%     end
% end

axis equal
xlim([min(x) max(x)])
ylim([min(y) max(y)])
hold on
plot(centroids(:, 1), centroids(:, 2), 'go', 'markerfacecolor', 'g')

fprintf('Original unscaled random point x-data is stored in %s\n', unscaledfilename_x)
fprintf('Original unscaled random point y-data is stored in %s\n', unscaledfilename_y)
fprintf('%s is the random file number index \n', randomfilenumber)

titlehandle = get(gca, 'Title'); 
titlehandle.String = [];
Imnagefilename = [DataFolder randomfilenumber '_2dVorTesselation.jpeg'];
axis([startx lengthx starty widthy])

print('-djpeg100', [Imnagefilename])

readmefilename = '_ReadMe_Information.txt';
fileinforeadme{1} = 'This is a test file output.';
fileinforeadme{2} = 'The values will be used in a more...';
fileinforeadme{3} = 'regourous manner once the entire model...';
fileinforeadme{4} = 'has been calinbraed';
fileinforeadme{5} = '-------------------';
fileinforeadme{6} = ['there are __' num2str(size(centroids,1)) '__grains in this model'];
for count = 1:numel(fileinforeadme)
    dlmwrite([DataFolder randomfilenumber readmefilename], fileinforeadme{count}, '-append', 'delimiter', '', 'precision', '%10.4f')
end


fprintf('%s number of grains\n', num2str(size(centroids,1)))
% axis off