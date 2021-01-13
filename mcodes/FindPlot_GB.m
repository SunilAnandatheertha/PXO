function [ind_temp, xcoord, ycoord, GrainBoundary_in_eq] = Find_GB(eq, grain, xq, yq, PlotGB, BoundaryShrinkFactor)

    [~, ind_temp] = intersect(eq, grain);    
    xcoord = xq(ind_temp);
    ycoord = yq(ind_temp);
    GrainBoundary_in_eq = boundary(xcoord, ycoord, BoundaryShrinkFactor);
    
    if PlotGB == 1
        plot(xcoord(GrainBoundary_in_eq), ycoord(GrainBoundary_in_eq), '-k', 'linewidth', 0.01)
    end
    
end