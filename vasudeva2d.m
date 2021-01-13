% function [zenerindices,zslsp,zslspc,ZELLIPSE,cntele,zcnt,xy] = vasudeva(xmin, xmax, ymin, ymax, xincr, yincr, sz1, sz2, e, x, y, wantslsp, zener, CNTINFO, CLUSTERINFO)
% vasudeva(sz1, sz2, e, x, y, wantslsp, zener, CNTINFO, CLUSTERINFO)
function [zenerindices,zslsp,zslspc,cntele,zcnt,cntxythetainfo] = vasudeva2d(latpar, x, y, e, slspinfo, icntinfo, clusterinfo, runfuncvasudeva)


%% variable allocation
xmin                     = latpar{1}{1};
xmax                     = latpar{1}{2};
ymin                     = latpar{1}{3};
ymax                     = latpar{1}{4};
xincr                    = latpar{1}{5};
yincr                    = latpar{1}{6};

wantslsp                 = slspinfo{1}{1};
z1vf                     = slspinfo{1}{2};

wantcnt                  = icntinfo{1}{1};
overlaycntsinlatticeplot = icntinfo{1}{10};

wantslspclust            = clusterinfo{1}{1}{1}{1};
typeofcluster            = clusterinfo{1}{1}{1}{2};
noslspclusters           = clusterinfo{1}{1}{1}{3};
clusterdistr             = clusterinfo{1}{1}{1}{4};
islspcvf                 = clusterinfo{1}{1}{1}{5};
radiusfactorforcircle    = clusterinfo{1}{1}{1}{6};
sz1                      = size(x,1);
sz2                      = size(x,2);
dlmwrite(strcat(pwd,'\which2plstoplot.txt'),[wantslsp wantcnt wantslspclust],'delimiter','\t')% 2pls-which 2ndary phase lattice sites to plot
%% KEY VARIABLES
zslsp   = []; % zslsp  - zener single lattice site particles
zcnt    = []; % zcnt   - zener carbon nano tubes
zenerindices = [];
%% Single Lattice Site Particles
if wantslsp == 1
    z1np  = floor(numel(e) * z1vf/100);     % Number of Type 1 zener particles(i.e., z1)
    zslsp = floor(1+numel(e)*rand(z1np,1)); % Element numbers of z1
elseif wantslsp == 0
    zslsp = -1;
end
zenerindices = [zenerindices; zslsp];
clear z1np
%% Single Lattice Site Particles Cluster islspcvf

CIRCLEATCENTER = 1;

if wantslspclust == 1
    if islspcvf > 0
        if radiusfactorforcircle > 0
            radius = radiusfactorforcircle*(abs(xmin)+abs(xmax));
            zslspc = cell(noslspclusters,1);
            for clust = 1:noslspclusters
                cif = 0.975; %clusterinsidefactor
                if CIRCLEATCENTER == 0
                    circlecenterx = randi([floor(cif*xmin) floor(cif*xmax)],1);
                    circlecentery = randi([floor(cif*ymin) floor(cif*ymax)],1);
                elseif CIRCLEATCENTER == 1
                    circlecenterx = 0;
                    circlecentery = 0;
                end
                i = floor(sz1/2) + floor(circlecenterx);
                j = floor(sz2/2) + floor(circlecentery);
                distmat = sqrt((x(i,j)-x).^2 + (y(i,j)-y).^2);
                ind = find(distmat<=radius);
                zslspctemp = ind(rand(size(ind)) <= repmat(islspcvf/100,size(ind,1),size(ind,2)));
                if wantslsp == 1 % This loop removes points common to slsp AND slspc
                    remove = [];
                    for count1 = 1:numel(zslspctemp)
                        for count2 = 1:numel(zslsp)
                            if zslspctemp(count1)==zslsp(count2)
                                remove = [remove; count2];
                            end
                        end
                    end
                    zslspctemp(remove)=[]; % thus common points are removed from zslsp
                end
                zslspc{clust,1} = zslspctemp;
%                 plot(x(zslspc{clust,1}),y(zslspc{clust,1}),'r.')
                dlmwrite(strcat(pwd,'\results\datafiles\e\slspce\slspcNo_', num2str(clust),'.txt'), zslspc{clust,1})
            end
            zslspctemp2 = [];
            for count = 1:size(zslspc,1)
                zslspctemp2 = [zslspctemp2;zslspc{count}];
            end
            zenerindices = [zenerindices; zslspctemp2];
        else
            zslspc = -1;
        end
    end
elseif wantslspclust == 0
    zslspc = -1;
    zenerindices = [zenerindices; zslspc];
end
clear radius circlecenterx circlecentery i j distmat ind remove count1 count2 zslspctemp
%%  CARBON NANO-TUBES
if wantcnt == 1
[cntele,cntxythetainfo] = createCNTs2d(latpar,icntinfo);
    for count = 1:numel(cntele) % THIS WHOLE LOOP CAN GO INSIDE the function - 'creatCNTs'
        zcnt = [zcnt; cntele{count}(:)];
    end
    zenerindices = [zenerindices; zcnt];
else
    cntele         = -1;
    zcnt           = -1;
    cntxythetainfo = -1;
    zenerindices = [zenerindices; zcnt];
end
clear count
% %% form 'zenerindices' variable
% if numel(zenerindices)==0
%     zenerindices = [-1E4 -2E4];
% end

end