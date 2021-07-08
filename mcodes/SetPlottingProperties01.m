function SetPlottingProperties01(WHICH_CASE, AX_LIM, FONTSIZES, DATASET1)
% FONTSIZES  = [12 14 12]; % GCA font size, label font size, legend font size
switch WHICH_CASE
    case 'jsfhj547'
        xaxmin = AX_LIM(1); xaxmax = AX_LIM(2); 
        yaxmin = AX_LIM(3); yaxmax = AX_LIM(4);
        hxlab  = xlabel('MC sim. time');
        hylab  = ylabel('Peak position, unit^2');
        hleg   = legend('Peak position', 'location', 'southwest');
        set(gca, 'fontsize', FONTSIZES(1))
        set(hleg, 'box', 'off')
        set([hxlab hylab], 'fontsize', FONTSIZES(2))
        set(hleg, 'fontsize', FONTSIZES(3))
        axis([xaxmin xaxmax yaxmin yaxmax])
        grid on
        ax = gca;
        MCSlices = DATASET1;
        ax.XTick = 10.^[0:log10(MCSlices(end))];
        ax.YTick = linspace(yaxmin, yaxmax, 6);
        tiy = get(gca,'ytick')'; set(gca,'yticklabel',num2str(tiy,'%.1f'))
    case 'skhvbdjef683'
        xaxmin = AX_LIM(1); xaxmax = AX_LIM(2);
        yaxmin = AX_LIM(3); yaxmax = AX_LIM(4);
        hxlab  = xlabel('MC sim. time');
        hylab  = ylabel('Peak height, count');
        hleg   = legend('Peak height', 'location', 'northeast');
        set(gca, 'fontsize', FONTSIZES(1))
        set(hleg, 'box', 'off')
        set([hxlab hylab], 'fontsize', FONTSIZES(2))
        set(hleg, 'fontsize', FONTSIZES(3))
        axis([xaxmin xaxmax yaxmin yaxmax])
        grid on
        ax = gca;
        MCSlices = DATASET1;
        ax.XTick = 10.^[0:log10(MCSlices(end))];
        ax.YTick = linspace(yaxmin, yaxmax, 6);
        tiy = get(gca,'ytick')'; set(gca,'yticklabel',num2str(tiy,'%.1f'))        
    case 'fbkndlgf9846'
        xaxmin = AX_LIM(1);
        xaxmax = AX_LIM(2);
        yaxmin = AX_LIM(3);
        yaxmax = AX_LIM(4);
        hxlab  = xlabel('MC sim. time');
        hylab  = ylabel('Peak width, unit^2');
        hleg   = legend('Peak width', 'location', 'northeast');
        set(gca, 'fontsize', FONTSIZES(1))
        set(hleg, 'box', 'off')
        set([hxlab hylab], 'fontsize', FONTSIZES(2))
        set(hleg, 'fontsize', FONTSIZES(3))
        axis([xaxmin xaxmax yaxmin yaxmax])
        grid on
        ax = gca;
        MCSlices = DATASET1;
        ax.XTick = 10.^[0:log10(MCSlices(end))];
        ax.YTick = linspace(yaxmin, yaxmax, 6);
        tiy = get(gca, 'ytick')'; set(gca, 'yticklabel',num2str(tiy, '%.1f'))
    case 'GrainAreaDistribution_hist_plotMarkup_sjkhvbke78'
        xaxmin = AX_LIM(1);
        xaxmax = AX_LIM(2);
        yaxmin = AX_LIM(3);
        yaxmax = AX_LIM(4);
        hxlab  = xlabel('Grain area, unit^2');
        hylab  = ylabel('Count');
        set(gca, 'FontSize', FONTSIZES(1))
        set([hxlab hylab], 'FontSize', FONTSIZES(2))
        axis([xaxmin xaxmax yaxmin yaxmax])
    case 'numNeighDistribution_hist_plotMarkup_sjkhvbke78'
        xaxmin = AX_LIM(1);
        xaxmax = AX_LIM(2);
        yaxmin = AX_LIM(3);
        yaxmax = AX_LIM(4);
        hxlab  = xlabel('Number of neighbours');
        hylab  = ylabel('Count');
        set(gca, 'FontSize', FONTSIZES(1))
        set([hxlab hylab], 'FontSize', FONTSIZES(2))
        axis([xaxmin xaxmax yaxmin yaxmax])
    case 'GrainDiameterDistribution_hist_plotMarkup_sjkhvbke78'
        xaxmin = AX_LIM(1);
        xaxmax = AX_LIM(2);
        yaxmin = AX_LIM(3);
        yaxmax = AX_LIM(4);
        hxlab  = xlabel('Grain diameter, units');
        hylab  = ylabel('Count');
        set(gca, 'FontSize', FONTSIZES(1))
        set([hxlab hylab], 'FontSize', FONTSIZES(2))
        axis([xaxmin xaxmax yaxmin yaxmax])
    case 'ShapeFactor_hist_plotMarkup_sjkhvbke78'
        xaxmin = AX_LIM(1);
        xaxmax = AX_LIM(2);
        yaxmin = AX_LIM(3);
        yaxmax = AX_LIM(4);
        hxlab  = xlabel('Grain shape factor');
        hylab  = ylabel('Count');
        set(gca, 'FontSize', FONTSIZES(1))
        set([hxlab hylab], 'FontSize', FONTSIZES(2))
        axis([xaxmin xaxmax yaxmin yaxmax])        
    case 'AspectRatio_hist_plotMarkup_sjkhvbke78'
        xaxmin = AX_LIM(1);
        xaxmax = AX_LIM(2);
        yaxmin = AX_LIM(3);
        yaxmax = AX_LIM(4);
        hxlab  = xlabel('Grain aspect ratio');
        hylab  = ylabel('Count');
        set(gca, 'FontSize', FONTSIZES(1))
        set([hxlab hylab], 'FontSize', FONTSIZES(2))
        axis([xaxmin xaxmax yaxmin yaxmax])
    case 'souhkshbvj9684a6dv'
        hxlab  = xlabel('MC sim. time');
        hylab  = ylabel('Grain area, unit^2');
        set(gca, 'fontsize', FONTSIZES(1))
        set([hxlab hylab], 'fontsize', FONTSIZES(2))
        grid on
        ax = gca;
        ax.XTick = 10.^[log10(DATASET1{1}):log10(DATASET1{2})];
        ax.YTick = round(10.^[linspace(1, log10(DATASET1{4}), 10)]);
        tiy = get(gca, 'ytick')'; set(gca, 'yticklabel',num2str(tiy, '%.1f'))
        set(gca, 'XMinorTick','on', 'XMinorGrid','on')
        set(gca, 'YMinorTick','off', 'YMinorGrid','off')
end
end