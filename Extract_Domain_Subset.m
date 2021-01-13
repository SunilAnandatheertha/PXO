function Extract_Domain_Subset(loc1, xleft_factor  ,...
                               loc2, xright_factor ,...
                               loc3, yleft_factor  ,...
                               loc4, yright_factor)

global Lattice Lattice_Subset

if Lattice.type.square == 1
    
    x     = Lattice.size.x;      y     = Lattice.size.y;
    xincr = Lattice.size.i_incr; yincr = Lattice.size.j_incr;
    xmin  = min(min(x));         xmax  = max(max(x));
    ymin  = min(min(y));         ymax  = max(max(y));

    x_subdomain_start = xmin + xleft_factor  * (xmax-xmin);
    x_subdomain_end   = xmin + xright_factor * (xmax-xmin);
    y_subdomain_start = ymin + yleft_factor  * (ymax-ymin);
    y_subdomain_end   = ymin + yright_factor * (ymax-ymin);
    
    if x_subdomain_end   < min(min(x))+xincr
        xright_factor = 0.5;
        disp('Entered x fomain factor return no subdomain. Taking it 50%')
        Extract_Domain_Subset(xleft_factor, xright_factor, yleft_factor, yright_factor)
    end
    if y_subdomain_end   < min(min(y))+yincr
        yright_factor = 0.5;
        disp('Entered y fomain factor return no subdomain. Taking it 50%')
        Extract_Domain_Subset(xleft_factor, xright_factor, yleft_factor, yright_factor)
    end
    if x_subdomain_end < min(min(x))+xincr && y_subdomain_end < min(min(y))+yincr
        xright_factor = 0.5;
        yright_factor = 0.5;
        disp('Entered x and y fomain factor return no subdomain. Taking them at 50%')
        Extract_Domain_Subset(xleft_factor, xright_factor, yleft_factor, yright_factor)
    end
    
    if x_subdomain_start < min(min(x)); x_subdomain_start = min(min(x)); end
    if x_subdomain_end   > max(max(x)); x_subdomain_end   = max(max(x)); end
    if y_subdomain_start < min(min(y)); y_subdomain_start = min(min(y)); end
    if y_subdomain_end   > max(max(y)); y_subdomain_end   = max(max(y)); end

    [~, loc_x] = ismember(round(x_subdomain_start:xincr:x_subdomain_end), x);
    [~, loc_y] = ismember(round(y_subdomain_start:yincr:y_subdomain_end), y);

    [~, col] = ind2sub(size(x), loc_x);
    [row, ~] = ind2sub(size(y), loc_y);

    Lattice_Subset.x              = x(row, col);
    Lattice_Subset.y              = y(row, col);
    Lattice_Subset.orientations.s = Lattice.orientations.s(row, col);
    
    Lattice.size.x = Lattice_Subset.x;
    Lattice.size.y = Lattice_Subset.y;
end