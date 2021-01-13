function f2d() % frontal 2d
% This function estimates grain sizes: grain surface area and grain perimeter
%% Read simulation information
latpar1       = dlmread(strcat(pwd,'\simparameters','\latpar.txt'));
slspinfo1     = dlmread(strcat(pwd,'\simparameters','\slspinfo.txt'));
icntinfo1     = dlmread(strcat(pwd,'\simparameters','\icntinfo.txt'));
slpclustinfo1 = dlmread(strcat(pwd,'\simparameters','\slpclustinfo.txt'));
simpar1       = dlmread(strcat(pwd,'\simparameters','\simpar.txt'));
ffo1          = dlmread(strcat(pwd,'\simparameters','\ffo.txt'));
cm            = dlmread(strcat(pwd,'\results','\colormatrix.txt'));
xmin  = latpar1(1); xmax  = latpar1(2); ymin  = latpar1(3);
ymax  = latpar1(4); xincr = latpar1(5); yincr = latpar1(6);
xlength = abs(xmin)+abs(xmax); ylength = abs(ymin)+abs(ymax);
[x,y]         = meshgrid(xmin:xincr:xmax,ymin:yincr:ymax);
q             = simpar1(1);
m             = simpar1(2);
wantslsp      = slspinfo1(1);
wantcnt       = icntinfo1(1);
wantslspclust = slpclustinfo1(1);
txtwriteint   = ffo1(1);
sz1           = size(x,1);
sz2           = size(x,2);
%% Estimate stateiq
for im = txtwriteint:txtwriteint:m
    stateim = dlmread(strcat(pwd,'\results','\datafiles','\statematrices','\s',num2str(im),'mcs1','.txt'));
    for iq = 1:q
        stateiq{1,iq} = zeros(sz1,sz2);
        temp = repmat(iq,sz1,sz2);
        stateiq{1,iq}(stateim==temp) = iq;
    end
end
%% Find individual grains
for im = txtwriteint:txtwriteint:m
    for iq = 1:q
        matrix = stateiq{1,iq};
        [grains] = fg2d(matrix,x,y);
        
    end
end
end