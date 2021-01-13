close all; clear all
addpath('C:\Users\anandats\Dropbox\MATLAB codes\voronoigrainstructure\')
%------------------------------------
% Procure data from file (First line in the data file needs to be deleted before using)
    %[data] = Read_EBSD_Result_File('data_ti.txt');
    [data] = Read_EBSD_Result_File('data_AA7050_002_50pixels.txt');
%------------------------------------
% Primary   inputs
    dim = 2; % Dimensions - 2 or 3
% Secondary inputs
    plotvororiginal = 0;
%------------------------------------
% CALCULATIONS
    [x, v, c] = create_voronoi([data{1,6} data{1,7}], dim);
    [vx, vy] = povor(x, plotvororiginal);
    [c_new, x_new, Terminate, Retain] = CalculateReducedVoronoi(x, v, c);
    
    [GrainArea]        = CalculateGrainArea(c_new, v);
    [GrainSize]        = CalculateGrainSize(GrainArea);
    [Grains]           = AssembleGrainData(x_new, v, c_new, GrainArea, GrainSize, data, Terminate, Retain);
%------------------------------------
% SYNTHETIC DATA
close
xmin = 0; xmax = 1;

haha0 = 40; % Near to lsp surface
xstretch = 1;
xx0 = xmin + xmax*xstretch*rand(haha0*haha0,1);
yy0 = 0.2*rand(haha0*haha0,1);
phi1min0 = 50; phi1max0 = 55;
phi2min0 = 70; phi2max0 = 80;
psimin0  = 150; psimax0 = 170;
phi1_0 = phi1min0 + (phi1max0-phi1min0)*rand(size(xx0));
phi2_0 = phi2min0 + (phi2max0-phi2min0)*rand(size(xx0));
psi_0  = psimin0 + (psimax0-psimin0)*rand(size(xx0));

haha1 = 20;
xx1 = xmin + xmax*xstretch*rand(haha1*haha1,1);
yy1 = max(yy0)+0.4*rand(haha1*haha1,1);
phi1min1 = 80; phi1max1 = 90;
phi2min1 = 30; phi2max1 = 80;
psimin1 = 110; psimax1 = 170;
phi1_1 = phi1min1 + (phi1max1-phi1min1)*rand(size(xx0));
phi2_1 = phi2min1 + (phi2max1-phi2min1)*rand(size(xx0));
psi_1  = psimin1  + (psimax1 -psimin1)*rand(size(xx0));

haha2 = 10;
xx2 = xmin + xmax*xstretch*rand(haha2*haha2,1);
yy2 = max(yy1)+0.4*rand(haha2*haha2,1);
phi1min2 = 80; phi1max2 = 90;
phi2min2 = 30; phi2max2 = 80;
psimin2= 110; psimax2 = 160;
phi1_2 = phi1min2 + (phi1max2-phi1min2)*rand(size(xx0));
phi2_2 = phi2min2 + (phi2max2-phi2min2)*rand(size(xx0));
psi_2  = psimin2  + (psimax2 -psimin2)*rand(size(xx0));

xxdata = 1*vertcat(xx0, xx1, xx2);
yydata = vertcat(yy0, yy1, yy2);

phi1data = vertcat(phi1_0, phi1_1, phi1_2);
phi2data = vertcat(phi2_0, phi2_1, phi2_2);
psidata = vertcat(psi_0, psi_1, psi_2);

plot(xx0,yy0,'k.')
axis equal; axis tight
hold on
plot(xx1,yy1,'r.')
plot(xx2,yy2,'g.')

    [x, v, c] = create_voronoi([xxdata yydata], dim);
    [vx, vy] = povor(x, plotvororiginal);
    [c_new, x_new, Terminate, Retain] = CalculateReducedVoronoi(x, v, c);
    
    [GrainArea]        = CalculateGrainArea(c_new, v);
    [GrainSize]        = CalculateGrainSize(GrainArea);
    [Grains]           = AssembleGrainData(x_new, v, c_new, GrainArea, GrainSize, data, Terminate, Retain);
    hold on
% RESULTS: graphics. SEE END FOR DESCRIPTIONS. [GO] = GR(TC, I, GC)
    GR({'GSF'},...
       {x, v, c_new, x_new},...
       {'docked', 'axisscalefactor0.00'});
hold on
stem3(x_new(:,1), x_new(:,2), GrainArea, 'LineStyle',':', 'MarkerFaceColor','red', 'MarkerEdgeColor','k', 'MarkerSize', 4)
stem3(x_new(:,1), x_new(:,2), GrainSize, 'LineStyle',':', 'MarkerFaceColor','red', 'MarkerEdgeColor','k', 'MarkerSize', 4)
axis square
box on
grid off
view(80,20)
xlabel('x-axis')
ylabel('y-axis')
zlabel('Grain size, units')

figure(2)
%histogramof = GrainArea;
histogramof = GrainSize;
hst = histogram(histogramof);
%xlabel('Grain area, sq. units')
xlabel('Grain size')
ylabel('Count')
title(strcat('Number of Grains = ', num2str(numel(GrainArea))))

figure(3)
close
binsize = 10;
histogram(phi1_2, binsize, 'normalization', 'probability'); hold on
histogram(phi2_2, binsize, 'normalization', 'probability');
histogram(psi_2 , binsize, 'normalization', 'probability');
legend('phi1', 'phi2', 'psi')
xlabel('Euler angles'); ylabel('Probability'); title(strcat('Number of Grains = ', num2str(numel(GrainArea))))
axis([0 180 0 0.15]); axis square



%------------------------------------
% RESULTS: graphics. SEE END FOR DESCRIPTIONS. [GO] = GR(TC, I, GC)
    GR({'GSF'},...
       {x, v, c_new, x_new},...
       {'docked', 'axisscalefactor0.00'});
%     print('-djpeg100', strcat(pwd, '\GS2d_voronoi_reduced.jpeg'))
%     GR({'STGSH'},...
%        {GrainSize},...
%        {ceil(sqrt(size(x,1))), [0.00 0.5 0.5    0 0 0], 'docked', 'printjpeg_yes', 'printeps_yes'});
%------------------------------------
%------------------------------------
% CONSTRUCT BOUNDING RECTANGLES

ags = sum(GrainSize)/numel(GrainSize); % average grain size
ogsf = 1.0;% Grain size factor for outer rectangle
igsf = 2.0;% Grain size factor for inner rectangle
% Calculate and plot outer rectangle
orec = [min(x_new(:, 1))-ogsf*ags max(x_new(:, 1))+ogsf*ags min(x_new(:, 2))-ogsf*ags min(x_new(:, 2))+ogsf*ags;
        max(x_new(:, 1))+ogsf*ags max(x_new(:, 1))+ogsf*ags min(x_new(:, 2))-ogsf*ags max(x_new(:, 2))+ogsf*ags;
        max(x_new(:, 1))+ogsf*ags min(x_new(:, 1))-ogsf*ags max(x_new(:, 2))+ogsf*ags max(x_new(:, 2))+ogsf*ags;
        min(x_new(:, 1))-ogsf*ags min(x_new(:, 1))-ogsf*ags max(x_new(:, 2))+ogsf*ags min(x_new(:, 2))-ogsf*ags];
plot([orec(:,1) orec(:,2)], [orec(:,3) orec(:,4)], 'k', 'LineWidth', 3)
% Calculate and plot inner rectangle
irec = [min(x_new(:, 1))+igsf*ags max(x_new(:, 1))-igsf*ags min(x_new(:, 2))+igsf*ags min(x_new(:, 2))+igsf*ags;
        max(x_new(:, 1))-igsf*ags max(x_new(:, 1))-igsf*ags min(x_new(:, 2))+igsf*ags max(x_new(:, 2))-igsf*ags;
        max(x_new(:, 1))-igsf*ags min(x_new(:, 1))+igsf*ags max(x_new(:, 2))-igsf*ags max(x_new(:, 2))-igsf*ags;
        min(x_new(:, 1))+igsf*ags min(x_new(:, 1))+igsf*ags max(x_new(:, 2))-igsf*ags min(x_new(:, 2))+igsf*ags];
plot([irec(:,1) irec(:,2)], [irec(:,3) irec(:,4)], 'r', 'LineWidth', 3)
axis([min(x_new(:,1))-2*ogsf*ags max(x_new(:,1))+2*ogsf*ags min(x_new(:,2))-2*ogsf*ags max(x_new(:,2))+2*ogsf*ags])
%------------------------------------
% Identify search grains

Terminate = zeros(length(c_new), 1);
counti = 1;
for i = 1:length(c_new)
    if     sum(v(c_new{i}(1:numel(c_new{i})),1)'<min(x_new(:, 1))+igsf*ags)~=0
        Terminate(counti) = i; counti = counti+1;
    elseif sum(v(c_new{i}(1:numel(c_new{i})),1)'>max(x_new(:, 1))-igsf*ags)~=0
        Terminate(counti) = i; counti = counti+1;
    elseif sum(v(c_new{i}(1:numel(c_new{i})),2)'<min(x_new(:, 2))+igsf*ags)~=0
        Terminate(counti) = i; counti = counti+1;
    elseif sum(v(c_new{i}(1:numel(c_new{i})),2)'>max(x_new(:, 2))-igsf*ags)~=0
        Terminate(counti) = i; counti = counti+1;
    else
    end
end
Terminate(Terminate==0)=[];
% Retain = setdiff(1:1:numel(c_new),Terminate);
c_new1 = c_new(Terminate);
x_new1 = x_new(Terminate,:);

%plot(x_new1(:,1), x_new1(:,2), 'ks', 'MarkerFaceColor', 'y')

% Identify re-entrant grains
for i = 1:numel(c_new1)
    edges = [v(c_new{i}, 1) v(c_new{i}, 2)]; edges = [edges; edges(1,:)];
    nedges = size(edges,1);
end

box on
xlabel('x, microns')
ylabel('y, microns')
% axis equal
%------------------------------------
% RESULTS: numerics
%     fprintf('Total number of grains = %d \n', numel(c_new));
%------------------------------------
% VORGS: Voronoi Grain Structure
%------------------------------------
%------------------------------------