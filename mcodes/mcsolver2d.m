function mcsolver2d(latpar,s,e,simpar,secondaryphaseinfo,ffo)
%% ASSIGN VARIABLES ACCORDING TO INPUTS
if nargin ~= 0
    initialmcs = 1;
    finalmcs   = simpar{1}{2};
elseif nargin == 0
    initialmcs = 350; %  initialmcs = (mcs i want to start from) - (txtwriteint)
    finalmcs   = 2*initialmcs;
end
%%
if initialmcs == 1;
    q            = simpar{1}{1};
    zenerindices = secondaryphaseinfo{1,1};
    txtwriteint  = ffo{1}{1};
    nof          = ffo{1}{2};
    ham          = zeros(finalmcs,1);
    dlmwrite(strcat(pwd,'\txtfiledet.txt'),...
        [(txtwriteint:txtwriteint:finalmcs)' repmat(nof+1,numel((txtwriteint:txtwriteint:finalmcs)'),1)],...
        'delimiter','\t')
    dlmwrite(strcat(pwd,'\simparameters','\initialfinalmcs.txt'),[initialmcs; finalmcs]);
else
    nof          = 1;
    simpar1      = dlmread(strcat(pwd,'\simparameters','\simpar.txt'));
    ffo1         = dlmread(strcat(pwd,'\simparameters','\ffo.txt'));
    txtwriteint  = ffo1(1);
    s            = dlmread(strcat(pwd,'\results\datafiles\statematrices','\s',num2str(initialmcs+txtwriteint),'mcs1','.txt'));
    zenerindices = dlmread(strcat(pwd,'\results\datafiles\e','\zener_indices.txt'));
    initialham   = dlmread(strcat(pwd,'\results\datafiles\e','\zener_indices.txt'));
    q            = simpar1(1);
    ham          = zeros(finalmcs,1);
    dlmwrite(strcat(pwd,'\simparameters','\initialfinalmcs.txt'),[initialmcs; finalmcs]);
end
sz1              = size(s,1);
sz2              = size(s,2);
E                = zeros(sz1,sz2);
e                = reshape(1:numel(s),sz1,sz2);
ea               = [e(:,sz2) e];
ea               = [ea ea(:,2)];
ea               = [ea(sz1,:); ea];
ea               = [ea; ea(2,:)];
dlmwrite(strcat(pwd,'\results','\datafiles','\e','\ewrapped.txt'),ea,'delimiter','\t')
vf               = dlmread(strcat(pwd,'\simparameters\volumefraction.txt'));
skipmatrix       = zeros(size(s),'int8');
zenerindices(zenerindices<0) = [];
if numel(zenerindices)>0
    s(zenerindices) = 0;
    skipmatrix(zenerindices) = 1;
end
SZS1P1           = sz1 + 1;
SZS1P2           = sz1 + 2;
SZS1P3           = sz1 + 3;
fprintf('Starting grain growth simulation from MCS = %d\n',initialmcs)
if initialmcs == 1;
    start = initialmcs;
else
    start = initialmcs + txtwriteint + 1;
end
%% MONTE-CARLO LOOP
algorithm = 2; % 1 - old algorithm. 2 - optimized old algorithm. 3 - new algorithm.
%%
consider_energy = 0;
    
if algorithm == 1
    for ms = start:finalmcs
        for pt = 1:numel(s)
            if skipmatrix(pt) == 0
                pta  = 2*ceil(pt/sz1) + SZS1P1 + pt;
                esm1 = s(ea(pta-SZS1P3));
                esm2 = s(ea(pta-SZS1P2));
                esm3 = s(ea(pta-SZS1P1));
                esm4 = s(ea(pta-1));
                esm5 = s(ea(pta));
                esm6 = s(ea(pta+1));
                esm7 = s(ea(pta+SZS1P1));
                esm8 = s(ea(pta+SZS1P2));
                esm9 = s(ea(pta+SZS1P3));
                energy1 = 8-((esm5==esm1)+(esm5==esm4)+(esm5==esm7)+(esm5==esm2)+(esm5==esm8)+(esm5==esm3)+(esm5==esm6)+(esm5==esm9));
                NS = floor(1+q*rand(1));
                energy2 = 8-((NS==esm1)+(NS==esm4)+(NS==esm7)+(NS==esm2)+(NS==esm8)+(NS==esm3)+(NS==esm6)+(NS==esm9));
                if (energy2-energy1)<=0;
                    s(pt)   = NS;
                    if consider_energy == 1
                        energy1 = energy2;
                    end
                end
                if consider_energy == 1
                    E(pt) = energy1;
                end
            end
        end
        if mod(ms,50) == 0
            if initialmcs == 1
                if consider_energy == 1
                    fprintf('%dx%d.||.q%d.||.m:%d/%d.||.%2.4f%%Comp.||.ham:%d.||.vf.slsp:%2.2f%%.||.vf.cnt:%2.2f%%.||.vf.slspc:%2.2f%%.||.vf.tot:%2.2f%%.||\n',...
                        sz1,sz2,q,ms,finalmcs,ms*100/finalmcs,sum(sum(E)),vf(1),vf(2),vf(3),vf(4))
                else
                    fprintf('%dx%d.||.q%d.||.m:%d/%d.||.%2.4f%%Comp.||.vf.slsp:%2.2f%%.||.vf.cnt:%2.2f%%.||.vf.slspc:%2.2f%%.||.vf.tot:%2.2f%%.||\n',...
                        sz1,sz2,q,ms,finalmcs,ms*100/finalmcs,vf(1),vf(2),vf(3),vf(4))
                end 
            else
                if consider_energy == 1
                    fprintf('%dx%d.||.q%d.||.m:%d/%d.||.%2.4f%%Comp.||.%2.4f%%Comp.||.ham:%d.||.vf.slsp:%2.2f%%.||.vf.cnt:%2.2f%%.||.vf.slspc:%2.2f%%.||.vf.tot:%2.2f%%.||\n',...
                        sz1,sz2,q,ms,finalmcs,(ms-start)*100/(finalmcs-start),(ms-start)*100/finalmcs+(start)*100/finalmcs,sum(sum(E)),vf(1),vf(2),vf(3),vf(4))
                else
                    fprintf('%dx%d.||.q%d.||.m:%d/%d.||.%2.4f%%Comp.||.%2.4f%%Comp.||.vf.slsp:%2.2f%%.||.vf.cnt:%2.2f%%.||.vf.slspc:%2.2f%%.||.vf.tot:%2.2f%%.||\n',...
                        sz1,sz2,q,ms,finalmcs,(ms-start)*100/(finalmcs-start),(ms-start)*100/finalmcs+(start)*100/finalmcs,vf(1),vf(2),vf(3),vf(4))
                end
            end
        end %<><><><><><><><><><><><><><><><><><>
        if mod(ms,txtwriteint) == 0
            for count = 1:nof
                dlmwrite(strcat(pwd,'\results\datafiles\statematrices','\','s',num2str(ms),'mcs',num2str(count),'.txt'),...
                    s(:,(count-1)*floor(sz2/nof)+1:count*floor(sz2/nof)),'delimiter','\t')
            end
            if nof~=1 && mod(sz2,2)~=0
                dlmwrite(strcat(pwd,'\results\datafiles\statematrices','\','s',num2str(ms),'mcs',num2str(nof+1),'.txt'),...                
                    s(:,(nof)*floor(sz2/nof)+1:size(s,2)),'delimiter','\t')
            end
            fprintf('Finished writing partitioned s{%s} matrix to disk\n',num2str(ms))
            ham(ms) = sum(sum(E));
        end
        %<><><><><><><><><><><><><><><><><><>
    end
elseif algorithm == 2
    eai = ea(2:(size(ea,1)-1),2:(size(ea,2)-1));
    szea1 = size(ea,1);
    SZE1P1 = szea1 + 1;
    SZE1P2 = szea1 + 2;
    SZE1P3 = szea1 + 3;
    for ms = start:finalmcs
        sa = [s(:,size(s,2)) s s(:,1)];
        sa = [sa(size(sa,1),:); sa; sa(1,:)];
        for pt = 1:numel(eai)
            if skipmatrix(pt) == 0
                esm1 = sa(eai(pt)-SZE1P3);
                esm2 = sa(eai(pt)-SZE1P2);
                esm3 = sa(eai(pt)-SZE1P1);
                esm4 = sa(eai(pt)-1);
                esm5 = sa(eai(pt));
                esm6 = sa(eai(pt)+1);
                esm7 = sa(eai(pt)+SZE1P1);
                esm8 = sa(eai(pt)+SZE1P2);
                esm9 = sa(eai(pt)+SZE1P3);
            end
        end
        s  = sa(2:(size(sa,1)-1),2:(size(sa,2)-1));
    end
elseif algorithm == 3
    for ms = start:finalmcs
        for pt = 1:numel(s)
            if skipmatrix(pt) == 0
                pta = 2*ceil(pt/sz1) + SZS1P1 + pt;
                esm1 = s(ea(pta-SZS1P3));
                esm2 = s(ea(pta-SZS1P2));
                esm3 = s(ea(pta-SZS1P1));
                esm4 = s(ea(pta-1));
                esm5 = s(ea(pta));
                esm6 = s(ea(pta+1));
                esm7 = s(ea(pta+SZS1P1));
                esm8 = s(ea(pta+SZS1P2));
                esm9 = s(ea(pta+SZS1P3));
                energy1 = 8-((esm5==esm1)+(esm5==esm4)+(esm5==esm7)+(esm5==esm2)...
                            +(esm5==esm8)+(esm5==esm3)+(esm5==esm6)+(esm5==esm9));
                a = [esm1; esm2; esm3; esm4; esm6; esm7; esm8; esm9];
                NS = a(floor(1+8*rand(1)));
                energy2 = 8-((NS==esm1)+(NS==esm4)+(NS==esm7)+(NS==esm2)...
                            +(NS==esm8)+(NS==esm3)+(NS==esm6)+(NS==esm9));
                if (energy2-energy1)<=0;
                    s(pt)   = NS;
                    energy1 = energy2;
                end
                E(pt) = energy1;
            end
        end
        if mod(ms,25) == 0
            if initialmcs == 1
                fprintf('%dx%d.||.q%d.||.m:%d/%d.||.%2.4f%%Comp.||.ham:%d.||.vf.slsp:%2.2f%%.||.vf.cnt:%2.2f%%.||.vf.slspc:%2.2f%%.||.vf.tot:%2.2f%%.||\n',...
                    sz1,sz2,q,ms,finalmcs,ms*100/finalmcs,sum(sum(E)),vf(1),vf(2),vf(3),vf(4))
            else
                fprintf('%dx%d.||.q%d.||.m:%d/%d.||.%2.4f%%Comp.||.%2.4f%%Comp.||.ham:%d.||.vf.slsp:%2.2f%%.||.vf.cnt:%2.2f%%.||.vf.slspc:%2.2f%%.||.vf.tot:%2.2f%%.||\n',...
                    sz1,sz2,q,ms,finalmcs,(ms-start)*100/(finalmcs-start),(ms-start)*100/finalmcs+(start)*100/finalmcs,sum(sum(E)),vf(1),vf(2),vf(3),vf(4))
            end
        end %<><><><><><><><><><><><><><><><><><>
        if mod(ms,txtwriteint) == 0
            for count = 1:nof
                dlmwrite(strcat(pwd,'\results\datafiles\statematrices','\','s',num2str(ms),'mcs',num2str(count),'.txt'),...
                    s(:,(count-1)*floor(sz2/nof)+1:count*floor(sz2/nof)),'delimiter','\t')
            end
            if nof~=1 && mod(sz2,2)~=0
                dlmwrite(strcat(pwd,'\results\datafiles\statematrices','\','s',num2str(ms),'mcs',num2str(nof+1),'.txt'),...                
                    s(:,(nof)*floor(sz2/nof)+1:size(s,2)),'delimiter','\t')
            end
                fprintf('Finished writing partitioned s{%s} matrix to disk\n',num2str(ms))
                ham(ms) = sum(sum(E));
        end
    end
end
%%
if consider_energy == 1
    if initialmcs == 1;
        ham(ham==0)=[]; % remove zeros
        dlmwrite(strcat(pwd,'\results','\datafiles','\hamiltonian.txt'),ham)
    else
        ham = [ham; initialham];
        delete(strcat(pwd,'\results\datafiles\hamiltonian.txt')) % COMMENTING FOR TESTING PURPOSE
        dlmwrite(strcat(pwd,'\results','\datafiles','\hamiltonian_1.txt'),ham)
    end
end
dlmwrite(strcat(pwd,'\results','\datafiles','parallelcodecheckpoints.txt'),0,'delimiter','\t')
end