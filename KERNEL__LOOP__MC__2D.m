function KERNEL__LOOP__MC__2D_ALG_01()

global MC_Param

WM   = MC_Param.WeightMatrix;
WM51 = WM(1,1); WM54 = WM(2,1); WM57 = WM(3,1);
WM52 = WM(1,2); WM58 = WM(3,2);
WM53 = WM(1,3); WM56 = WM(2,3); WM59 = WM(3,3);



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