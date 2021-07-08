function Initialize___MCSolver_DATA()

global Lattice
global zenerindices zslsp zslspc cntele zcnt cntxythetainfo secondaryphaseinfo
%-------------------------------------------------------------
wantslsp              = Lattice.zener.slsp.want_slsp;
volumefrac_slsp       = Lattice.zener.slsp.Vol_Frac;

wantslspclust         = Lattice.zener.slspc.want_slspc;
noslspclusters        = Lattice.zener.slspc.noslspclusters;
islspcvf              = Lattice.zener.slspc.islspcvf;
radiusfactorforcircle = Lattice.zener.slspc.radiusfactorforcircle;

wantcnt               = Lattice.zener.cnt.want_cnt;
noofcnt               = Lattice.zener.cnt.noofcnt;

x                     = Lattice.size.x;
y                     = Lattice.size.y;

s                     = Lattice.orientations.s;
e                     = Lattice.s__MATLAB_Indices;

cm                    = Lattice.ColourMatrix_RGB_UnitNorm;
%------------------------------------------------------------
dlmwrite(strcat(pwd,'\results','\datafiles', '\e','\elemnummat.txt'),                           e ,'delimiter', '\t')
dlmwrite(strcat(pwd,'\results','\datafiles', '\e','\e.txt'),                                    e ,'delimiter', '\t')
dlmwrite(strcat(pwd,'\results','\datafiles', '\coordinates','\x.txt'),                          x ,'delimiter', '\t')
dlmwrite(strcat(pwd,'\results','\datafiles', '\coordinates','\y.txt'),                          y ,'delimiter', '\t')
if Lattice.size.Pert_Fac == 1
dlmwrite(strcat(pwd,'\results','\datafiles', '\coordinates','\x_with_random_perturbation.txt'), x ,'delimiter', '\t')
dlmwrite(strcat(pwd,'\results','\datafiles', '\coordinates','\y_with_random_perturbation.txt'), y ,'delimiter', '\t')
end
dlmwrite(strcat(pwd,'\results','\datafiles', '\statematrices','\initialsmatrix.txt'),           s ,'delimiter', '\t')
dlmwrite(strcat(pwd,'\results','\colormatrix.txt'),                                             cm,'delimiter', '\t')
%-------------------------------------------------------------
runfuncvasudeva = zeros(3,1);
if wantslsp*volumefrac_slsp > 0; runfuncvasudeva(1) = 1; else runfuncvasudeva(1) = 0; end
if wantcnt*noofcnt ~= 0;         runfuncvasudeva(2) = 1; else runfuncvasudeva(2) = 0; end
if wantslspclust*noslspclusters*islspcvf*radiusfactorforcircle > 0;
                                 runfuncvasudeva(3) = 1; else runfuncvasudeva(3) = 0; end
%-------------------------------------------------------------
dlmwrite(strcat(pwd, '\which2plstoplot.txt'), [wantslsp wantcnt wantslspclust], 'delimiter', '\t')
if sum(runfuncvasudeva) ~= 0
    disp('Creating particles')
    
    %[zenerindices, zslsp, zslspc, cntele, zcnt, cntxythetainfo] = vasudeva2d(latpar, x, y, e, slspinfo, icntinfo, clusterinfo);
    % [zenerindices,zslsp,zslspc,cntele,zcnt,cntxythetainfo] = Generate__Zener_Particles__2d(latpar, slspinfo, icntinfo, clusterinfo, runfuncvasudeva);
    Generate__Zener_Particles__2d()
    
    dlmwrite(strcat(pwd,'\results','\datafiles', '\e','\zener_indices.txt'),         zenerindices, 'delimiter', '\t')
    dlmwrite(strcat(pwd,'\results','\datafiles', '\e','\zener_allover.txt'),         zslsp,        'delimiter', '\t')
    dlmwrite(strcat(pwd,'\results','\datafiles', '\e','\zener_solidcircles.txt'),    zslspc,       'delimiter', '\t')
    if runfuncvasudeva(2)==1;
        dlmwrite(strcat(pwd,'\results','\datafiles', '\e', '\ZCarbonNanoTubes.txt'), zcnt,'delimiter', '\t'); end
    if wantcnt ~= 0
        for count = 1:noofcnt
            dlmwrite(strcat(pwd,'\results','\datafiles', '\e','\cntele','\cntele', num2str(count), '.txt'), cntele{count}, 'delimiter','\t')
        end
    end
elseif sum(runfuncvasudeva) == 0
    % Some negative values for the following. Just to know there are no Z particles
    zslsp = -1; zslspc = -1; cntele = -1; zcnt = -1;
    zenerindices   = [zslsp; zslspc; zcnt];
    cntxythetainfo = -1;
    dlmwrite(strcat(pwd,'\results','\datafiles','\e', '\zener_indices.txt'),      zenerindices,'delimiter','\t')
    dlmwrite(strcat(pwd,'\results','\datafiles','\e', '\zener_allover.txt'),      zslsp,       'delimiter','\t')
    dlmwrite(strcat(pwd,'\results','\datafiles','\e', '\zener_solidcircles.txt'), zslspc,      'delimiter','\t')
    dlmwrite(strcat(pwd,'\results','\datafiles','\e', '\ZCarbonNanoTubes.txt'),   zcnt,        'delimiter','\t')
    if wantcnt ~= 0
        if noofcnt ~= 0
            for count = 1:noofcnt
                dlmwrite(strcat(pwd,'\results', '\datafiles', '\e', '\cntele', '\cntele', num2str(count),'.txt'), cntele, 'delimiter', '\t')
            end
        else
                dlmwrite(strcat(pwd,'\results', '\datafiles', '\e', '\cntele', '\cntele', num2str(1),    '.txt'), cntele, 'delimiter', '\t')
        end
    else
                dlmwrite(strcat(pwd,'\results', '\datafiles', '\e', '\cntele', '\cntele', num2str(1),    '.txt'), cntele, 'delimiter', '\t')
    end
end
%<><><><><><><><><><><><><><><><><><>
secondaryphaseinfo{1,1} = zenerindices;
secondaryphaseinfo{1,2} = zslsp;
secondaryphaseinfo{1,3} = zslspc;
secondaryphaseinfo{1,4} = cntele;
secondaryphaseinfo{1,5} = zcnt;
secondaryphaseinfo{1,6} = cntxythetainfo;
%-------------------------------------------------------------
%% VOLUME FRACTIONS
if wantslsp == 1
    vf_zslsp = numel(secondaryphaseinfo{1,2})*100/numel(x);
    % Vf OF ZSLSP
    fprintf('Total slsp Vf: (numel(slsp) = %d)*100/(numel(x) = %d) = %3.6f %% \n', numel(secondaryphaseinfo{1,2}),numel(x),vf_zslsp)
else
    vf_zslsp = 0; disp('There are no SLSP')
end
if wantcnt == 1
    vf_zcnt = numel(unique(secondaryphaseinfo{1,5}))*100/numel(x);
    % Vf OF ZCNT
    fprintf('Total cnt Vf: (numel(cntp) = %d)*100/(numel(x) = %d) = %3.6f %% \n', numel(unique(secondaryphaseinfo{1,5})),numel(x),vf_zcnt)
else
    vf_zcnt = 0; disp('There are no CNTs')
end
if wantslspclust == 1
    temp = [];
    for count = 1:size(secondaryphaseinfo{1,3},1)
        temp = [temp; secondaryphaseinfo{1,3}{count}];
    end
    vf_zslspc = numel(unique(temp))*100/numel(x); clear temp
    % Vf OF ZSLSPC
    fprintf('Total slspc Vf: (numel(slspc) = %d)*100/(numel(x) = %d) = %3.6f %% \n', vf_zslspc*numel(x)/100,numel(x),vf_zslspc);
else
    vf_zslspc = 0;
    disp('There are no SLSPC')
end
if vf_zslsp + vf_zcnt + vf_zslspc ~= 0
    vf_zall = vf_zslsp + vf_zcnt + vf_zslspc;
    % TOTAL Vf
    fprintf('Total SPP Vf = %3.6f %% \n',vf_zslsp + vf_zcnt + vf_zslspc)
else
    vf_zall = 0;
    disp('There are no particles')
end
%-------------------------------------------------------------
% WRITE VOLUME FRACTION INFORMATION TO HARD DISK
dlmwrite(strcat(pwd, '\simparameters\volumefraction.txt'), [vf_zslsp; vf_zcnt; vf_zslspc; vf_zall])
%-------------------------------------------------------------
end