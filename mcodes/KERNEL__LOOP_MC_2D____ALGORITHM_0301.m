function KERNEL__LOOP_MC_2D____ALGORITHM_0301(initialmcs, finalmcs, consider_energy, E, delE, ham, SZS1P1, SZS1P2, SZS1P3, vf, skipmatrix, ConsoleDisplay)
%-------------------------------------------------------------
global MC_Param Lattice MC_Loop CMDL_display File_Fold_Operations
%-------------------------------------------------------------
sz1             = Lattice.size.sz1;
sz2             = Lattice.size.sz2;
s               = Lattice.orientations.s;
q               = Lattice.q;
ea              = Lattice.s__MATLAB_Indices__BounCond_Wrapped;
WM              = MC_Param.WeightMatrix;
Consider_Energy = MC_Param.Consider_Energy;
txtwriteint     = MC_Loop.DataOperation.txtwriteint;
nof             = File_Fold_Operations.writedlm.s.nof;
%-------------------------------------------------------------
start = initialmcs;

J_by_k_by_T = 0.0;

Transition_Probability = exp(-J_by_k_by_T);
%-------------------------------------------------------------
for ms = start:finalmcs
    NS_full = floor(1+q*rand(sz1,sz2));
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
%             energy1 = 8 - ((esm5==esm1) + (esm5==esm4) + (esm5==esm7) + (esm5==esm2) + (esm5==esm8) + (esm5==esm3) + (esm5==esm6) + (esm5==esm9));
%             energy1 = esm5==esm1 + esm5==esm4 + esm5==esm7 + esm5==esm2 + esm5==esm8 + esm5==esm3 + esm5==esm6 + esm5==esm9;
            NS = NS_full(pt);
                      
%             states = [esm1; esm2; esm3; esm4; esm6; esm7; esm8; esm9];
%             NS = states(floor(1+8*rand(1)));
            e2_minus_e1 = (((esm5==esm1) + (esm5==esm4) + (esm5==esm7) + (esm5==esm2) + (esm5==esm8) + (esm5==esm3) + (esm5==esm6) + (esm5==esm9)) -...
                          ((NS==esm1) + (NS==esm4) + (NS==esm7) + (NS==esm2) + (NS==esm8) + (NS==esm3) + (NS==esm6) + (NS==esm9)));
%             energy2 = 8 - ((NS==esm1) + (NS==esm4) + (NS==esm7) + (NS==esm2) + (NS==esm8) + (NS==esm3) + (NS==esm6) + (NS==esm9));

%             energy2 = NS==esm1 + NS==esm4 + NS==esm7 + NS==esm2 + NS==esm8 + NS==esm3 + NS==esm6 + NS==esm9;
            if e2_minus_e1<=0 || rand(1)<=Transition_Probability
                s(pt)   = NS;
%                 if Consider_Energy == 1
%                     energy1 = energy2;
%                 end
% %             elseif 
% %                 s(pt)   = NS;
% %                 if Consider_Energy == 1
% %                     energy1 = energy2;
% %                 end
            end
            
%             if Consider_Energy == 1
%                 E(pt) = energy1;
%             end
        end
    end
    
    if mod(ms, CMDL_display.MC_Kernel__Prog_Disp_Interval_m) == 0
        if ConsoleDisplay == 1
            fprintf('%dx%d.||.m:%d/%d.\n', sz1, sz2, ms, finalmcs)
        elseif ConsoleDisplay == 2
            if initialmcs == 1
                if Consider_Energy == 1
                    fprintf('%dx%d.||.q%d.||.m:%d/%d.||.%2.4f%%Comp.||.ham:%d.||.vf.slsp:%2.2f%%.||.vf.cnt:%2.2f%%.||.vf.slspc:%2.2f%%.||.vf.tot:%2.2f%%.||\n',...
                        sz1, sz2, q, ms, finalmcs,ms*100/finalmcs, sum(sum(E)), vf(1), vf(2), vf(3), vf(4))
                else
                    fprintf('%dx%d.||.q%d.||.m:%d/%d.||.%2.4f%%Comp.||.vf.slsp:%2.2f%%.||.vf.cnt:%2.2f%%.||.vf.slspc:%2.2f%%.||.vf.tot:%2.2f%%.||\n',...
                        sz1, sz2, q, ms, finalmcs,ms*100/finalmcs, vf(1), vf(2), vf(3), vf(4))
                end
            else
                if Consider_Energy == 1
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
        ham(ms) = sum(sum(E));
    end
    %<><><><><><><><><><><><><><><><><><>
    Lattice.orientations.s = s;
end