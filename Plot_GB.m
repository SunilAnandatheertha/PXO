function Plot_GB(PlotGB_OR_NOT, q, xcoord, ycoord, GrainBoundary_in_eq, cm, DynPlot)

if PlotGB_OR_NOT == 1
    switch DynPlot{4}
        case 'plot_grainboundaries_dynamically'
            %plot(xcoord(GrainBoundary_in_eq), ycoord(GrainBoundary_in_eq), '-', 'color', cm(q,:), 'linewidth', 1)
            plot(xcoord(GrainBoundary_in_eq), ycoord(GrainBoundary_in_eq), '-', 'color', 'k', 'linewidth', 0.1)
        otherwise
    end
end

end