function KERNEL__LOOP_MC_2D____ALGORITHM_14(initialmcs, finalmcs, consider_energy, E, delE, ham, SZS1P1, SZS1P2, SZS1P3, vf, skipmatrix, ConsoleDisplay)
%-------------------------------------------------------------
% After every sweep of the lattice in 1 MC step, the WM is randomized
%-------------------------------------------------------------
global MC_Param Lattice MC_Loop CMDL_display File_Fold_Operations
%-------------------------------------------------------------
sz1             = Lattice.size.sz1;
sz2             = Lattice.size.sz2;
s               = Lattice.orientations.s;
q               = Lattice.q;
ea              = Lattice.s__MATLAB_Indices__BounCond_Wrapped;
Consider_Energy = MC_Param.Consider_Energy;
txtwriteint     = MC_Loop.DataOperation.txtwriteint;
nof             = File_Fold_Operations.writedlm.s.nof;
%-------------------------------------------------------------
start = initialmcs;
%-------------------------------------------------------------
nums = numel(s);
numsarray = 1:nums;
PTA = 2*ceil(numsarray/sz1) + SZS1P1 + numsarray;
displaydatawriteprogress = 0;
%-------------------------------------------------------------
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
    if mod(ms, CMDL_display.MC_Kernel__Prog_Disp_Interval_m) == 0
        if ConsoleDisplay == 1; fprintf('%dx%d.||.m:%d/%d.\n', sz1, sz2, ms, finalmcs).
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