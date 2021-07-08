function PLOT_HISTOGRAMS_GSANA_RESFRMMTEX_V1(WhichCase, DATA1, DATA2, DATA3, DATA4)

switch WhichCase
    case 'GrainAreaDistribution_hist_plotMarkup_sjkhvbke78'
        disp('-----------------------------------------')
        disp('Plotting grain area distr. for all time slices'); figure
        MCSlices               = DATA1;
        TOTAL_TRIALS           = DATA2;
        GrainSizes_mtex_TRIALS = DATA3;
        
        mcslice1 = MCSlices(1);   mcslice1count = find(MCSlices==mcslice1);
        mcslice2 = MCSlices(end); mcslice2count = find(MCSlices==mcslice2);
        XData1Max = zeros(1,TOTAL_TRIALS); XData2Max = zeros(1,TOTAL_TRIALS);
        YData1Max = zeros(1,TOTAL_TRIALS); YData2Max = zeros(1,TOTAL_TRIALS);
        for count_rset = 1:TOTAL_TRIALS
            %0000000000000000
            GSData1 = GrainSizes_mtex_TRIALS{1, count_rset}{mcslice1count, 1};
            GSData2 = GrainSizes_mtex_TRIALS{1, count_rset}{mcslice2count, 1};
            %0000000000000000
            h1 = histogram(GSData1, 10); if count_rset==1; hold on; end
            h2 = histogram(GSData2, 10);
            %0000000000000000
            XData1Max(count_rset) = max(GSData1); XData2Max(count_rset) = max(GSData2);
            YData1Max(count_rset) = max(h1.Values); YData2Max(count_rset) = max(h2.Values);
            %0000000000000000
            h1.DisplayStyle = 'stairs'; h1.LineWidth = 1; h1.EdgeColor = [0 0 0]; h1.LineStyle = '-';
            h2.DisplayStyle = 'stairs'; h2.LineWidth = 1; h2.EdgeColor = [1 0 0]; h2.LineStyle = '-.';
        end
        SetPlottingProperties01('GrainAreaDistribution_hist_plotMarkup_sjkhvbke78',...
                                 [0 max([XData1Max XData2Max]) 0 max([YData1Max YData2Max])],...
                                 [12 14],...
                                 [])
        disp('-----------------------------------------')
        %111111111111111111111111111111111111111111111111111111111111111111111111111111111111
        %111111111111111111111111111111111111111111111111111111111111111111111111111111111111
    case 'GrainDiameterDistribution_hist_plotMarkup_sjkhvbke78'
        disp('-----------------------------------------')
        disp('Plotting grain diameter distr. for all time slices'); figure
        MCSlices                = DATA1;
        TOTAL_TRIALS            = DATA2;
        GrainRadius_mtex_TRIALS = DATA3;
        
        mcslice1 = MCSlices(1);   mcslice1count = find(MCSlices==mcslice1);
        mcslice2 = MCSlices(end); mcslice2count = find(MCSlices==mcslice2);
        XData1Max = zeros(1,TOTAL_TRIALS); XData2Max = zeros(1,TOTAL_TRIALS);
        YData1Max = zeros(1,TOTAL_TRIALS); YData2Max = zeros(1,TOTAL_TRIALS);
        for count_rset = 1:TOTAL_TRIALS
            %0000000000000000
            GSData1 = 2*GrainRadius_mtex_TRIALS{1, count_rset}{mcslice1count, 1};
            GSData2 = 2*GrainRadius_mtex_TRIALS{1, count_rset}{mcslice2count, 1};
            %0000000000000000
            h1 = histogram(GSData1, 10); if count_rset==1; hold on; end
            h2 = histogram(GSData2, 10);
            %0000000000000000
            XData1Max(count_rset) = max(GSData1); XData2Max(count_rset) = max(GSData2);
            YData1Max(count_rset) = max(h1.Values); YData2Max(count_rset) = max(h2.Values);
            %0000000000000000
            h1.DisplayStyle = 'stairs'; h1.LineWidth = 1; h1.EdgeColor = [0 0 0]; h1.LineStyle = '-';
            h2.DisplayStyle = 'stairs'; h2.LineWidth = 1; h2.EdgeColor = [1 0 0]; h2.LineStyle = '-.';
        end
        SetPlottingProperties01('GrainDiameterDistribution_hist_plotMarkup_sjkhvbke78',...
                                 [0 max([XData1Max XData2Max]) 0 max([YData1Max YData2Max])],...
                                 [12 14],...
                                 [])
        disp('-----------------------------------------')
        %111111111111111111111111111111111111111111111111111111111111111111111111111111111111
        %111111111111111111111111111111111111111111111111111111111111111111111111111111111111        
    case 'numNeighDistribution_hist_plotMarkup_sjkhvbke78'
        disp('-----------------------------------------')
        disp('Plotting # Neigh_G distr. for all time slices'); figure
        
        MCSlices               = DATA1;
        TOTAL_TRIALS           = DATA2;
        numNeighbors_mtex_TRIALS = DATA3;
        
        mcslice1 = MCSlices(1);   mcslice1count = find(MCSlices==mcslice1);
        mcslice2 = MCSlices(end); mcslice2count = find(MCSlices==mcslice2);
        XData1Max = zeros(1,TOTAL_TRIALS); XData2Max = zeros(1,TOTAL_TRIALS);
        YData1Max = zeros(1,TOTAL_TRIALS); YData2Max = zeros(1,TOTAL_TRIALS);
        for count_rset = 1:TOTAL_TRIALS
            %0000000000000000
            GSData1 = numNeighbors_mtex_TRIALS{1, count_rset}{mcslice1count, 1};
            GSData2 = numNeighbors_mtex_TRIALS{1, count_rset}{mcslice2count, 1};
            %0000000000000000
            h1 = histogram(GSData1, 10); if count_rset==1; hold on; end
            h2 = histogram(GSData2, 10);
            %0000000000000000
            XData1Max(count_rset) = max(GSData1); XData2Max(count_rset) = max(GSData2);
            YData1Max(count_rset) = max(h1.Values); YData2Max(count_rset) = max(h2.Values);
            %0000000000000000
            h1.DisplayStyle = 'stairs'; h1.LineWidth = 1; h1.EdgeColor = [0 0 0]; h1.LineStyle = '-';
            h2.DisplayStyle = 'stairs'; h2.LineWidth = 1; h2.EdgeColor = [1 0 0]; h2.LineStyle = '-.';
        end
        SetPlottingProperties01('numNeighDistribution_hist_plotMarkup_sjkhvbke78',...
                                 [0 max([XData1Max XData2Max]) 0 max([YData1Max YData2Max])],...
                                 [12 14],...
                                 [])
    case 'ShapeFactor_hist_plotMarkup_sjkhvbke78'
        disp('-----------------------------------------')
        disp('Plotting Shape factor for all time slices'); figure
        
        MCSlices               = DATA1;
        TOTAL_TRIALS           = DATA2;
        ShapeFactor_mtex_TRIALS = DATA3;
        
        mcslice1 = MCSlices(1);   mcslice1count = find(MCSlices==mcslice1);
        mcslice2 = MCSlices(end); mcslice2count = find(MCSlices==mcslice2);
        XData1Max = zeros(1,TOTAL_TRIALS); XData2Max = zeros(1,TOTAL_TRIALS);
        YData1Max = zeros(1,TOTAL_TRIALS); YData2Max = zeros(1,TOTAL_TRIALS);
        for count_rset = 1:TOTAL_TRIALS
            %0000000000000000
            GSData1 = ShapeFactor_mtex_TRIALS{1, count_rset}{mcslice1count, 1};
            GSData2 = ShapeFactor_mtex_TRIALS{1, count_rset}{mcslice2count, 1};
            %0000000000000000
            h1 = histogram(GSData1, 10); if count_rset==1; hold on; end
            h2 = histogram(GSData2, 10);
            %0000000000000000
            XData1Max(count_rset) = max(GSData1); XData2Max(count_rset) = max(GSData2);
            YData1Max(count_rset) = max(h1.Values); YData2Max(count_rset) = max(h2.Values);
            %0000000000000000
            h1.DisplayStyle = 'stairs'; h1.LineWidth = 1; h1.EdgeColor = [0 0 0]; h1.LineStyle = '-';
            h2.DisplayStyle = 'stairs'; h2.LineWidth = 1; h2.EdgeColor = [1 0 0]; h2.LineStyle = '-.';
        end
        SetPlottingProperties01('ShapeFactor_hist_plotMarkup_sjkhvbke78',...
                                 [0 max([XData1Max XData2Max]) 0 max([YData1Max YData2Max])],...
                                 [12 14],...
                                 [])     
    case 'AspectRatio_hist_plotMarkup_sjkhvbke78'
        disp('-----------------------------------------')
        disp('Plotting Aspect ratio distr. for all time slices'); figure
        
        MCSlices               = DATA1;
        TOTAL_TRIALS           = DATA2;
        AspectRatio_mtex_TRIALS = DATA3;
        
        mcslice1 = MCSlices(1);   mcslice1count = find(MCSlices==mcslice1);
        mcslice2 = MCSlices(end); mcslice2count = find(MCSlices==mcslice2);
        XData1Max = zeros(1,TOTAL_TRIALS); XData2Max = zeros(1,TOTAL_TRIALS);
        YData1Max = zeros(1,TOTAL_TRIALS); YData2Max = zeros(1,TOTAL_TRIALS);
        for count_rset = 1:TOTAL_TRIALS
            %0000000000000000
            GSData1 = AspectRatio_mtex_TRIALS{1, count_rset}{mcslice1count, 1};
            GSData2 = AspectRatio_mtex_TRIALS{1, count_rset}{mcslice2count, 1};
            %0000000000000000
            h1 = histogram(GSData1, 10); if count_rset==1; hold on; end
            h2 = histogram(GSData2, 10);
            %0000000000000000
            XData1Max(count_rset) = max(GSData1); XData2Max(count_rset) = max(GSData2);
            YData1Max(count_rset) = max(h1.Values); YData2Max(count_rset) = max(h2.Values);
            %0000000000000000
            h1.DisplayStyle = 'stairs'; h1.LineWidth = 1; h1.EdgeColor = [0 0 0]; h1.LineStyle = '-';
            h2.DisplayStyle = 'stairs'; h2.LineWidth = 1; h2.EdgeColor = [1 0 0]; h2.LineStyle = '-.';
        end
        SetPlottingProperties01('AspectRatio_hist_plotMarkup_sjkhvbke78',...
                                 [0 max([XData1Max XData2Max]) 0 max([YData1Max YData2Max])],...
                                 [12 14],...
                                 [])     
end