function plot__grain_area___grain_length(dimensionality, All_GrainAreas_time, GBL_time)

global Lattice
cm  = Lattice.ColourMatrix_RGB_UnitNorm;

switch lower(dimensionality)
    case {'2d', 'thinfilm'}
        start_fig_num = 900;
        for rset = 1:numel(GBL_time)
            if rset == 1
                figurenum = start_fig_num+rset;
            else
                figurenum = figurenum + 1;
            end
            figure(figurenum), hold on
            GrainAreas_Collected       = [];
            GrainBoundLength_Collected = [];
            grainnumber_rset = 0;
            box on
            set(gca, 'linewidth', 2)
            for countq = 1:numel(GBL_time{rset})
                if ~isempty(GBL_time{rset}{countq})
                    thisq_grainareas = zeros(numel(All_GrainAreas_time{rset}{countq}), 1);
                    for countng = 1:numel(GBL_time{rset}{countq})
                        thisq_grainareas(countng) = All_GrainAreas_time{rset}{countq}{countng};
                    end
                    grainnumber_rset = grainnumber_rset + 1;
                    thisq_gbl        = GBL_time{rset}{countq};
                    plot(thisq_grainareas, thisq_gbl,...
                        '.',...
                        'markersize', 20,...
                        'markerfacecolor', cm(countq,:));
                    GrainAreas_Collected       = [GrainAreas_Collected;       thisq_grainareas];
                    GrainBoundLength_Collected = [GrainBoundLength_Collected; thisq_gbl];                    
                end
            end
            xlabel('Grain pixel area')
            ylabel({'Pixelated grain boundary', 'length, units', 'Calculation: straight+diag'})            
            title(['time slice # = ' num2str(rset)])
            
            figurenum = figurenum + 1;
            figure(figurenum), hold on, box on
            set(gca, 'linewidth', 2)
            plot(GrainAreas_Collected, GrainBoundLength_Collected,...
                'x',...
                'markersize', 6,...
                'markerfacecolor', [0.5 0.5 0.5]);
            p1 = polyfit(GrainAreas_Collected, GrainBoundLength_Collected, 1);
            p1(2) = 0; % This is enforced here bcz, Grain boundary length = 0 @ grain area = 0;
            xaxismin   = min(GrainAreas_Collected);
            xaxismax   = max(GrainAreas_Collected);
            yaxisstart = p1(1)*xaxismin + p1(2);
            yaxisend   = p1(1)*xaxismax + p1(2);
            plot([xaxismin xaxismax], [yaxisstart yaxisend],...
                 'k:',...
                 'linewidth', 2)
            
            p2 = polyfit(GrainAreas_Collected, GrainBoundLength_Collected, 2);
            p2(3) = 0; % This is enforced here bcz, Grain boundary length = 0 @ grain area = 0;
            xaxismin   = min(GrainAreas_Collected);
            xaxismax   = max(GrainAreas_Collected);
            yaxisstart = p2(1)*xaxismin^2 + p2(2)*xaxismin + p2(3);
            yaxisend   = p2(1)*xaxismax^2 + p2(2)*xaxismax + p2(3);
            plot([xaxismin xaxismax], [yaxisstart yaxisend],...
                 'r-',...
                 'linewidth', 1)
            hleg = legend('Actual data',...
                          ['1^{st} order fit. y=' num2str(p1(1)) 'x'],...
                          ['2^{nd} order fit. y=' num2str(p2(1)) 'x^2+' num2str(p2(2)) 'x']);
            set(hleg, 'box', 'on')
            set(hleg, 'color', 'none')
            set(hleg, 'linewidth', 1)
            set(hleg, 'location', 'northwest')
            xlabel('Grain pixel area')
            ylabel({'Pixelated grain boundary', 'length, units', 'Calculation: straight+diag'})
            title(['time slice # = ' num2str(rset)])
        end
    case {'3d'}
        % Code here
    otherwise
        disp('invalid input')
end
end