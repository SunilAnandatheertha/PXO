function KERNEL__LOOP_MC_2D____ALGORITHM_20(initialmcs, finalmcs, consider_energy, E, delE, ham, SZS1P1, SZS1P2, SZS1P3, vf, skipmatrix, ConsoleDisplay)
%-------------------------------------------------------------
% WM is randomized for every lattice site
%-------------------------------------------------------------
global MC_Param Lattice MC_Loop CMDL_display File_Fold_Operations
%-------------------------------------------------------------
sz1             = Lattice.size.sz1;
sz2             = Lattice.size.sz2;
x               = Lattice.size.x;
y               = Lattice.size.y;
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
sign   = [+1 +1 +1;
          +1 +1 +1;
          +1 +1 +1];

xconst =  [+1 +1 +1;
           +1 +1 +1;
           +1 +1 +1];
% xconst = rand(3,3);
yconst =  [+1 +1 +1;
           +1 +1 +1;
           +1 +1 +1];
% yxonst = rand(3,3);
xpower = [1 1 1;
          1 1 1;
          1 1 1];
      
ypower = [1 1 1;
          1 1 1;
          1 1 1];

power  = [-1 -1 -1;
          -1 -1 -1;
          -1 -1 -1];
% power = -rand(3,3);
MultipleOfNorm = [+1 +1 +1;
                  +1 +1 +1;
                  +1 +1 +1] + 0.0*rand(3,3) -0.0 + 0.0*randi(2,3);

figure
tempx = 1:3; tempy = 1:3; [tempx, tempy] = meshgrid(tempx, tempy); textheight = [5 5 5; 5 5 5; 5 5 5];
subplot(3,3,1); surf(tempx, tempy, sign, 'facealpha', 1.0, 'linewidth', 1); c = colorbar; view(0, 90); hold on; colormap jet; c.Label.String = 'Kenel. S';
for count = 1:9; text(tempx(count), tempy(count), textheight(count), num2str(sign(count)), 'color', 'r', 'background', 'w'); end; axis off; axis square;

subplot(3,3,2); surf(tempx, tempy, xconst, 'facealpha', 1.0, 'linewidth', 1); c = colorbar; view(0, 90); hold on; colormap jet; c.Label.String = 'Kenel. K_x';
for count = 1:9; text(tempx(count), tempy(count), textheight(count), num2str(xconst(count)), 'color', 'r', 'background', 'w'); end; axis off; axis square

subplot(3,3,3); surf(tempx, tempy, yconst, 'facealpha', 1.0, 'linewidth', 1); c = colorbar; view(0, 90); hold on; colormap jet; c.Label.String = 'Kenel. K_y';
for count = 1:9; text(tempx(count), tempy(count), textheight(count), num2str(yconst(count)), 'color', 'r', 'background', 'w'); end; axis off; axis square

subplot(3,3,4); surf(tempx, tempy, power, 'facealpha', 1.0, 'linewidth', 1); c = colorbar; view(0, 90); hold on; colormap jet; c.Label.String = 'Kenel. Q';
for count = 1:9; text(tempx(count), tempy(count), textheight(count), num2str(power(count)), 'color', 'r', 'background', 'w'); end; axis off; axis square

subplot(3,3,5); surf(tempx, tempy, xpower, 'facealpha', 1.0, 'linewidth', 1); c = colorbar; view(0, 90); hold on; colormap jet; c.Label.String = 'Kenel. m';
for count = 1:9; text(tempx(count), tempy(count), textheight(count), num2str(xpower(count)), 'color', 'r', 'background', 'w'); end; axis off; axis square

subplot(3,3,6); surf(tempx, tempy, ypower, 'facealpha', 1.0, 'linewidth', 1); c = colorbar; view(0, 90); hold on; colormap jet; c.Label.String = 'Kenel. n';
for count = 1:9; text(tempx(count), tempy(count), textheight(count), num2str(ypower(count)), 'color', 'r', 'background', 'w'); end; axis off; axis square

subplot(3,3,7); surf(tempx, tempy, MultipleOfNorm, 'facealpha', 1.0, 'linewidth', 1); c = colorbar; view(0, 90); hold on; colormap jet; c.Label.String = 'Kenel. R';
for count = 1:9; text(tempx(count), tempy(count), textheight(count), num2str(MultipleOfNorm(count)), 'color', 'r', 'background', 'w'); end; axis off; axis square

subplot(3,3,8); ht1 = text(-3, 2, 0, '$W_{ij}=S\left[\frac{K_x}{x^m}+\frac{K_y}{y^n}\right]^Q$', 'interpreter', 'latex'); hold on; ht2 = text(-3, -2, 0, '$\overline{W}_{ij}=\frac{W_{ij}}{max(W_{ij})}*R$', 'interpreter', 'latex'); xlim([-5 5]); ylim([-5 5])
set([ht1 ht2], 'fontsize', 14); axis off;

[WM51_dist, WM52_dist, WM53_dist, WM54_dist, WM56_dist, WM57_dist, WM58_dist, WM59_dist, Wsum] = CalcPlotWeights_V_1(x, y, sign, xconst, yconst, xpower, ypower, power, MultipleOfNorm);

%-------------------------------------------------------------
for ms = start:finalmcs
    ns = floor(1+q*rand(nums,1));
%     constant_centre = MC_Param.constant_centre + 0*rand;
    for pt = 1:nums
%         if skipmatrix(pt) == 0
            
%             WM51 = 1.0*constant_centre + 2.0*randn; WM54 = 2.0*constant_centre + 1.0*randn; WM57 = 1.0*constant_centre + 2.0*randn;
%             WM52 = 2.0*constant_centre + 1.0*randn;                                         WM58 = 2.0*constant_centre + 1.0*randn;
%             WM53 = 1.0*constant_centre + 2.0*randn; WM56 = 2.0*constant_centre + 1.0*randn; WM59 = 1.0*constant_centre + 2.0*randn;
            
            pta  = PTA(pt);
            %-------------------------------------------------------------
            ind11 = ea(pta-SZS1P3);   ind12 = ea(pta-SZS1P2);   ind13 = ea(pta-SZS1P1);
            ind21 = ea(pta-1);        ind22 = ea(pta);          ind23 = ea(pta+1);
            ind31 = ea(pta+SZS1P1);   ind32 = ea(pta+SZS1P2);   ind33 = ea(pta+SZS1P3);
            %-------------------------------------------------------------
            WM51  = WM51_dist(ind11); WM54  = WM54_dist(ind12); WM57  = WM57_dist(ind13);
            WM52  = WM52_dist(ind21);                           WM58  = WM58_dist(ind23);
            WM53  = WM53_dist(ind31); WM56  = WM56_dist(ind32); WM59  = WM59_dist(ind33);
            %-------------------------------------------------------------
            esm1 = s(ind11);          esm2 = s(ind12);          esm3 = s(ind13);
            esm4 = s(ind21);          esm5 = s(ind22);          esm6 = s(ind23);
            esm7 = s(ind31);          esm8 = s(ind32);          esm9 = s(ind33);
            %-------------------------------------------------------------
            delenergy1 = WM51*(esm5==esm1) + WM54*(esm5==esm4) + WM57*(esm5==esm7) +...
                         WM52*(esm5==esm2) + WM58*(esm5==esm8) + WM53*(esm5==esm3) +...
                         WM56*(esm5==esm6) + WM59*(esm5==esm9);
%             delenergy1 = rand*WM51*(esm5==esm1) + rand*WM54*(esm5==esm4) + rand*WM57*(esm5==esm7) +...
%                          rand*WM52*(esm5==esm2) + rand*WM58*(esm5==esm8) + rand*WM53*(esm5==esm3) +...
%                          rand*WM56*(esm5==esm6) + rand*WM59*(esm5==esm9);
            %-------------------------------------------------------------
            NS = ns(pt);
            %-------------------------------------------------------------
            delenergy2 = WM51*(NS==esm1)   + WM54*(NS==esm4)   + WM57*(NS==esm7) +...
                         WM52*(NS==esm2)   + WM58*(NS==esm8)   + WM53*(NS==esm3) +...
                         WM56*(NS==esm6)   + WM59*(NS==esm9);
%             delenergy2 = rand*WM51*(NS==esm1)   + rand*WM54*(NS==esm4)   + rand*WM57*(NS==esm7) +...
%                          rand*WM52*(NS==esm2)   + rand*WM58*(NS==esm8)   + rand*WM53*(NS==esm3) +...
%                          rand*WM56*(NS==esm6)   + rand*WM59*(NS==esm9);
            %-------------------------------------------------------------
            if delenergy2 >= delenergy1
                s(pt) = NS;
                if consider_energy == 1; delenergy1 = delenergy2; end
            end
            if consider_energy == 1; delE(pt) = delenergy1; end
%         end
    end
    if mod(ms, CMDL_display.MC_Kernel__Prog_Disp_Interval_m) == 0
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