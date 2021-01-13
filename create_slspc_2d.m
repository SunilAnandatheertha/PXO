function create_slspc_2d()

global Lattice zenerindices zslsp zslspc

wantslsp              = Lattice.zener.slsp.want_slsp;
wantslspclust         = Lattice.zener.slspc.want_slspc;
slspc_type            = Lattice.zener.slspc.typeofcluster;
slspc_distribution    = Lattice.zener.slspc.clusterdistr;
noslspclusters        = Lattice.zener.slspc.noslspclusters;
islspcvf              = Lattice.zener.slspc.islspcvf;
radiusfactorforcircle = Lattice.zener.slspc.radiusfactorforcircle;
cif                   = Lattice.zener.slspc.cif;

x                     = Lattice.size.x;
y                     = Lattice.size.y;
sz1                   = size(x,1);
sz2                   = size(x,2);
xmin                  = Lattice.size.xmin;
xmax                  = Lattice.size.xmax;
ymin                  = Lattice.size.ymin;
ymax                  = Lattice.size.ymax;

CIRCLEATCENTER = 1;

if wantslspclust == 1
    if islspcvf > 0
        if radiusfactorforcircle > 0
            radius = radiusfactorforcircle*(abs(xmin)+abs(xmax));
            zslspc = cell(noslspclusters,1);
            for clust = 1:noslspclusters
                if CIRCLEATCENTER == 0
                    circlecenterx = randi([floor(cif*xmin) floor(cif*xmax)], 1);
                    circlecentery = randi([floor(cif*ymin) floor(cif*ymax)], 1);
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
                zslspctemp2 = [zslspctemp2; zslspc{count}];
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
% clear radius circlecenterx circlecentery i j distmat ind remove count1 count2 zslspctemp
end