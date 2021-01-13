function [x,y,z,s,e,secondaryphaseinfo] = im3d(latpar,simpar,slspinfo,icntinfo,clusterinfo)
%<><><><><><><><><><><><><><><><><><>
%<><><><><><><><><><><><><><><><><><>
xmin            = latpar{1}{1};
xmax            = latpar{1}{2};
ymin            = latpar{1}{3};
ymax            = latpar{1}{4};
zmin            = latpar{1}{5};
zmax            = latpar{1}{6};
xincr           = latpar{1}{7};
yincr           = latpar{1}{8};
zincr           = latpar{1}{9};
q               = simpar{1}{1};
wantslsp        = slspinfo{1}{1};
volumefrac_slsp = slspinfo{1}{2};
wantcnt         = icntinfo{1}{1};
noofcnt         = icntinfo{1}{2};
slpclustinfo    = clusterinfo{1}{1};
wantslspclust   = slpclustinfo{1}{01};
noslspclusters  = slpclustinfo{1}{03};
islspcvf        = slpclustinfo{1}{05};
radiusfactorforcircle = slpclustinfo{1}{06};
%<><><><><><><><><><><><><><><><><><>
[x,y,z] = meshgrid(xmin:xincr:xmax,ymin:yincr:ymax,zmin:zincr:zmax);
%<><><><><><><><><><><><><><><><><><>
sz1 = size(x,1);
sz2 = size(x,2);
sz3 = size(x,3);
s = floor(1+q*rand(sz1,sz2,sz3)); % state matrix
e = reshape(1:numel(s),sz1,sz2,sz3); % element number matrix
cm = rand(q,3);

dlmwrite(strcat(pwd,'\results','\datafiles','\statematrices','\initialsmatrix.txt'),s,'delimiter','\t')
% s = ipermute(reshape(s,sz1,sz2,sz3),[3,2,1]); USE this AFTER DLMREAD OF S. IT CONVERTS 2D ARRAY TO 3D ARRAY

dlmwrite(strcat(pwd,'\results','\datafiles', '\e','\elemnummat.txt'),e,'delimiter','\t')
dlmwrite(strcat(pwd,'\results','\colormatrix.txt'),cm,'delimiter','\t')
%<><><><><><><><><><><><><><><><><><>
dlmwrite(strcat(pwd,'\results','\datafiles', '\coordinates','\x.txt'),x,'delimiter','\t')
dlmwrite(strcat(pwd,'\results','\datafiles', '\coordinates','\y.txt'),y,'delimiter','\t')
dlmwrite(strcat(pwd,'\results','\datafiles', '\coordinates','\z.txt'),z,'delimiter','\t')
dlmwrite(strcat(pwd,'\results','\datafiles', '\e','\e.txt'),e,'delimiter','\t')
%<><><><><><><><><><><><><><><><><><>
runfuncvasudeva = zeros(3,1);
if wantslsp*volumefrac_slsp > 0
    runfuncvasudeva(1) = 1;
else
    runfuncvasudeva(1) = 0;
end
%<><><><><><><><><><><><><><><><><><>
if wantcnt*noofcnt ~= 0
    runfuncvasudeva(2) = 1;
else
    runfuncvasudeva(2) = 0;
end
%<><><><><><><><><><><><><><><><><><>
if wantslspclust*noslspclusters*islspcvf*radiusfactorforcircle > 0
    runfuncvasudeva(3) = 1;
else
    runfuncvasudeva(3) = 0;
end
%<><><><><><><><><><><><><><><><><><>
if sum(runfuncvasudeva) ~= 0
    disp('Creating secondary phase particles')
    %<><><><><><><><><><><><><><><><><><>
    %<><><><><><><><><><><><><><><><><><>
    [zenerindices,zslsp,zslspc,cntele,zcnt,cntxythetainfo] = vasudeva3d(latpar,x,y,z,e,slspinfo,icntinfo,clusterinfo);
    %<><><><><><><><><><><><><><><><><><>
    %<><><><><><><><><><><><><><><><><><>
    dlmwrite(strcat(pwd,'\results','\datafiles', '\e','\zener_indices.txt'), zenerindices,'delimiter','\t')
    dlmwrite(strcat(pwd,'\results','\datafiles', '\e','\zener_allover.txt'), zslsp,'delimiter','\t')
    dlmwrite(strcat(pwd,'\results','\datafiles', '\e','\zener_solidcircles.txt'), zslspc,'delimiter','\t')
    if runfuncvasudeva(2)==1
        dlmwrite(strcat(pwd,'\results','\datafiles','\e', '\ZCarbonNanoTubes.txt'), zcnt,'delimiter','\t')
    end
    if wantcnt ~= 0
        for count = 1:noofcnt
            dlmwrite(strcat(pwd,'\results','\datafiles', '\e','\cntele','\cntele', num2str(count),'.txt'), cntele{count},'delimiter','\t')
        end
    end
elseif sum(runfuncvasudeva) == 0
    % Some negative values for the following. Just to know there are no Z particles
    zslsp          = -1;
    zslspc         = -1;
    cntele         = -1;
    zcnt           = -1;
    zenerindices   = [zslsp;...
                      zslspc;...
                      zcnt];
    cntxythetainfo = -1;
    dlmwrite(strcat(pwd,'\results','\datafiles','\e', '\zener_indices.txt'),zenerindices, 'delimiter','\t')
    dlmwrite(strcat(pwd,'\results','\datafiles','\e', '\zener_allover.txt'),zslsp, 'delimiter','\t')
    dlmwrite(strcat(pwd,'\results','\datafiles','\e', '\zener_solidcircles.txt'),zslspc, 'delimiter','\t')
    dlmwrite(strcat(pwd,'\results','\datafiles','\e', '\ZCarbonNanoTubes.txt'),zcnt, 'delimiter','\t')
    if wantcnt ~= 0
        if noofcnt ~= 0
            for count = 1:noofcnt
                dlmwrite(strcat(pwd,'\results','\datafiles', '\e','\cntele','\cntele', num2str(count),'.txt'), cntele,'delimiter','\t')
            end
        else
            dlmwrite(strcat(pwd,'\results','\datafiles', '\e', '\cntele','\cntele', num2str(1),'.txt'), cntele,'delimiter','\t')
        end
    else
        dlmwrite(strcat(pwd,'\results','\datafiles', '\e', '\cntele','\cntele', num2str(1),'.txt'), cntele,'delimiter','\t')
    end
end
%<><><><><><><><><><><><><><><><><><>
secondaryphaseinfo{1,1} = zenerindices;
secondaryphaseinfo{1,2} = zslsp;
secondaryphaseinfo{1,3} = zslspc;
secondaryphaseinfo{1,4} = cntele;
secondaryphaseinfo{1,5} = zcnt;
secondaryphaseinfo{1,6} = cntxythetainfo;
%<><><><><><><><><><><><><><><><><><>
%% CALCULATE VOLUME FRACTION OF ZSLSP
if wantslsp == 1
    vf_zslsp = numel(secondaryphaseinfo{1,2})*100/numel(x);
    fprintf('Total slsp Vf: (numel(slsp) = %d)*100/(numel(x) = %d) = %3.6f %% \n',...
        numel(secondaryphaseinfo{1,2}),numel(x),vf_zslsp)        % Vf OF ZSLSP
else
    vf_zslsp = 0;
    disp('There are no SLSP in the present simulation')
end
%% CALCULATE VOLUME FRACTION OF ZCNT
if wantcnt == 1
    vf_zcnt = numel(unique(secondaryphaseinfo{1,5}))*100/numel(x);
    fprintf('Total cnt Vf: (numel(cntp) = %d)*100/(numel(x) = %d) = %3.6f %% \n',...
        numel(unique(secondaryphaseinfo{1,5})),numel(x),vf_zcnt) % Vf OF ZCNT
else
    vf_zcnt = 0;
    disp('There are no CNTs in the present simulation')
end
%% CALCULATE VOLUME FRACTION OF ZSLSPC
if wantslspclust == 1
    temp = [];
    for count = 1:size(secondaryphaseinfo{1,3},1)
        temp = [temp; secondaryphaseinfo{1,3}{count}];
    end
    temp = unique(temp);
    vf_zslspc = numel(temp)*100/numel(x);
    fprintf('Total slspc Vf: (numel(slspc) = %d)*100/(numel(x) = %d) = %3.6f %% \n',...
        vf_zslspc*numel(x)/100,numel(x),vf_zslspc)               % Vf OF ZSLSPC
    clear temp
else
    vf_zslspc = 0;
    disp('There are no SLSPC in the present simulation')
end
%<><><><><><><><><><><><><><><><><><>
%% CALCULATE TOTAL VOLUME FRACTION OF SECONDARY PHASE PARTICLES
if vf_zslsp + vf_zcnt + vf_zslspc >0
    vf_zall = vf_zslsp + vf_zcnt + vf_zslspc;
    fprintf('Total SPP Vf = %3.6f %% \n',vf_zslsp + vf_zcnt + vf_zslspc) % TOTAL Vf
else
    vf_zall = 0;
    disp('There are no second phase particles in the rpesent simulation')
end
%<><><><><><><><><><><><><><><><><><>
%% WRITE VOLUME FRACTION INFORMATION TO HARD DISK
dlmwrite(strcat(pwd,'\simparameters\volumefraction.txt'),[vf_zslsp; vf_zcnt; vf_zslspc; vf_zall])
%<><><><><><><><><><><><><><><><><><>
%% PLOT LATTICE AND ALL SECONDARY PHASE PARTICLES
readfromdisk = 0;
disp('Plotting lattice structure')
plazp3d(x,y,z, latpar, slspinfo,icntinfo, clusterinfo,zslsp,zcnt,zslspc, cntxythetainfo,readfromdisk)
%<><><><><><><><><><><><><><><><><><>
end