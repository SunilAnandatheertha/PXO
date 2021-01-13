function [CFN] = mcs2d(latpar, s, e, simpar, secondaryphaseinfo, ffo, CFN)
%% ASSIGN VARIABLES ACCORDING TO INPUTS
if nargin ~= 0
    initialmcs = 1;
    finalmcs   = simpar{1}{2};
elseif nargin == 0
    initialmcs = 350; %  initialmcs = (mcs i want to start from) - (txtwriteint)
    finalmcs   = 2*initialmcs;
    %initialmcs = input('Enter mc step to start from');
    %finalmcs   = input('Enter mc step to start from');
end
%%
if initialmcs == 1;
    q            = simpar{1}{1};
    zenerindices = secondaryphaseinfo{1,1};
    txtwriteint  = ffo{1}{1};
    nof          = ffo{1}{2};
    ham          = zeros(finalmcs,1);
    delham          = zeros(finalmcs,1);
    dlmwrite(strcat(pwd,'\txtfiledet.txt'),...
        [(txtwriteint:txtwriteint:finalmcs)' repmat(nof+1,numel((txtwriteint:txtwriteint:finalmcs)'),1)],...
        'delimiter','\t')
    dlmwrite(strcat(pwd,'\simparameters','\initialfinalmcs.txt'),[initialmcs; finalmcs]);
else
    nof          = 1;
    simpar1      = dlmread(strcat(pwd,'\simparameters','\simpar.txt'));
    ffo1         = dlmread(strcat(pwd,'\simparameters','\ffo.txt'));
    txtwriteint  = ffo1(1);
    s            = dlmread(strcat(pwd, '\results\datafiles\statematrices', '\s', num2str(initialmcs+txtwriteint),'mcs1','.txt'));
    zenerindices = dlmread(strcat(pwd, '\results\datafiles\e','\zener_indices.txt'));
    initialham   = dlmread(strcat(pwd, '\results\datafiles\e','\zener_indices.txt'));
    q            = simpar1(1);
    ham          = zeros(finalmcs,1);
    delham          = zeros(finalmcs,1);
    dlmwrite(strcat(pwd,'\simparameters','\initialfinalmcs.txt'),[initialmcs; finalmcs]);
end
sz1              = size(s,1);
sz2              = size(s,2);
E                = zeros(sz1,sz2);
delE             = zeros(sz1,sz2);
e                = reshape(1:numel(s),sz1,sz2);
ea               = [e(:,sz2) e];
ea               = [ea ea(:,2)];
ea               = [ea(sz1,:); ea];
ea               = [ea; ea(2,:)];
dlmwrite(strcat(pwd,'\results','\datafiles','\e','\ewrapped.txt'),ea,'delimiter','\t')
vf               = dlmread(strcat(pwd,'\simparameters\volumefraction.txt'));
skipmatrix       = zeros(size(s));
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
algorithm = 44411; % 1 - old algorithm. 2 - optimized old algorithm. 3 - new algorithm.
% NOTE::
% ALGORITHM 1 -- FAST2 -- FUNCTIONAL
% ALGORITHM 2 -- FAST1 -- NOT FUNCTIONAL
% ALGORITHM 3 -- SLOW  -- FUNCTIONAL
% ALGORITHM 4 -- FAST3 -- FUNCTIONAL. Improvement on Alg 1
% ALGORITHM # 44
    % Only to be used when there are zero secondary particles of any kind
    % Does not have option to record the energy evolution
%%  % Wull matrix definition
WM = [1 1 1; 1 1 1; 1 1 1];
%----------------------------------------
% WM = [1.0 1.0 0.0;   1.0 1.0 0.0;   0.0 0.0 1.0]; % 1 Moving grain structure. 45 deg sharp orientation.
% WM = [1.0 0.0 0.0;   1.0 1.0 0.0;   0.0 0.0 1.0]; % 2 Moving grain structure. 45 deg sharp orientation.
% WM = [1.0 0.5 0.5;   0.5 1.0 0.5;   0.5 0.5 1.0]; % 3 Stable grain structure. 45 deg sharp orientation.
% WM = [2.0 0.5 0.5;   0.5 1.0 0.5;   0.5 0.5 2.0]; % 4 Stable grain structure. 45 deg sharp orientation. Grows only along 45 deg by social darwinism
% WM = [2.0 1.0 0.5;   1.0 1.0 1.0;   0.5 1.0 2.0]; % 5 Stable grain structure. 45 deg sharp orientation. Grows only along 45 deg by social darwinism
% WM = [2.0 1.0 0.0;   1.0 1.0 1.0;   0.0 1.0 2.0]; % 6 Stable grain structure. 45 deg sharp orientation. Grows only along 45 deg by social darwinism
% WM = [0.5 1.0 0.0;   1.0 1.0 1.0;   0.0 1.0 0.5]; % 7 Stable grain structure. Rectangular grains. Quick grain size saturation. Self-pinned grain structure
% WM = [0.5 1.0 0.0;   1.0 0.0 1.0;   0.0 1.0 0.5]; % 8 Stable grain structure. Rectangular grains. Slower grain size saturation. Self-pinned grain structure
% WM = [0.0 1.0 0.0;   1.0 1.0 0.0;   0.0 0.0 1.0]; % 9 45 deg rough grains. Quick growth
% WM = [0.0 1.0 1.0;   1.0 1.0 0.0;   0.0 1.0 1.0]; % 10 Moving (top to bot) rough grains. Quick growth.
% WM = [1.0 1.0 0.0;   0.0 1.0 1.0;   1.0 1.0 0.0]; % 11 Moving (bot to top) rough grains. Quick growth.
% WM = [0.5 1.0 0.0;   0.0 1.0 1.0;   0.5 1.0 0.0]; % 12 Stable grains. Rough along 45 degrees. Perefect Horizontal edges. Slow growth.
% WM = rand(3,3); % 13 Implemented inside a MC step. Only for Alg. 4445
% WM = const + randn(3,3); % 14 Implemented inside a MC step. Only for Alg. 4446. If const = 0, grain structure will not develop as expected. 
                           % Very random grain structure. GS stable. COntinuous growth. COnst is shifting the mean towards positive. 
% WM = [1.0 0.0 1.0;   0.0 1.0 0.0;   1.0 0.0 1.0]; % Not useful
%----------------------------------------
WM51 = WM(1,1); WM54 = WM(2,1); WM57 = WM(3,1);
WM52 = WM(1,2); WM58 = WM(3,2);
WM53 = WM(1,3); WM56 = WM(2,3); WM59 = WM(3,3);
%----------------------------------------
%% Energy variable declarion
consider_energy = 1;
%%%%
% NOTE:: IF 
% ConsoleDisplay == 1, LIGHT -- USE FOR SPEED
% ConsoleDisplay == 2, HEAVY -- USE FOR MORE INFORMATION DISPLAY
%----------------------------------------
ConsoleDisplay = 1;
%----------------------------------------
%% ALgorithms
if algorithm == 1
    displaydatawriteprogress = 0;
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
                energy1 = 8 - ((esm5==esm1) + (esm5==esm4) + (esm5==esm7) + (esm5==esm2) + (esm5==esm8) + (esm5==esm3) + (esm5==esm6) + (esm5==esm9));
                NS = floor(1+q*rand(1));
                energy2 = 8 - ((NS==esm1) + (NS==esm4) + (NS==esm7) + (NS==esm2) + (NS==esm8) + (NS==esm3) + (NS==esm6) + (NS==esm9));
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
        if mod(ms,500) == 0
            if ConsoleDisplay == 1
                fprintf('%dx%d.||.m:%d/%d.\n', sz1, sz2, ms, finalmcs)
            elseif ConsoleDisplay == 2
                if initialmcs == 1
                    if consider_energy == 1
                        fprintf('%dx%d.||.q%d.||.m:%d/%d.||.%2.4f%%Comp.||.ham:%d.||.vf.slsp:%2.2f%%.||.vf.cnt:%2.2f%%.||.vf.slspc:%2.2f%%.||.vf.tot:%2.2f%%.||\n',...
                            sz1,sz2, q, ms, finalmcs,ms*100/finalmcs,sum(sum(E)), vf(1), vf(2), vf(3), vf(4))
                    else
                        fprintf('%dx%d.||.q%d.||.m:%d/%d.||.%2.4f%%Comp.||.vf.slsp:%2.2f%%.||.vf.cnt:%2.2f%%.||.vf.slspc:%2.2f%%.||.vf.tot:%2.2f%%.||\n',...
                            sz1,sz2, q, ms, finalmcs,ms*100/finalmcs, vf(1), vf(2), vf(3), vf(4))
                    end
                else
                    if consider_energy == 1
                        fprintf('%dx%d.||.q%d.||.m:%d/%d.||.%2.4f%%Comp.||.%2.4f%%Comp.||.ham:%d.||.vf.slsp:%2.2f%%.||.vf.cnt:%2.2f%%.||.vf.slspc:%2.2f%%.||.vf.tot:%2.2f%%.||\n',...
                            sz1,sz2, q, ms, finalmcs,(ms-start)*100/(finalmcs-start),(ms-start)*100/finalmcs+(start)*100/finalmcs,sum(sum(E)), vf(1), vf(2), vf(3), vf(4))
                    else
                        fprintf('%dx%d.||.q%d.||.m:%d/%d.||.%2.4f%%Comp.||.%2.4f%%Comp.||.vf.slsp:%2.2f%%.||.vf.cnt:%2.2f%%.||.vf.slspc:%2.2f%%.||.vf.tot:%2.2f%%.||\n',...
                            sz1,sz2, q, ms, finalmcs,(ms-start)*100/(finalmcs-start),(ms-start)*100/finalmcs+(start)*100/finalmcs, vf(1), vf(2), vf(3), vf(4))
                    end
                end
            end
        end
        if mod(ms,txtwriteint) == 0
            for count = 1:nof
                dlmwrite(strcat(pwd,'\results\datafiles\statematrices','\','s',num2str(ms),'mcs',num2str(count),'.txt'),...
                    s(:,(count-1)*floor(sz2/nof)+1:count*floor(sz2/nof)),'delimiter','\t')
            end
            if nof~=1 && mod(sz2,2)~=0
                dlmwrite(strcat(pwd,'\results\datafiles\statematrices','\', 's', num2str(ms),'mcs', num2str(nof+1),'.txt'),...                
                    s(:,(nof)*floor(sz2/nof)+1:size(s,2)),'delimiter','\t')
            end
            if displaydatawriteprogress == 1
                fprintf('Finished writing partitioned s{%s} matrix to disk\n',num2str(ms))
            end
            ham(ms) = sum(sum(E));
        end
        %<><><><><><><><><><><><><><><><><><>
    end
end
if algorithm == 2
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
end
if algorithm == 3
    displaydatawriteprogress = 0;
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
        if mod(ms,500) == 0
            if ConsoleDisplay == 1
                fprintf('%dx%d.||.m:%d/%d.\n', sz1, sz2, ms, finalmcs)
            elseif ConsoleDisplay == 2
                if initialmcs == 1
                    if consider_energy == 1
                        fprintf('%dx%d.||.q%d.||.m:%d/%d.||.%2.4f%%Comp.||.ham:%d.||.vf.slsp:%2.2f%%.||.vf.cnt:%2.2f%%.||.vf.slspc:%2.2f%%.||.vf.tot:%2.2f%%.||\n',...
                            sz1,sz2, q, ms, finalmcs,ms*100/finalmcs,sum(sum(E)), vf(1), vf(2), vf(3), vf(4))
                    else
                        fprintf('%dx%d.||.q%d.||.m:%d/%d.||.%2.4f%%Comp.||.vf.slsp:%2.2f%%.||.vf.cnt:%2.2f%%.||.vf.slspc:%2.2f%%.||.vf.tot:%2.2f%%.||\n',...
                            sz1,sz2, q, ms, finalmcs,ms*100/finalmcs, vf(1), vf(2), vf(3), vf(4))
                    end
                else
                    if consider_energy == 1
                        fprintf('%dx%d.||.q%d.||.m:%d/%d.||.%2.4f%%Comp.||.%2.4f%%Comp.||.ham:%d.||.vf.slsp:%2.2f%%.||.vf.cnt:%2.2f%%.||.vf.slspc:%2.2f%%.||.vf.tot:%2.2f%%.||\n',...
                            sz1,sz2, q, ms, finalmcs,(ms-start)*100/(finalmcs-start),(ms-start)*100/finalmcs+(start)*100/finalmcs,sum(sum(E)), vf(1), vf(2), vf(3), vf(4))
                    else
                        fprintf('%dx%d.||.q%d.||.m:%d/%d.||.%2.4f%%Comp.||.%2.4f%%Comp.||.vf.slsp:%2.2f%%.||.vf.cnt:%2.2f%%.||.vf.slspc:%2.2f%%.||.vf.tot:%2.2f%%.||\n',...
                            sz1,sz2, q, ms, finalmcs,(ms-start)*100/(finalmcs-start),(ms-start)*100/finalmcs+(start)*100/finalmcs, vf(1), vf(2), vf(3), vf(4))
                    end
                end
            end
        end
        if mod(ms,txtwriteint) == 0
            for count = 1:nof
                dlmwrite(strcat(pwd,'\results\datafiles\statematrices','\','s',num2str(ms),'mcs',num2str(count),'.txt'),...
                    s(:,(count-1)*floor(sz2/nof)+1:count*floor(sz2/nof)),'delimiter','\t')
            end
            if nof~=1 && mod(sz2,2)~=0
                dlmwrite(strcat(pwd,'\results\datafiles\statematrices','\', 's', num2str(ms),'mcs', num2str(nof+1),'.txt'),...                
                    s(:,(nof)*floor(sz2/nof)+1:size(s,2)),'delimiter','\t')
            end
            if displaydatawriteprogress == 1
                fprintf('Finished writing partitioned s{%s} matrix to disk\n',num2str(ms))
            end
            ham(ms) = sum(sum(E));
        end
    end
end
if algorithm == 4
    numsarray = 1:numel(s);
    PTA = 2*ceil(numsarray/sz1) + SZS1P1 + numsarray;
    displaydatawriteprogress = 0;
    for ms = start:finalmcs
        for pt = 1:numel(s)
            if skipmatrix(pt) == 0
                pta  = PTA(pt);
                esm1 = s(ea(pta-SZS1P3));
                esm2 = s(ea(pta-SZS1P2));
                esm3 = s(ea(pta-SZS1P1));
                esm4 = s(ea(pta-1));
                esm5 = s(ea(pta));
                esm6 = s(ea(pta+1));
                esm7 = s(ea(pta+SZS1P1));
                esm8 = s(ea(pta+SZS1P2));
                esm9 = s(ea(pta+SZS1P3));
                %energy1 = 8 - ((esm5==esm1) + (esm5==esm4) + (esm5==esm7) + (esm5==esm2) + (esm5==esm8) + (esm5==esm3) + (esm5==esm6) + (esm5==esm9));
                energy1 = (esm5==esm1)+(esm5==esm4)+(esm5==esm7)+(esm5==esm2)+(esm5==esm8)+(esm5==esm3)+(esm5==esm6)+(esm5==esm9);
                NS = floor(1+q*rand); % Fastest
                %NS = randi(q,1);
                %NS = randi(q);
                %energy2 = 8 - ((NS==esm1) + (NS==esm4) + (NS==esm7) + (NS==esm2) + (NS==esm8) + (NS==esm3) + (NS==esm6) + (NS==esm9));
                energy2 = (NS==esm1)+(NS==esm4)+(NS==esm7)+(NS==esm2)+(NS==esm8)+(NS==esm3)+(NS==esm6)+(NS==esm9);
                %if (energy2-energy1)<=0
                %if (energy1-energy2)<=0
                if energy1 <= energy2
                    s(pt) = NS;
                    if consider_energy == 1; energy1 = energy2; end
                end
                if consider_energy == 1;E(pt) = energy1;end
            end
        end
        if mod(ms,500) == 0
            if ConsoleDisplay == 1
                fprintf('%dx%d.||.m:%d/%d.\n', sz1, sz2, ms, finalmcs)
            elseif ConsoleDisplay == 2
                if initialmcs == 1
                    if consider_energy == 1
                        fprintf('%dx%d.||.q%d.||.m:%d/%d.||.%2.4f%%Comp.||.ham:%d.||.vf.slsp:%2.2f%%.||.vf.cnt:%2.2f%%.||.vf.slspc:%2.2f%%.||.vf.tot:%2.2f%%.||\n',...
                            sz1,sz2, q, ms, finalmcs,ms*100/finalmcs,sum(sum(E)), vf(1), vf(2), vf(3), vf(4))
                    else
                        fprintf('%dx%d.||.q%d.||.m:%d/%d.||.%2.4f%%Comp.||.vf.slsp:%2.2f%%.||.vf.cnt:%2.2f%%.||.vf.slspc:%2.2f%%.||.vf.tot:%2.2f%%.||\n',...
                            sz1,sz2, q, ms, finalmcs,ms*100/finalmcs, vf(1), vf(2), vf(3), vf(4))
                    end
                else
                    if consider_energy == 1
                        fprintf('%dx%d.||.q%d.||.m:%d/%d.||.%2.4f%%Comp.||.%2.4f%%Comp.||.ham:%d.||.vf.slsp:%2.2f%%.||.vf.cnt:%2.2f%%.||.vf.slspc:%2.2f%%.||.vf.tot:%2.2f%%.||\n',...
                            sz1,sz2, q, ms, finalmcs,(ms-start)*100/(finalmcs-start),(ms-start)*100/finalmcs+(start)*100/finalmcs,sum(sum(E)), vf(1), vf(2), vf(3), vf(4))
                    else
                        fprintf('%dx%d.||.q%d.||.m:%d/%d.||.%2.4f%%Comp.||.%2.4f%%Comp.||.vf.slsp:%2.2f%%.||.vf.cnt:%2.2f%%.||.vf.slspc:%2.2f%%.||.vf.tot:%2.2f%%.||\n',...
                            sz1,sz2, q, ms, finalmcs,(ms-start)*100/(finalmcs-start),(ms-start)*100/finalmcs+(start)*100/finalmcs, vf(1), vf(2), vf(3), vf(4))
                    end
                end
            end
        end
        if mod(ms,txtwriteint) == 0
            for count = 1:nof
                dlmwrite(strcat(pwd,'\results\datafiles\statematrices','\','s',num2str(ms),'mcs',num2str(count),'.txt'),...
                    s(:,(count-1)*floor(sz2/nof)+1:count*floor(sz2/nof)),'delimiter','\t')
            end
            if nof~=1 && mod(sz2,2)~=0
                dlmwrite(strcat(pwd,'\results\datafiles\statematrices','\', 's', num2str(ms),'mcs', num2str(nof+1),'.txt'),...                
                    s(:,(nof)*floor(sz2/nof)+1:size(s,2)),'delimiter','\t')
            end
            if displaydatawriteprogress == 1
                fprintf('Finished writing partitioned s{%s} matrix to disk\n',num2str(ms))
            end
            ham(ms) = sum(sum(E));
        end
        %<><><><><><><><><><><><><><><><><><>
    end
end
if algorithm == 44 %KERNEL__LOOP_MC_2D____ALGORITHM_05
    numsarray = 1:numel(s);
    PTA = 2*ceil(numsarray/sz1) + SZS1P1 + numsarray;
    displaydatawriteprogress = 0;
    for ms = start:finalmcs
        for pt = 1:numel(s)
            pta  = PTA(pt);
            esm1 = s(ea(pta-SZS1P3));
            esm2 = s(ea(pta-SZS1P2));
            esm3 = s(ea(pta-SZS1P1));
            esm4 = s(ea(pta-1));
            esm5 = s(ea(pta));
            esm6 = s(ea(pta+1));
            esm7 = s(ea(pta+SZS1P1));
            esm8 = s(ea(pta+SZS1P2));
            esm9 = s(ea(pta+SZS1P3));
            energy1 = (esm5==esm1)+(esm5==esm4)+(esm5==esm7)+(esm5==esm2)+(esm5==esm8)+(esm5==esm3)+(esm5==esm6)+(esm5==esm9);
            NS = floor(1+q*rand);
            energy2 = (NS==esm1)+(NS==esm4)+(NS==esm7)+(NS==esm2)+(NS==esm8)+(NS==esm3)+(NS==esm6)+(NS==esm9);
            if energy1 <= energy2
                s(pt) = NS;
            end
        end
        if mod(ms,500) == 0
            if ConsoleDisplay == 1
                fprintf('%dx%d.||.m:%d/%d.\n', sz1, sz2, ms, finalmcs)
            elseif ConsoleDisplay == 2
                if initialmcs == 1
                    if consider_energy == 1
                        fprintf('%dx%d.||.q%d.||.m:%d/%d.||.%2.4f%%Comp.||.ham:%d.||.vf.slsp:%2.2f%%.||.vf.cnt:%2.2f%%.||.vf.slspc:%2.2f%%.||.vf.tot:%2.2f%%.||\n',...
                            sz1,sz2, q, ms, finalmcs,ms*100/finalmcs,sum(sum(E)), vf(1), vf(2), vf(3), vf(4))
                    else
                        fprintf('%dx%d.||.q%d.||.m:%d/%d.||.%2.4f%%Comp.||.vf.slsp:%2.2f%%.||.vf.cnt:%2.2f%%.||.vf.slspc:%2.2f%%.||.vf.tot:%2.2f%%.||\n',...
                            sz1,sz2, q, ms, finalmcs,ms*100/finalmcs, vf(1), vf(2), vf(3), vf(4))
                    end
                else
                    if consider_energy == 1
                        fprintf('%dx%d.||.q%d.||.m:%d/%d.||.%2.4f%%Comp.||.%2.4f%%Comp.||.ham:%d.||.vf.slsp:%2.2f%%.||.vf.cnt:%2.2f%%.||.vf.slspc:%2.2f%%.||.vf.tot:%2.2f%%.||\n',...
                            sz1,sz2, q, ms, finalmcs,(ms-start)*100/(finalmcs-start),(ms-start)*100/finalmcs+(start)*100/finalmcs,sum(sum(E)), vf(1), vf(2), vf(3), vf(4))
                    else
                        fprintf('%dx%d.||.q%d.||.m:%d/%d.||.%2.4f%%Comp.||.%2.4f%%Comp.||.vf.slsp:%2.2f%%.||.vf.cnt:%2.2f%%.||.vf.slspc:%2.2f%%.||.vf.tot:%2.2f%%.||\n',...
                            sz1,sz2, q, ms, finalmcs,(ms-start)*100/(finalmcs-start),(ms-start)*100/finalmcs+(start)*100/finalmcs, vf(1), vf(2), vf(3), vf(4))
                    end
                end
            end
        end
        if mod(ms,txtwriteint) == 0
            for count = 1:nof
                dlmwrite(strcat(pwd,'\results\datafiles\statematrices','\','s',num2str(ms),'mcs',num2str(count),'.txt'),...
                    s(:,(count-1)*floor(sz2/nof)+1:count*floor(sz2/nof)),'delimiter','\t')
            end
            if nof~=1 && mod(sz2,2)~=0
                dlmwrite(strcat(pwd,'\results\datafiles\statematrices','\', 's', num2str(ms),'mcs', num2str(nof+1),'.txt'),...                
                    s(:,(nof)*floor(sz2/nof)+1:size(s,2)),'delimiter','\t')
            end
            if displaydatawriteprogress == 1
                fprintf('Finished writing partitioned s{%s} matrix to disk\n',num2str(ms))
            end
            ham(ms) = sum(sum(E));
        end
        %<><><><><><><><><><><><><><><><><><>
    end
end
if algorithm == 444 %KERNEL__LOOP_MC_2D____ALGORITHM_07
    nums = numel(s);
    numsarray = 1:nums;
    PTA = 2*ceil(numsarray/sz1) + SZS1P1 + numsarray;
    displaydatawriteprogress = 0;
    for ms = start:finalmcs
        ns = floor(1+q*rand(nums,1));
        for pt = 1:nums
            pta  = PTA(pt);
            esm1 = s(ea(pta-SZS1P3));
            esm2 = s(ea(pta-SZS1P2));
            esm3 = s(ea(pta-SZS1P1));
            esm4 = s(ea(pta-1));
            esm5 = s(ea(pta));
            esm6 = s(ea(pta+1));
            esm7 = s(ea(pta+SZS1P1));
            esm8 = s(ea(pta+SZS1P2));
            esm9 = s(ea(pta+SZS1P3));
            energy1 = (esm5==esm1)+(esm5==esm4)+(esm5==esm7)+(esm5==esm2)+(esm5==esm8)+(esm5==esm3)+(esm5==esm6)+(esm5==esm9);
            NS = ns(pt);
            energy2 = (NS==esm1)+(NS==esm4)+(NS==esm7)+(NS==esm2)+(NS==esm8)+(NS==esm3)+(NS==esm6)+(NS==esm9);
            if energy1 <= energy2
                s(pt) = NS;
            end
        end
        if mod(ms,500) == 0
            if ConsoleDisplay == 1
                fprintf('%dx%d.||.m:%d/%d.\n', sz1, sz2, ms, finalmcs)
            elseif ConsoleDisplay == 2
                if initialmcs == 1
                    if consider_energy == 1
                        fprintf('%dx%d.||.q%d.||.m:%d/%d.||.%2.4f%%Comp.||.ham:%d.||.vf.slsp:%2.2f%%.||.vf.cnt:%2.2f%%.||.vf.slspc:%2.2f%%.||.vf.tot:%2.2f%%.||\n',...
                            sz1,sz2, q, ms, finalmcs,ms*100/finalmcs,sum(sum(E)), vf(1), vf(2), vf(3), vf(4))
                    else
                        fprintf('%dx%d.||.q%d.||.m:%d/%d.||.%2.4f%%Comp.||.vf.slsp:%2.2f%%.||.vf.cnt:%2.2f%%.||.vf.slspc:%2.2f%%.||.vf.tot:%2.2f%%.||\n',...
                            sz1,sz2, q, ms, finalmcs,ms*100/finalmcs, vf(1), vf(2), vf(3), vf(4))
                    end
                else
                    if consider_energy == 1
                        fprintf('%dx%d.||.q%d.||.m:%d/%d.||.%2.4f%%Comp.||.%2.4f%%Comp.||.ham:%d.||.vf.slsp:%2.2f%%.||.vf.cnt:%2.2f%%.||.vf.slspc:%2.2f%%.||.vf.tot:%2.2f%%.||\n',...
                            sz1,sz2, q, ms, finalmcs,(ms-start)*100/(finalmcs-start),(ms-start)*100/finalmcs+(start)*100/finalmcs,sum(sum(E)), vf(1), vf(2), vf(3), vf(4))
                    else
                        fprintf('%dx%d.||.q%d.||.m:%d/%d.||.%2.4f%%Comp.||.%2.4f%%Comp.||.vf.slsp:%2.2f%%.||.vf.cnt:%2.2f%%.||.vf.slspc:%2.2f%%.||.vf.tot:%2.2f%%.||\n',...
                            sz1,sz2, q, ms, finalmcs,(ms-start)*100/(finalmcs-start),(ms-start)*100/finalmcs+(start)*100/finalmcs, vf(1), vf(2), vf(3), vf(4))
                    end
                end
            end
        end
        if mod(ms,txtwriteint) == 0
            for count = 1:nof
                dlmwrite(strcat(pwd,'\results\datafiles\statematrices','\','s',num2str(ms),'mcs',num2str(count),'.txt'),...
                    s(:,(count-1)*floor(sz2/nof)+1:count*floor(sz2/nof)),'delimiter','\t')
            end
            if nof~=1 && mod(sz2,2)~=0
                dlmwrite(strcat(pwd,'\results\datafiles\statematrices','\', 's', num2str(ms),'mcs', num2str(nof+1),'.txt'),...                
                    s(:,(nof)*floor(sz2/nof)+1:size(s,2)),'delimiter','\t')
            end
            if displaydatawriteprogress == 1
                fprintf('Finished writing partitioned s{%s} matrix to disk\n',num2str(ms))
            end
            ham(ms) = sum(sum(E));
        end
        %<><><><><><><><><><><><><><><><><><>
    end
end
if algorithm == 4441 %KERNEL__LOOP_MC_2D____ALGORITHM_08
    nums = numel(s);
    numsarray = 1:nums;
    PTA = 2*ceil(numsarray/sz1) + SZS1P1 + numsarray;
    displaydatawriteprogress = 0;
    for ms = start:finalmcs
        ns = floor(1+q*rand(nums,1));
        for pt = 1:nums
            pta  = PTA(pt);
            esm1 = s(ea(pta-SZS1P3)); esm2 = s(ea(pta-SZS1P2)); esm3 = s(ea(pta-SZS1P1));
            esm4 = s(ea(pta-1));      esm5 = s(ea(pta));        esm6 = s(ea(pta+1));
            esm7 = s(ea(pta+SZS1P1)); esm8 = s(ea(pta+SZS1P2)); esm9 = s(ea(pta+SZS1P3));
            delenergy1 = (esm5==esm1)+(esm5==esm4)+(esm5==esm7)+(esm5==esm2)+(esm5==esm8)+(esm5==esm3)+(esm5==esm6)+(esm5==esm9); % Current decrease in energy:
            NS = ns(pt); % Coin flip:
            delenergy2 = (NS==esm1)+(NS==esm4)+(NS==esm7)+(NS==esm2)+(NS==esm8)+(NS==esm3)+(NS==esm6)+(NS==esm9); % New decrease in energy:
            % If flipped coin can result in greater energy decrase, accept it:
            if delenergy2 >= delenergy1;
                s(pt) = NS;
                if consider_energy == 1; delenergy1 = delenergy2; end;
            end
            if consider_energy == 1; delE(pt) = delenergy1; end
        end
        if mod(ms,500) == 0
            if ConsoleDisplay == 1; fprintf('%dx%d.||.m:%d/%d.\n', sz1, sz2, ms, finalmcs)
            elseif ConsoleDisplay == 2
                if initialmcs == 1
                    if consider_energy == 1; fprintf('%dx%d.||.q%d.||.m:%d/%d.||.%2.4f%%Comp.||.ham:%d.||.vf.slsp:%2.2f%%.||.vf.cnt:%2.2f%%.||.vf.slspc:%2.2f%%.||.vf.tot:%2.2f%%.||\n', sz1,sz2, q, ms, finalmcs,ms*100/finalmcs,sum(sum(E)), vf(1), vf(2), vf(3), vf(4))
                    else fprintf('%dx%d.||.q%d.||.m:%d/%d.||.%2.4f%%Comp.||.vf.slsp:%2.2f%%.||.vf.cnt:%2.2f%%.||.vf.slspc:%2.2f%%.||.vf.tot:%2.2f%%.||\n', sz1,sz2, q, ms, finalmcs,ms*100/finalmcs, vf(1), vf(2), vf(3), vf(4))
                    end
                else
                    if consider_energy == 1; fprintf('%dx%d.||.q%d.||.m:%d/%d.||.%2.4f%%Comp.||.%2.4f%%Comp.||.ham:%d.||.vf.slsp:%2.2f%%.||.vf.cnt:%2.2f%%.||.vf.slspc:%2.2f%%.||.vf.tot:%2.2f%%.||\n', sz1,sz2, q, ms, finalmcs,(ms-start)*100/(finalmcs-start),(ms-start)*100/finalmcs+(start)*100/finalmcs,sum(sum(E)), vf(1), vf(2), vf(3), vf(4))
                    else fprintf('%dx%d.||.q%d.||.m:%d/%d.||.%2.4f%%Comp.||.%2.4f%%Comp.||.vf.slsp:%2.2f%%.||.vf.cnt:%2.2f%%.||.vf.slspc:%2.2f%%.||.vf.tot:%2.2f%%.||\n', sz1,sz2, q, ms, finalmcs,(ms-start)*100/(finalmcs-start),(ms-start)*100/finalmcs+(start)*100/finalmcs, vf(1), vf(2), vf(3), vf(4))
                    end
                end
            end
        end
        if mod(ms,txtwriteint) == 0
            for count = 1:nof; dlmwrite(strcat(pwd,'\results\datafiles\statematrices','\','s',num2str(ms),'mcs',num2str(count),'.txt'), s(:,(count-1)*floor(sz2/nof)+1:count*floor(sz2/nof)),'delimiter','\t'); end
            if nof~=1 && mod(sz2,2)~=0; dlmwrite(strcat(pwd,'\results\datafiles\statematrices','\', 's', num2str(ms),'mcs', num2str(nof+1),'.txt'), s(:,(nof)*floor(sz2/nof)+1:size(s,2)),'delimiter','\t'); end
            if displaydatawriteprogress == 1; fprintf('Finished writing partitioned s{%s} matrix to disk\n',num2str(ms)); end
            delham(ms) = sum(sum(delE));
        end
        %<><><><><><><><><><><><><><><><><><>
    end
end
if algorithm == 44411 %KERNEL__LOOP_MC_2D____ALGORITHM_09
    nums = numel(s);
    numsarray = 1:nums;
    PTA = 2*ceil(numsarray/sz1) + SZS1P1 + numsarray;
    displaydatawriteprogress = 0;
    for ms = start:finalmcs
        ns = floor(1+q*rand(nums,1));
        for pt = 1:nums
            if skipmatrix(pt) == 0
                pta  = PTA(pt);
                esm1 = s(ea(pta-SZS1P3)); esm2 = s(ea(pta-SZS1P2)); esm3 = s(ea(pta-SZS1P1));
                esm4 = s(ea(pta-1));      esm5 = s(ea(pta));        esm6 = s(ea(pta+1));
                esm7 = s(ea(pta+SZS1P1)); esm8 = s(ea(pta+SZS1P2)); esm9 = s(ea(pta+SZS1P3));
                delenergy1 = (esm5==esm1)+(esm5==esm4)+(esm5==esm7)+(esm5==esm2)+(esm5==esm8)+(esm5==esm3)+(esm5==esm6)+(esm5==esm9); % Current decrease in energy:
                NS = ns(pt); % Coin flip:
                delenergy2 = (NS==esm1)+(NS==esm4)+(NS==esm7)+(NS==esm2)+(NS==esm8)+(NS==esm3)+(NS==esm6)+(NS==esm9); % New decrease in energy:
                % If flipped coin can result in greater energy decrase, accept it:
                if delenergy2 >= delenergy1;
                    s(pt) = NS;
                    if consider_energy == 1; delenergy1 = delenergy2; end;
                end
                if consider_energy == 1; delE(pt) = delenergy1; end
            end
        end
%         if mod(ms,500) == 0
        if mod(ms,txtwriteint) == 0
            if ConsoleDisplay == 1; fprintf('%dx%d.||.m:%d/%d.\n', sz1, sz2, ms, finalmcs)
            elseif ConsoleDisplay == 2
                if initialmcs == 1
                    if consider_energy == 1; fprintf('%dx%d.||.q%d.||.m:%d/%d.||.%2.4f%%Comp.||.ham:%d.||.vf.slsp:%2.2f%%.||.vf.cnt:%2.2f%%.||.vf.slspc:%2.2f%%.||.vf.tot:%2.2f%%.||\n', sz1,sz2, q, ms, finalmcs,ms*100/finalmcs,sum(sum(E)), vf(1), vf(2), vf(3), vf(4))
                    else fprintf('%dx%d.||.q%d.||.m:%d/%d.||.%2.4f%%Comp.||.vf.slsp:%2.2f%%.||.vf.cnt:%2.2f%%.||.vf.slspc:%2.2f%%.||.vf.tot:%2.2f%%.||\n', sz1,sz2, q, ms, finalmcs,ms*100/finalmcs, vf(1), vf(2), vf(3), vf(4))
                    end
                else
                    if consider_energy == 1; fprintf('%dx%d.||.q%d.||.m:%d/%d.||.%2.4f%%Comp.||.%2.4f%%Comp.||.ham:%d.||.vf.slsp:%2.2f%%.||.vf.cnt:%2.2f%%.||.vf.slspc:%2.2f%%.||.vf.tot:%2.2f%%.||\n', sz1,sz2, q, ms, finalmcs,(ms-start)*100/(finalmcs-start),(ms-start)*100/finalmcs+(start)*100/finalmcs,sum(sum(E)), vf(1), vf(2), vf(3), vf(4))
                    else fprintf('%dx%d.||.q%d.||.m:%d/%d.||.%2.4f%%Comp.||.%2.4f%%Comp.||.vf.slsp:%2.2f%%.||.vf.cnt:%2.2f%%.||.vf.slspc:%2.2f%%.||.vf.tot:%2.2f%%.||\n', sz1,sz2, q, ms, finalmcs,(ms-start)*100/(finalmcs-start),(ms-start)*100/finalmcs+(start)*100/finalmcs, vf(1), vf(2), vf(3), vf(4))
                    end
                end
            end
        end
        if mod(ms,txtwriteint) == 0
            for count = 1:nof; dlmwrite(strcat(pwd,'\results\datafiles\statematrices','\','s',num2str(ms),'mcs',num2str(count),'.txt'), s(:,(count-1)*floor(sz2/nof)+1:count*floor(sz2/nof)),'delimiter','\t'); end
            if nof~=1 && mod(sz2,2)~=0; dlmwrite(strcat(pwd,'\results\datafiles\statematrices','\', 's', num2str(ms),'mcs', num2str(nof+1),'.txt'), s(:,(nof)*floor(sz2/nof)+1:size(s,2)),'delimiter','\t'); end
            if displaydatawriteprogress == 1; fprintf('Finished writing partitioned s{%s} matrix to disk\n',num2str(ms)); end
            delham(ms) = sum(sum(delE));
        end
        %<><><><><><><><><><><><><><><><><><>
    end
end
 % Generalization of algorithm 444411. Includes transition probability
if algorithm == 5 %KERNEL__LOOP_MC_2D____ALGORITHM_10
    %%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Set the artitificial temperature (i.e. Simulation temperature) value in the next line
    kbT = 10; % This will be used to calculate the transition probailibtiy
        % Domain of kbT:: Greater than 1 and preferrably less than 50
    %%%%%%%%%%%%%%%%%%%%%%%%%%%
    disp('I am considering transition probability...'), pause(0.25)
    % Set the value of Grain Boundary Energy
    GBE = 1;  % This will be used to calculate the energy1 and energy2
        % Value of GBE decides the domain limits of dele
    %%%%%%%%%%%%%%%%%%%%%%%%%%%
    nums = numel(s);
    numsarray = 1:nums;
    PTA = 2*ceil(numsarray/sz1) + SZS1P1 + numsarray;
    displaydatawriteprogress = 0;
    for ms = start:finalmcs
        ns = floor(1+q*rand(nums,1));
        for pt = 1:nums
            if skipmatrix(pt) == 0
                pta  = PTA(pt);
                esm1 = s(ea(pta-SZS1P3)); esm2 = s(ea(pta-SZS1P2)); esm3 = s(ea(pta-SZS1P1));
                esm4 = s(ea(pta-1));      esm5 = s(ea(pta));        esm6 = s(ea(pta+1));
                esm7 = s(ea(pta+SZS1P1)); esm8 = s(ea(pta+SZS1P2)); esm9 = s(ea(pta+SZS1P3));
                delenergy1 = (esm5==esm1)+(esm5==esm4)+(esm5==esm7)+(esm5==esm2)+(esm5==esm8)+(esm5==esm3)+(esm5==esm6)+(esm5==esm9); % Current decrease in energy:
                NS = ns(pt); % Coin flip:
                delenergy2 = (NS==esm1)+(NS==esm4)+(NS==esm7)+(NS==esm2)+(NS==esm8)+(NS==esm3)+(NS==esm6)+(NS==esm9); % New decrease in energy:
                % If flipped coin can result in greater energy decrase, accept it:
                if delenergy2 >= delenergy1
                    s(pt) = NS;
                    %if consider_energy == 1; delenergy1 = delenergy2; end
                elseif exp(-(delenergy2 - delenergy1)/kbT) > rand
                    s(pt) = NS; % Accept the new state
                    %if consider_energy == 1; delenergy1 = delenergy2; end
                else
                    % Do nothing
                end
                if consider_energy == 1; delE(pt) = delenergy1; end
            end
        end
        if mod(ms,500) == 0
            if ConsoleDisplay == 1; fprintf('%dx%d.||.m:%d/%d.\n', sz1, sz2, ms, finalmcs)
            elseif ConsoleDisplay == 2
                if initialmcs == 1
                    if consider_energy == 1; fprintf('%dx%d.||.q%d.||.m:%d/%d.||.%2.4f%%Comp.||.ham:%d.||.vf.slsp:%2.2f%%.||.vf.cnt:%2.2f%%.||.vf.slspc:%2.2f%%.||.vf.tot:%2.2f%%.||\n', sz1,sz2, q, ms, finalmcs,ms*100/finalmcs,sum(sum(E)), vf(1), vf(2), vf(3), vf(4))
                    else fprintf('%dx%d.||.q%d.||.m:%d/%d.||.%2.4f%%Comp.||.vf.slsp:%2.2f%%.||.vf.cnt:%2.2f%%.||.vf.slspc:%2.2f%%.||.vf.tot:%2.2f%%.||\n', sz1,sz2, q, ms, finalmcs,ms*100/finalmcs, vf(1), vf(2), vf(3), vf(4))
                    end
                else
                    if consider_energy == 1; fprintf('%dx%d.||.q%d.||.m:%d/%d.||.%2.4f%%Comp.||.%2.4f%%Comp.||.ham:%d.||.vf.slsp:%2.2f%%.||.vf.cnt:%2.2f%%.||.vf.slspc:%2.2f%%.||.vf.tot:%2.2f%%.||\n', sz1,sz2, q, ms, finalmcs,(ms-start)*100/(finalmcs-start),(ms-start)*100/finalmcs+(start)*100/finalmcs,sum(sum(E)), vf(1), vf(2), vf(3), vf(4))
                    else fprintf('%dx%d.||.q%d.||.m:%d/%d.||.%2.4f%%Comp.||.%2.4f%%Comp.||.vf.slsp:%2.2f%%.||.vf.cnt:%2.2f%%.||.vf.slspc:%2.2f%%.||.vf.tot:%2.2f%%.||\n', sz1,sz2, q, ms, finalmcs,(ms-start)*100/(finalmcs-start),(ms-start)*100/finalmcs+(start)*100/finalmcs, vf(1), vf(2), vf(3), vf(4))
                    end
                end
            end
        end
        if mod(ms,txtwriteint) == 0
            for count = 1:nof; dlmwrite(strcat(pwd,'\results\datafiles\statematrices','\','s',num2str(ms),'mcs',num2str(count),'.txt'), s(:,(count-1)*floor(sz2/nof)+1:count*floor(sz2/nof)),'delimiter','\t'); end
            if nof~=1 && mod(sz2,2)~=0; dlmwrite(strcat(pwd,'\results\datafiles\statematrices','\', 's', num2str(ms),'mcs', num2str(nof+1),'.txt'), s(:,(nof)*floor(sz2/nof)+1:size(s,2)),'delimiter','\t'); end
            if displaydatawriteprogress == 1; fprintf('Finished writing partitioned s{%s} matrix to disk\n',num2str(ms)); end
            delham(ms) = sum(sum(delE));
        end
        %<><><><><><><><><><><><><><><><><><>
    end
end
%% Algrithm # 4442
if algorithm == 4442 %KERNEL__LOOP_MC_2D____ALGORITHM_11
    nums = numel(s);
    numsarray = 1:nums;
    PTA = 2*ceil(numsarray/sz1) + SZS1P1 + numsarray;
    displaydatawriteprogress = 0;
    for ms = start:finalmcs
        ns = floor(1+q*rand(nums,1));
        for pt = 1:nums
            if skipmatrix(pt) == 0
                
                pta  = PTA(pt);
                
                esm1 = s(ea(pta-SZS1P3)); esm2 = s(ea(pta-SZS1P2)); esm3 = s(ea(pta-SZS1P1));
                esm4 = s(ea(pta-1));      esm5 = s(ea(pta));        esm6 = s(ea(pta+1));
                esm7 = s(ea(pta+SZS1P1)); esm8 = s(ea(pta+SZS1P2)); esm9 = s(ea(pta+SZS1P3));
                
                delenergy1 = WM51*(esm5==esm1) + WM54*(esm5==esm4) + WM57*(esm5==esm7) +...
                             WM52*(esm5==esm2) + WM58*(esm5==esm8) + WM53*(esm5==esm3) +...
                             WM56*(esm5==esm6) + WM59*(esm5==esm9);
                
                NS = ns(pt);
                
                delenergy2 = WM51*(NS==esm1)   + WM54*(NS==esm4)   + WM57*(NS==esm7) +...
                             WM52*(NS==esm2)   + WM58*(NS==esm8)   + WM53*(NS==esm3) +...
                             WM56*(NS==esm6)   + WM59*(NS==esm9);
                
                % If flipped coin can result in greater energy decrease, accept it:
                if delenergy2 >= delenergy1
                    s(pt) = NS;
                    if consider_energy == 1; delenergy1 = delenergy2; end
                end
                if consider_energy == 1; delE(pt) = delenergy1; end
            end
        end
        % if mod(ms,500) == 0
        if mod(ms, txtwriteint) == 0
            if ConsoleDisplay == 1; fprintf('%dx%d.||.m:%d/%d.\n', sz1, sz2, ms, finalmcs)
            elseif ConsoleDisplay == 2
                if initialmcs == 1
                    if consider_energy == 1
                        STRING = '%dx%d.||.q%d.||.m:%d/%d.||.%2.4f%%Comp.||.ham:%d.||.vf.slsp:%2.2f%%.||.vf.cnt:%2.2f%%.||.vf.slspc:%2.2f%%.||.vf.tot:%2.2f%%.||\n';
                        fprintf(STRING, sz1, sz2, q, ms, finalmcs, ms*100/finalmcs, sum(sum(E)), vf(1), vf(2), vf(3), vf(4))
                    else
                        STRING = '%dx%d.||.q%d.||.m:%d/%d.||.%2.4f%%Comp.||.vf.slsp:%2.2f%%.||.vf.cnt:%2.2f%%.||.vf.slspc:%2.2f%%.||.vf.tot:%2.2f%%.||\n';
                        fprintf(STRING, sz1, sz2, q, ms, finalmcs, ms*100/finalmcs, vf(1), vf(2), vf(3), vf(4))
                    end
                else
                    if consider_energy == 1
                        STRING = '%dx%d.||.q%d.||.m:%d/%d.||.%2.4f%%Comp.||.%2.4f%%Comp.||.ham:%d.||.vf.slsp:%2.2f%%.||.vf.cnt:%2.2f%%.||.vf.slspc:%2.2f%%.||.vf.tot:%2.2f%%.||\n';
                        fprintf(STRING, sz1, sz2, q, ms, finalmcs, (ms-start)*100/(finalmcs-start),...
                            (ms-start)*100/finalmcs+(start)*100/finalmcs, sum(sum(E)), vf(1), vf(2), vf(3), vf(4))
                    else
                        STRING = '%dx%d.||.q%d.||.m:%d/%d.||.%2.4f%%Comp.||.%2.4f%%Comp.||.vf.slsp:%2.2f%%.||.vf.cnt:%2.2f%%.||.vf.slspc:%2.2f%%.||.vf.tot:%2.2f%%.||\n';
                        fprintf(STRING, sz1, sz2, q, ms, finalmcs, (ms-start)*100/(finalmcs-start),...
                            (ms-start)*100/finalmcs+(start)*100/finalmcs, vf(1), vf(2), vf(3), vf(4))
                    end
                end
            end
        end
        if mod(ms, txtwriteint) == 0
            for count = 1:nof;
                dlmwrite(strcat(pwd, '\results\datafiles\statematrices', '\', 's', num2str(ms),...
                    'mcs', num2str(count), '.txt'), s(:,(count-1)*floor(sz2/nof)+1:count*floor(sz2/nof)), 'delimiter','\t');
            end
            if nof~=1 && mod(sz2,2)~=0; dlmwrite(strcat(pwd,'\results\datafiles\statematrices', '\',...
                    's', num2str(ms),'mcs', num2str(nof+1),'.txt'), s(:,(nof)*floor(sz2/nof)+1:size(s,2)),'delimiter','\t');
            end
            if displaydatawriteprogress == 1
                fprintf('Finished writing partitioned s{%s} matrix to disk\n', num2str(ms))
            end
            delham(ms) = sum(sum(delE));
        end
    end
end
%% Algrithm # 4443
% Reversed counting scheme. Does not change anything!!.Same as Algorithm # 4442
if algorithm == 4443 %KERNEL__LOOP_MC_2D____ALGORITHM_12
    nums = numel(s);
    numsarray = 1:nums;
    PTA = 2*ceil(numsarray/sz1) + SZS1P1 + numsarray;
    displaydatawriteprogress = 0;
    for ms = start:finalmcs
        ns = floor(1+q*rand(nums,1));
        for pt = nums:-1:1
            if skipmatrix(pt) == 0
                
                pta  = PTA(pt);
                
                esm1 = s(ea(pta-SZS1P3)); esm2 = s(ea(pta-SZS1P2)); esm3 = s(ea(pta-SZS1P1));
                esm4 = s(ea(pta-1));      esm5 = s(ea(pta));        esm6 = s(ea(pta+1));
                esm7 = s(ea(pta+SZS1P1)); esm8 = s(ea(pta+SZS1P2)); esm9 = s(ea(pta+SZS1P3));
                
                delenergy1 = WM51*(esm5==esm1) + WM54*(esm5==esm4) + WM57*(esm5==esm7) +...
                             WM52*(esm5==esm2) + WM58*(esm5==esm8) + WM53*(esm5==esm3) +...
                             WM56*(esm5==esm6) + WM59*(esm5==esm9);
                
                NS = ns(pt);
                
                delenergy2 = WM51*(NS==esm1)   + WM54*(NS==esm4)   + WM57*(NS==esm7) +...
                             WM52*(NS==esm2)   + WM58*(NS==esm8)   + WM53*(NS==esm3) +...
                             WM56*(NS==esm6)   + WM59*(NS==esm9);
                
                % If flipped coin can result in greater energy decrease, accept it:
                if delenergy2 >= delenergy1
                    s(pt) = NS;
                    if consider_energy == 1; delenergy1 = delenergy2; end
                end
                if consider_energy == 1; delE(pt) = delenergy1; end
            end
        end
        % if mod(ms,500) == 0
        if mod(ms, txtwriteint) == 0
            if ConsoleDisplay == 1; fprintf('%dx%d.||.m:%d/%d.\n', sz1, sz2, ms, finalmcs)
            elseif ConsoleDisplay == 2
                if initialmcs == 1
                    if consider_energy == 1
                        STRING = '%dx%d.||.q%d.||.m:%d/%d.||.%2.4f%%Comp.||.ham:%d.||.vf.slsp:%2.2f%%.||.vf.cnt:%2.2f%%.||.vf.slspc:%2.2f%%.||.vf.tot:%2.2f%%.||\n';
                        fprintf(STRING, sz1, sz2, q, ms, finalmcs, ms*100/finalmcs, sum(sum(E)), vf(1), vf(2), vf(3), vf(4))
                    else
                        STRING = '%dx%d.||.q%d.||.m:%d/%d.||.%2.4f%%Comp.||.vf.slsp:%2.2f%%.||.vf.cnt:%2.2f%%.||.vf.slspc:%2.2f%%.||.vf.tot:%2.2f%%.||\n';
                        fprintf(STRING, sz1, sz2, q, ms, finalmcs, ms*100/finalmcs, vf(1), vf(2), vf(3), vf(4))
                    end
                else
                    if consider_energy == 1
                        STRING = '%dx%d.||.q%d.||.m:%d/%d.||.%2.4f%%Comp.||.%2.4f%%Comp.||.ham:%d.||.vf.slsp:%2.2f%%.||.vf.cnt:%2.2f%%.||.vf.slspc:%2.2f%%.||.vf.tot:%2.2f%%.||\n';
                        fprintf(STRING, sz1, sz2, q, ms, finalmcs, (ms-start)*100/(finalmcs-start),...
                            (ms-start)*100/finalmcs+(start)*100/finalmcs, sum(sum(E)), vf(1), vf(2), vf(3), vf(4))
                    else
                        STRING = '%dx%d.||.q%d.||.m:%d/%d.||.%2.4f%%Comp.||.%2.4f%%Comp.||.vf.slsp:%2.2f%%.||.vf.cnt:%2.2f%%.||.vf.slspc:%2.2f%%.||.vf.tot:%2.2f%%.||\n';
                        fprintf(STRING, sz1, sz2, q, ms, finalmcs, (ms-start)*100/(finalmcs-start),...
                            (ms-start)*100/finalmcs+(start)*100/finalmcs, vf(1), vf(2), vf(3), vf(4))
                    end
                end
            end
        end
        if mod(ms, txtwriteint) == 0
            for count = 1:nof;
                dlmwrite(strcat(pwd, '\results\datafiles\statematrices', '\', 's', num2str(ms),...
                    'mcs', num2str(count), '.txt'), s(:,(count-1)*floor(sz2/nof)+1:count*floor(sz2/nof)), 'delimiter','\t');
            end
            if nof~=1 && mod(sz2,2)~=0; dlmwrite(strcat(pwd,'\results\datafiles\statematrices', '\',...
                    's', num2str(ms),'mcs', num2str(nof+1),'.txt'), s(:,(nof)*floor(sz2/nof)+1:size(s,2)),'delimiter','\t');
            end
            if displaydatawriteprogress == 1
                fprintf('Finished writing partitioned s{%s} matrix to disk\n', num2str(ms))
            end
            delham(ms) = sum(sum(delE));
        end
    end
end
%% Algorithm # 4444
if algorithm == 4444
    nums = numel(s);
    numsarray = 1:nums;
    PTA = 2*ceil(numsarray/sz1) + SZS1P1 + numsarray;
    displaydatawriteprogress = 0;
    for ms = start:finalmcs
        ns = floor(1+q*rand(nums,1));
        for pt = 1:nums
            if skipmatrix(pt) == 0
                
                pta  = PTA(pt);
                
                esm1 = s(ea(pta-SZS1P3)); esm2 = s(ea(pta-SZS1P2)); esm3 = s(ea(pta-SZS1P1));
                esm4 = s(ea(pta-1));      esm5 = s(ea(pta));        esm6 = s(ea(pta+1));
                esm7 = s(ea(pta+SZS1P1)); esm8 = s(ea(pta+SZS1P2)); esm9 = s(ea(pta+SZS1P3));
                
                delenergy1 = WM51*(esm5==esm1) + WM54*(esm5==esm4) + WM57*(esm5==esm7) +...
                             WM52*(esm5==esm2) + WM58*(esm5==esm8) + WM53*(esm5==esm3) +...
                             WM56*(esm5==esm6) + WM59*(esm5==esm9);
                
                NS = ns(pt);
                
                delenergy2 = WM51*(NS==esm1)   + WM54*(NS==esm4)   + WM57*(NS==esm7) +...
                             WM52*(NS==esm2)   + WM58*(NS==esm8)   + WM53*(NS==esm3) +...
                             WM56*(NS==esm6)   + WM59*(NS==esm9);
                
                % If flipped coin can result in greater energy decrease, accept it:
                if delenergy2 >= delenergy1
                    s(pt) = NS;
                    if consider_energy == 1; delenergy1 = delenergy2; end
                end
                if consider_energy == 1; delE(pt) = delenergy1; end
            end
        end
        % if mod(ms,500) == 0
        if mod(ms, txtwriteint) == 0
            if ConsoleDisplay == 1; fprintf('%dx%d.||.m:%d/%d.\n', sz1, sz2, ms, finalmcs)
            elseif ConsoleDisplay == 2
                if initialmcs == 1
                    if consider_energy == 1
                        STRING = '%dx%d.||.q%d.||.m:%d/%d.||.%2.4f%%Comp.||.ham:%d.||.vf.slsp:%2.2f%%.||.vf.cnt:%2.2f%%.||.vf.slspc:%2.2f%%.||.vf.tot:%2.2f%%.||\n';
                        fprintf(STRING, sz1, sz2, q, ms, finalmcs, ms*100/finalmcs, sum(sum(E)), vf(1), vf(2), vf(3), vf(4))
                    else
                        STRING = '%dx%d.||.q%d.||.m:%d/%d.||.%2.4f%%Comp.||.vf.slsp:%2.2f%%.||.vf.cnt:%2.2f%%.||.vf.slspc:%2.2f%%.||.vf.tot:%2.2f%%.||\n';
                        fprintf(STRING, sz1, sz2, q, ms, finalmcs, ms*100/finalmcs, vf(1), vf(2), vf(3), vf(4))
                    end
                else
                    if consider_energy == 1
                        STRING = '%dx%d.||.q%d.||.m:%d/%d.||.%2.4f%%Comp.||.%2.4f%%Comp.||.ham:%d.||.vf.slsp:%2.2f%%.||.vf.cnt:%2.2f%%.||.vf.slspc:%2.2f%%.||.vf.tot:%2.2f%%.||\n';
                        fprintf(STRING, sz1, sz2, q, ms, finalmcs, (ms-start)*100/(finalmcs-start),...
                            (ms-start)*100/finalmcs+(start)*100/finalmcs, sum(sum(E)), vf(1), vf(2), vf(3), vf(4))
                    else
                        STRING = '%dx%d.||.q%d.||.m:%d/%d.||.%2.4f%%Comp.||.%2.4f%%Comp.||.vf.slsp:%2.2f%%.||.vf.cnt:%2.2f%%.||.vf.slspc:%2.2f%%.||.vf.tot:%2.2f%%.||\n';
                        fprintf(STRING, sz1, sz2, q, ms, finalmcs, (ms-start)*100/(finalmcs-start),...
                            (ms-start)*100/finalmcs+(start)*100/finalmcs, vf(1), vf(2), vf(3), vf(4))
                    end
                end
            end
        end
        if mod(ms, txtwriteint) == 0
            for count = 1:nof;
                dlmwrite(strcat(pwd, '\results\datafiles\statematrices', '\', 's', num2str(ms),...
                    'mcs', num2str(count), '.txt'), s(:,(count-1)*floor(sz2/nof)+1:count*floor(sz2/nof)), 'delimiter','\t');
            end
            if nof~=1 && mod(sz2,2)~=0; dlmwrite(strcat(pwd,'\results\datafiles\statematrices', '\',...
                    's', num2str(ms),'mcs', num2str(nof+1),'.txt'), s(:,(nof)*floor(sz2/nof)+1:size(s,2)),'delimiter','\t');
            end
            if displaydatawriteprogress == 1
                fprintf('Finished writing partitioned s{%s} matrix to disk\n', num2str(ms))
            end
            delham(ms) = sum(sum(delE));
        end
    end
end
%% Algorithm # 4445
if algorithm == 4445
    nums = numel(s);
    numsarray = 1:nums;
    PTA = 2*ceil(numsarray/sz1) + SZS1P1 + numsarray;
    displaydatawriteprogress = 0;
    for ms = start:finalmcs
        ns = floor(1+q*rand(nums,1));
        WM51 = rand; WM54 = rand; WM57 = rand;
        WM52 = rand;              WM58 = rand;
        WM53 = rand; WM56 = rand; WM59 = rand;
        for pt = 1:nums
            if skipmatrix(pt) == 0
                
                pta  = PTA(pt);
                
                esm1 = s(ea(pta-SZS1P3)); esm2 = s(ea(pta-SZS1P2)); esm3 = s(ea(pta-SZS1P1));
                esm4 = s(ea(pta-1));      esm5 = s(ea(pta));        esm6 = s(ea(pta+1));
                esm7 = s(ea(pta+SZS1P1)); esm8 = s(ea(pta+SZS1P2)); esm9 = s(ea(pta+SZS1P3));
                
                delenergy1 = WM51*(esm5==esm1) + WM54*(esm5==esm4) + WM57*(esm5==esm7) +...
                             WM52*(esm5==esm2) + WM58*(esm5==esm8) + WM53*(esm5==esm3) +...
                             WM56*(esm5==esm6) + WM59*(esm5==esm9);
                
                NS = ns(pt);
                
                delenergy2 = WM51*(NS==esm1)   + WM54*(NS==esm4)   + WM57*(NS==esm7) +...
                             WM52*(NS==esm2)   + WM58*(NS==esm8)   + WM53*(NS==esm3) +...
                             WM56*(NS==esm6)   + WM59*(NS==esm9);
                
                % If flipped coin can result in greater energy decrease, accept it:
                if delenergy2 >= delenergy1
                    s(pt) = NS;
                    if consider_energy == 1; delenergy1 = delenergy2; end
                end
                if consider_energy == 1; delE(pt) = delenergy1; end
            end
        end
        % if mod(ms,500) == 0
        if mod(ms, txtwriteint) == 0
            if ConsoleDisplay == 1; fprintf('%dx%d.||.m:%d/%d.\n', sz1, sz2, ms, finalmcs)
            elseif ConsoleDisplay == 2
                if initialmcs == 1
                    if consider_energy == 1
                        STRING = '%dx%d.||.q%d.||.m:%d/%d.||.%2.4f%%Comp.||.ham:%d.||.vf.slsp:%2.2f%%.||.vf.cnt:%2.2f%%.||.vf.slspc:%2.2f%%.||.vf.tot:%2.2f%%.||\n';
                        fprintf(STRING, sz1, sz2, q, ms, finalmcs, ms*100/finalmcs, sum(sum(E)), vf(1), vf(2), vf(3), vf(4))
                    else
                        STRING = '%dx%d.||.q%d.||.m:%d/%d.||.%2.4f%%Comp.||.vf.slsp:%2.2f%%.||.vf.cnt:%2.2f%%.||.vf.slspc:%2.2f%%.||.vf.tot:%2.2f%%.||\n';
                        fprintf(STRING, sz1, sz2, q, ms, finalmcs, ms*100/finalmcs, vf(1), vf(2), vf(3), vf(4))
                    end
                else
                    if consider_energy == 1
                        STRING = '%dx%d.||.q%d.||.m:%d/%d.||.%2.4f%%Comp.||.%2.4f%%Comp.||.ham:%d.||.vf.slsp:%2.2f%%.||.vf.cnt:%2.2f%%.||.vf.slspc:%2.2f%%.||.vf.tot:%2.2f%%.||\n';
                        fprintf(STRING, sz1, sz2, q, ms, finalmcs, (ms-start)*100/(finalmcs-start),...
                            (ms-start)*100/finalmcs+(start)*100/finalmcs, sum(sum(E)), vf(1), vf(2), vf(3), vf(4))
                    else
                        STRING = '%dx%d.||.q%d.||.m:%d/%d.||.%2.4f%%Comp.||.%2.4f%%Comp.||.vf.slsp:%2.2f%%.||.vf.cnt:%2.2f%%.||.vf.slspc:%2.2f%%.||.vf.tot:%2.2f%%.||\n';
                        fprintf(STRING, sz1, sz2, q, ms, finalmcs, (ms-start)*100/(finalmcs-start),...
                            (ms-start)*100/finalmcs+(start)*100/finalmcs, vf(1), vf(2), vf(3), vf(4))
                    end
                end
            end
        end
        if mod(ms, txtwriteint) == 0
            for count = 1:nof;
                dlmwrite(strcat(pwd, '\results\datafiles\statematrices', '\', 's', num2str(ms),...
                    'mcs', num2str(count), '.txt'), s(:,(count-1)*floor(sz2/nof)+1:count*floor(sz2/nof)), 'delimiter','\t');
            end
            if nof~=1 && mod(sz2,2)~=0; dlmwrite(strcat(pwd,'\results\datafiles\statematrices', '\',...
                    's', num2str(ms),'mcs', num2str(nof+1),'.txt'), s(:,(nof)*floor(sz2/nof)+1:size(s,2)),'delimiter','\t');
            end
            if displaydatawriteprogress == 1
                fprintf('Finished writing partitioned s{%s} matrix to disk\n', num2str(ms))
            end
            delham(ms) = sum(sum(delE));
        end
    end
end
%% Algorithm # 4446
if algorithm == 4446
    nums = numel(s);
    numsarray = 1:nums;
    PTA = 2*ceil(numsarray/sz1) + SZS1P1 + numsarray;
    displaydatawriteprogress = 0;
    for ms = start:finalmcs
        ns = floor(1+q*rand(nums,1));
        constant_centre = 2;
        WM51 = 1.0*constant_centre + 2.0*randn; WM54 = 2.0*constant_centre + 1.0*randn; WM57 = 1.0*constant_centre + 2.0*randn;
        WM52 = 2.0*constant_centre + 1.0*randn;                                         WM58 = 2.0*constant_centre + 1.0*randn;
        WM53 = 1.0*constant_centre + 2.0*randn; WM56 = 2.0*constant_centre + 1.0*randn; WM59 = 1.0*constant_centre + 2.0*randn;
        for pt = 1:nums
            if skipmatrix(pt) == 0
                
                pta  = PTA(pt);
                
                esm1 = s(ea(pta-SZS1P3)); esm2 = s(ea(pta-SZS1P2)); esm3 = s(ea(pta-SZS1P1));
                esm4 = s(ea(pta-1));      esm5 = s(ea(pta));        esm6 = s(ea(pta+1));
                esm7 = s(ea(pta+SZS1P1)); esm8 = s(ea(pta+SZS1P2)); esm9 = s(ea(pta+SZS1P3));
                
                delenergy1 = WM51*(esm5==esm1) + WM54*(esm5==esm4) + WM57*(esm5==esm7) +...
                             WM52*(esm5==esm2) + WM58*(esm5==esm8) + WM53*(esm5==esm3) +...
                             WM56*(esm5==esm6) + WM59*(esm5==esm9);
                
                NS = ns(pt);
                
                delenergy2 = WM51*(NS==esm1)   + WM54*(NS==esm4)   + WM57*(NS==esm7) +...
                             WM52*(NS==esm2)   + WM58*(NS==esm8)   + WM53*(NS==esm3) +...
                             WM56*(NS==esm6)   + WM59*(NS==esm9);
                
                % If flipped coin can result in greater energy decrease, accept it:
                if delenergy2 >= delenergy1
                    s(pt) = NS;
                    if consider_energy == 1; delenergy1 = delenergy2; end
                end
                if consider_energy == 1; delE(pt) = delenergy1; end
            end
        end
        % if mod(ms,500) == 0
        if mod(ms, txtwriteint) == 0
            if ConsoleDisplay == 1; fprintf('%dx%d.||.m:%d/%d.\n', sz1, sz2, ms, finalmcs)
            elseif ConsoleDisplay == 2
                if initialmcs == 1
                    if consider_energy == 1
                        STRING = '%dx%d.||.q%d.||.m:%d/%d.||.%2.4f%%Comp.||.ham:%d.||.vf.slsp:%2.2f%%.||.vf.cnt:%2.2f%%.||.vf.slspc:%2.2f%%.||.vf.tot:%2.2f%%.||\n';
                        fprintf(STRING, sz1, sz2, q, ms, finalmcs, ms*100/finalmcs, sum(sum(E)), vf(1), vf(2), vf(3), vf(4))
                    else
                        STRING = '%dx%d.||.q%d.||.m:%d/%d.||.%2.4f%%Comp.||.vf.slsp:%2.2f%%.||.vf.cnt:%2.2f%%.||.vf.slspc:%2.2f%%.||.vf.tot:%2.2f%%.||\n';
                        fprintf(STRING, sz1, sz2, q, ms, finalmcs, ms*100/finalmcs, vf(1), vf(2), vf(3), vf(4))
                    end
                else
                    if consider_energy == 1
                        STRING = '%dx%d.||.q%d.||.m:%d/%d.||.%2.4f%%Comp.||.%2.4f%%Comp.||.ham:%d.||.vf.slsp:%2.2f%%.||.vf.cnt:%2.2f%%.||.vf.slspc:%2.2f%%.||.vf.tot:%2.2f%%.||\n';
                        fprintf(STRING, sz1, sz2, q, ms, finalmcs, (ms-start)*100/(finalmcs-start),...
                            (ms-start)*100/finalmcs+(start)*100/finalmcs, sum(sum(E)), vf(1), vf(2), vf(3), vf(4))
                    else
                        STRING = '%dx%d.||.q%d.||.m:%d/%d.||.%2.4f%%Comp.||.%2.4f%%Comp.||.vf.slsp:%2.2f%%.||.vf.cnt:%2.2f%%.||.vf.slspc:%2.2f%%.||.vf.tot:%2.2f%%.||\n';
                        fprintf(STRING, sz1, sz2, q, ms, finalmcs, (ms-start)*100/(finalmcs-start),...
                            (ms-start)*100/finalmcs+(start)*100/finalmcs, vf(1), vf(2), vf(3), vf(4))
                    end
                end
            end
        end
        if mod(ms, txtwriteint) == 0
            for count = 1:nof;
                dlmwrite(strcat(pwd, '\results\datafiles\statematrices', '\', 's', num2str(ms),...
                    'mcs', num2str(count), '.txt'), s(:,(count-1)*floor(sz2/nof)+1:count*floor(sz2/nof)), 'delimiter','\t');
            end
            if nof~=1 && mod(sz2,2)~=0; dlmwrite(strcat(pwd,'\results\datafiles\statematrices', '\',...
                    's', num2str(ms),'mcs', num2str(nof+1),'.txt'), s(:,(nof)*floor(sz2/nof)+1:size(s,2)),'delimiter','\t');
            end
            if displaydatawriteprogress == 1
                fprintf('Finished writing partitioned s{%s} matrix to disk\n', num2str(ms))
            end
            delham(ms) = sum(sum(delE));
        end
    end
end
%% Algorithm # 4447
if algorithm == 4447
    nums = numel(s);
    numsarray = 1:nums;
    PTA = 2*ceil(numsarray/sz1) + SZS1P1 + numsarray;
    displaydatawriteprogress = 0;
    for ms = start:finalmcs
        ns = floor(1+q*rand(nums,1));
%         constant_centre = 2;
%         WM51 = 1.0*constant_centre + 2.0*randn; WM54 = 2.0*constant_centre + 1.0*randn; WM57 = 1.0*constant_centre + 2.0*randn;
%         WM52 = 2.0*constant_centre + 1.0*randn;                                         WM58 = 2.0*constant_centre + 1.0*randn;
%         WM53 = 1.0*constant_centre + 2.0*randn; WM56 = 2.0*constant_centre + 1.0*randn; WM59 = 1.0*constant_centre + 2.0*randn;
        for pt = 1:nums
            if skipmatrix(pt) == 0
                
                constant_centre = 2;
                WM51 = 1.0*constant_centre + 2.0*randn; WM54 = 2.0*constant_centre + 1.0*randn; WM57 = 1.0*constant_centre + 2.0*randn;
                WM52 = 2.0*constant_centre + 1.0*randn;                                         WM58 = 2.0*constant_centre + 1.0*randn;
                WM53 = 1.0*constant_centre + 2.0*randn; WM56 = 2.0*constant_centre + 1.0*randn; WM59 = 1.0*constant_centre + 2.0*randn;
 
                pta  = PTA(pt);
                
                esm1 = s(ea(pta-SZS1P3)); esm2 = s(ea(pta-SZS1P2)); esm3 = s(ea(pta-SZS1P1));
                esm4 = s(ea(pta-1));      esm5 = s(ea(pta));        esm6 = s(ea(pta+1));
                esm7 = s(ea(pta+SZS1P1)); esm8 = s(ea(pta+SZS1P2)); esm9 = s(ea(pta+SZS1P3));
                
                delenergy1 = WM51*(esm5==esm1) + WM54*(esm5==esm4) + WM57*(esm5==esm7) +...
                             WM52*(esm5==esm2) + WM58*(esm5==esm8) + WM53*(esm5==esm3) +...
                             WM56*(esm5==esm6) + WM59*(esm5==esm9);
                
                NS = ns(pt);
                
                delenergy2 = WM51*(NS==esm1)   + WM54*(NS==esm4)   + WM57*(NS==esm7) +...
                             WM52*(NS==esm2)   + WM58*(NS==esm8)   + WM53*(NS==esm3) +...
                             WM56*(NS==esm6)   + WM59*(NS==esm9);
                
                % If flipped coin can result in greater energy decrease, accept it:
                if delenergy2 >= delenergy1
                    s(pt) = NS;
                    if consider_energy == 1; delenergy1 = delenergy2; end
                end
                if consider_energy == 1; delE(pt) = delenergy1; end
            end
        end
        % if mod(ms,500) == 0
        if mod(ms, txtwriteint) == 0
            if ConsoleDisplay == 1; fprintf('%dx%d.||.m:%d/%d.\n', sz1, sz2, ms, finalmcs)
            elseif ConsoleDisplay == 2
                if initialmcs == 1
                    if consider_energy == 1
                        STRING = '%dx%d.||.q%d.||.m:%d/%d.||.%2.4f%%Comp.||.ham:%d.||.vf.slsp:%2.2f%%.||.vf.cnt:%2.2f%%.||.vf.slspc:%2.2f%%.||.vf.tot:%2.2f%%.||\n';
                        fprintf(STRING, sz1, sz2, q, ms, finalmcs, ms*100/finalmcs, sum(sum(E)), vf(1), vf(2), vf(3), vf(4))
                    else
                        STRING = '%dx%d.||.q%d.||.m:%d/%d.||.%2.4f%%Comp.||.vf.slsp:%2.2f%%.||.vf.cnt:%2.2f%%.||.vf.slspc:%2.2f%%.||.vf.tot:%2.2f%%.||\n';
                        fprintf(STRING, sz1, sz2, q, ms, finalmcs, ms*100/finalmcs, vf(1), vf(2), vf(3), vf(4))
                    end
                else
                    if consider_energy == 1
                        STRING = '%dx%d.||.q%d.||.m:%d/%d.||.%2.4f%%Comp.||.%2.4f%%Comp.||.ham:%d.||.vf.slsp:%2.2f%%.||.vf.cnt:%2.2f%%.||.vf.slspc:%2.2f%%.||.vf.tot:%2.2f%%.||\n';
                        fprintf(STRING, sz1, sz2, q, ms, finalmcs, (ms-start)*100/(finalmcs-start),...
                            (ms-start)*100/finalmcs+(start)*100/finalmcs, sum(sum(E)), vf(1), vf(2), vf(3), vf(4))
                    else
                        STRING = '%dx%d.||.q%d.||.m:%d/%d.||.%2.4f%%Comp.||.%2.4f%%Comp.||.vf.slsp:%2.2f%%.||.vf.cnt:%2.2f%%.||.vf.slspc:%2.2f%%.||.vf.tot:%2.2f%%.||\n';
                        fprintf(STRING, sz1, sz2, q, ms, finalmcs, (ms-start)*100/(finalmcs-start),...
                            (ms-start)*100/finalmcs+(start)*100/finalmcs, vf(1), vf(2), vf(3), vf(4))
                    end
                end
            end
        end
        if mod(ms, txtwriteint) == 0
            for count = 1:nof;
                dlmwrite(strcat(pwd, '\results\datafiles\statematrices', '\', 's', num2str(ms),...
                    'mcs', num2str(count), '.txt'), s(:,(count-1)*floor(sz2/nof)+1:count*floor(sz2/nof)), 'delimiter','\t');
            end
            if nof~=1 && mod(sz2,2)~=0; dlmwrite(strcat(pwd,'\results\datafiles\statematrices', '\',...
                    's', num2str(ms),'mcs', num2str(nof+1),'.txt'), s(:,(nof)*floor(sz2/nof)+1:size(s,2)),'delimiter','\t');
            end
            if displaydatawriteprogress == 1
                fprintf('Finished writing partitioned s{%s} matrix to disk\n', num2str(ms))
            end
            delham(ms) = sum(sum(delE));
        end
    end
end
%% Algorithm # 4448
if algorithm == 4448
    nums = numel(s);
    numsarray = 1:nums;
    PTA = 2*ceil(numsarray/sz1) + SZS1P1 + numsarray;
    displaydatawriteprogress = 0;
    for ms = start:finalmcs
        ns = floor(1+q*rand(nums,1));
%         constant_centre = 2;
%         WM51 = 1.0*constant_centre + 2.0*randn; WM54 = 2.0*constant_centre + 1.0*randn; WM57 = 1.0*constant_centre + 2.0*randn;
%         WM52 = 2.0*constant_centre + 1.0*randn;                                         WM58 = 2.0*constant_centre + 1.0*randn;
%         WM53 = 1.0*constant_centre + 2.0*randn; WM56 = 2.0*constant_centre + 1.0*randn; WM59 = 1.0*constant_centre + 2.0*randn;
        for pt = 1:nums
            if skipmatrix(pt) == 0
                
                %%%%%%%%%%%%%%%%%%%%%%
                % Stable growth. Bi-modal grain structure
                constant_centre = 2;
                WM51 = 1.0*constant_centre + 2.0*rand; WM54 = 2.0*constant_centre + 1.0*rand; WM57 = 1.0*constant_centre + 2.0*rand;
                WM52 = 2.0*constant_centre + 1.0*rand;                                        WM58 = 2.0*constant_centre + 1.0*rand;
                WM53 = 1.0*constant_centre + 2.0*rand; WM56 = 2.0*constant_centre + 1.0*rand; WM59 = 1.0*constant_centre + 2.0*rand;
                %%%%%%%%%%%%%%%%%%%%%%
                pta  = PTA(pt);
                
                esm1 = s(ea(pta-SZS1P3)); esm2 = s(ea(pta-SZS1P2)); esm3 = s(ea(pta-SZS1P1));
                esm4 = s(ea(pta-1));      esm5 = s(ea(pta));        esm6 = s(ea(pta+1));
                esm7 = s(ea(pta+SZS1P1)); esm8 = s(ea(pta+SZS1P2)); esm9 = s(ea(pta+SZS1P3));
                
                delenergy1 = WM51*(esm5==esm1) + WM54*(esm5==esm4) + WM57*(esm5==esm7) +...
                             WM52*(esm5==esm2) + WM58*(esm5==esm8) + WM53*(esm5==esm3) +...
                             WM56*(esm5==esm6) + WM59*(esm5==esm9);
                
                NS = ns(pt);
                
                delenergy2 = WM51*(NS==esm1)   + WM54*(NS==esm4)   + WM57*(NS==esm7) +...
                             WM52*(NS==esm2)   + WM58*(NS==esm8)   + WM53*(NS==esm3) +...
                             WM56*(NS==esm6)   + WM59*(NS==esm9);
                
                % If flipped coin can result in greater energy decrease, accept it:
                if delenergy2 >= delenergy1
                    s(pt) = NS;
                    if consider_energy == 1; delenergy1 = delenergy2; end
                end
                if consider_energy == 1; delE(pt) = delenergy1; end
            end
        end
        % if mod(ms,500) == 0
        if mod(ms, txtwriteint) == 0
            if ConsoleDisplay == 1; fprintf('%dx%d.||.m:%d/%d.\n', sz1, sz2, ms, finalmcs)
            elseif ConsoleDisplay == 2
                if initialmcs == 1
                    if consider_energy == 1
                        STRING = '%dx%d.||.q%d.||.m:%d/%d.||.%2.4f%%Comp.||.ham:%d.||.vf.slsp:%2.2f%%.||.vf.cnt:%2.2f%%.||.vf.slspc:%2.2f%%.||.vf.tot:%2.2f%%.||\n';
                        fprintf(STRING, sz1, sz2, q, ms, finalmcs, ms*100/finalmcs, sum(sum(E)), vf(1), vf(2), vf(3), vf(4))
                    else
                        STRING = '%dx%d.||.q%d.||.m:%d/%d.||.%2.4f%%Comp.||.vf.slsp:%2.2f%%.||.vf.cnt:%2.2f%%.||.vf.slspc:%2.2f%%.||.vf.tot:%2.2f%%.||\n';
                        fprintf(STRING, sz1, sz2, q, ms, finalmcs, ms*100/finalmcs, vf(1), vf(2), vf(3), vf(4))
                    end
                else
                    if consider_energy == 1
                        STRING = '%dx%d.||.q%d.||.m:%d/%d.||.%2.4f%%Comp.||.%2.4f%%Comp.||.ham:%d.||.vf.slsp:%2.2f%%.||.vf.cnt:%2.2f%%.||.vf.slspc:%2.2f%%.||.vf.tot:%2.2f%%.||\n';
                        fprintf(STRING, sz1, sz2, q, ms, finalmcs, (ms-start)*100/(finalmcs-start),...
                            (ms-start)*100/finalmcs+(start)*100/finalmcs, sum(sum(E)), vf(1), vf(2), vf(3), vf(4))
                    else
                        STRING = '%dx%d.||.q%d.||.m:%d/%d.||.%2.4f%%Comp.||.%2.4f%%Comp.||.vf.slsp:%2.2f%%.||.vf.cnt:%2.2f%%.||.vf.slspc:%2.2f%%.||.vf.tot:%2.2f%%.||\n';
                        fprintf(STRING, sz1, sz2, q, ms, finalmcs, (ms-start)*100/(finalmcs-start),...
                            (ms-start)*100/finalmcs+(start)*100/finalmcs, vf(1), vf(2), vf(3), vf(4))
                    end
                end
            end
        end
        if mod(ms, txtwriteint) == 0
            for count = 1:nof;
                dlmwrite(strcat(pwd, '\results\datafiles\statematrices', '\', 's', num2str(ms),...
                    'mcs', num2str(count), '.txt'), s(:,(count-1)*floor(sz2/nof)+1:count*floor(sz2/nof)), 'delimiter','\t');
            end
            if nof~=1 && mod(sz2,2)~=0; dlmwrite(strcat(pwd,'\results\datafiles\statematrices', '\',...
                    's', num2str(ms),'mcs', num2str(nof+1),'.txt'), s(:,(nof)*floor(sz2/nof)+1:size(s,2)),'delimiter','\t');
            end
            if displaydatawriteprogress == 1
                fprintf('Finished writing partitioned s{%s} matrix to disk\n', num2str(ms))
            end
            delham(ms) = sum(sum(delE));
        end
    end
end
%% Store energy or energy change
if consider_energy == 1
    if initialmcs == 1;
        ham(ham==0)=[]; % remove zeros
        dlmwrite(strcat(pwd,'\results','\datafiles','\hamiltonian.txt'),ham)
        if algorithm == 4441 || algorithm == 44411
            delham(delham==0)=[]; % remove zeros
            dlmwrite(strcat(pwd,'\results','\datafiles','\CHangeInHamiltonian.txt'),delham)
        end
        
    else
        ham = [ham; initialham];
        delete(strcat(pwd,'\results\datafiles\hamiltonian.txt'))
        dlmwrite(strcat(pwd,'\results','\datafiles','\hamiltonian_1.txt'),ham)
        if algorithm == 4441 || algorithm == 44411
            delete(strcat(pwd,'\results\datafiles\ChangeInHamiltonian.txt'))
            dlmwrite(strcat(pwd,'\results','\datafiles','\CHangeInHamiltonian_1.txt'),delham)
        end
    end
end
dlmwrite(strcat(pwd,'\results','\datafiles','parallelcodecheckpoints.txt'),0,'delimiter','\t')

CFN = length(findobj('type','figure'));
end