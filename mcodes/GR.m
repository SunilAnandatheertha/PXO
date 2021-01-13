function [GO]   = GR(TC, I, GC)
%% TC, I, GC: Type and controls, Inputs, Graphics controls
% {'GSC'}, {x, v, c_new}
% GS: Grain Structure; % GV: Grain Vertices; % GB: Grain boundary lines; 
% GS-A: GV = YES; GB = NO ; Fill = NO ;
% GS-B: GV = YES; GB = YES; Fill = NO ;
% GS-C: GV = YES; GB = YES; Fill = YES;
% GS-D: GV = NO ; GB = YES; Fill = YES;
% GS-E: GV = NO ; GB = NO ; Fill = YES;
% dock_docked or dock_normal
GO = 0;
switch TC{1}(1:2) % 1st and 2nd alphabets of the value in TC{1}
    case 'GS'
        x           = I{1};
        v           = I{2};
        c_new       = I{3};
        x_new       = I{4};
        ScaleFactor = str2double(GC{2}(16:end));
        set(0, 'DefaultFigureWindowStyle', GC{1}); hold on; %axis square
        axis([min(min(x(:,1))) max(max(x(:,1))) min(min(x(:,2))) max(max(x(:,2)))] + ScaleFactor*[-1 1 -1 1])
        GO = cell(3,1);
        switch TC{1}(3) % 3rd alphabets of the value in TC{1}
            case 'A' % GS-A: GV = YES; GB = NO ; Fill = NO ;
                for count = 1:numel(c_new);
                    GO{2}{count,1} = plot(v(c_new{count}, 1), v(c_new{count}, 2), 'kx'); %pause(0.0001);
                end
            case 'B' % GS-B: GV = YES; GB = YES; Fill = NO ;
                patchcolor = [71/255 185/255 255/255];
                for count = 1:numel(c_new);
                    GO{1} = patchcolor;
                    GO{2} = cell(numel(c_new), 1);
                    GO{3} = cell(numel(c_new), 1);
                    %GO{2}{count,1} = plot (v(c_new{count}, 1), v(c_new{count}, 2), 'ko', 'MarkerSize', 2, 'MarkerFaceColor', 'k'); %pause(0.0001);
                    GO{3}{count,1} = patch(v(c_new{count}, 1), v(c_new{count}, 2), patchcolor); %pause(0.000);
                end
            case 'C' % GS-C: GV = YES; GB = YES; Fill = YES;
                [patchcolor] = CalculateGrainColors(c_new);
                GO{1} = patchcolor;
                GO{2} = cell(numel(c_new), 1);
                GO{3} = cell(numel(c_new), 1);
                for count = 1:numel(c_new);
                    %GO{2}{count,1} = plot (v(c_new{count}, 1), v(c_new{count}, 2), 'ko', 'MarkerSize', 2, 'MarkerFaceColor', 'k'); %pause(0.0001);
                    GO{3}{count,1} = patch(v(c_new{count}, 1), v(c_new{count}, 2), patchcolor(count,:)); %pause(0.000);
                end
            case 'D'% GS-D: GV = NO ; GB = YES; Fill = YES;
                [patchcolor] = CalculateGrainColors(c_new);
                GO{1} = patchcolor;
                GO{2} = cell(numel(c_new), 1);
                for count = 1:numel(c_new)
                    GO{2}{count,1} = patch(v(c_new{count}, 1), v(c_new{count}, 2), patchcolor(count,:),...
                                           'LineWidth',1);
                    %pause(0.0001)
                end
            case 'E' % GS-E: GV = NO ; GB = NO ; Fill = YES;
                [patchcolor] = CalculateGrainColors(c_new);
                GO{1} = patchcolor; GO{2} = cell(numel(c_new), 1);
                for count = 1:numel(c_new);
                    GO{2}{count,1} = patch(v(c_new{count}, 1), v(c_new{count}, 2), patchcolor(count,:), 'LineStyle', 'none'); %pause(0.000);
                end
            case 'F' % GS-F: GSD + Old centroids + New centroids;
                GR({'GSD'}, {x, v, c_new, x_new}, {'docked', 'axisscalefactor0.00'});
                %plot(x(:,1)    , x(:,2)    , 'ko', 'MarkerFaceColor', 'c', 'MarkerSize', 6)
                %plot(x_new(:,1), x_new(:,2), 'ko', 'MarkerFaceColor', 'k', 'MarkerSize', 3)
        end
    case 'ST'
        switch TC{1}(3:end)
            case 'GSH'
                figure
                nbins      = GC{1};
                GrainSize  = I{1};
                bincentres = linspace(min(GrainSize), max(GrainSize), nbins);
                
                %hist(GrainSize, nbins)
                hist(GrainSize, bincentres); hold on
                %plot(bincentres, zeros(size(bincentres)), 'ks', 'MarkerFaceColor', [0 0 0], 'MarkerSize', 2)
                axis square; axis tight
                hxl = xlabel('Grain size');
                hyl = ylabel('Frequency');
                ht  = title('Grain size distribution');
                set(hxl, 'FontSize', 14)
                set(hyl, 'FontSize', 14)
                set(ht,  'FontSize', 14)
                
                h = findobj(gca,'Type','patch');
                set(h, 'FaceColor', GC{2}(1:3), 'EdgeColor', GC{2}(4:6))
                set(gca,'XMinorTick','on','YMinorTick','on')
                
                xid = linspace(min(GrainSize), max(GrainSize), 8);
                set(gca, 'XTick', xid)
                
                if strcmp(GC{4}, 'printjpeg_yes')==1
                    print('-djpeg100', strcat(pwd, '\GShistogram.jpeg'))
                end
                %if strcmp(GC{5}, 'printeps_yes')==1
                %    print('-depsc', strcat(pwd, '\GShistogram.eps'))
                %end
                GO = 0; % A dummy output
        end
end
end


%------------------------------------
% RESULTS: graphics. SEE END FOR DESCRIPTIONS
    % values for "T"
        % patchedGS: Plot patched grain structure
    % values for "I"
    % values for "C"
        % pop: plot original points. Opposite: dn_pop (do not pop)