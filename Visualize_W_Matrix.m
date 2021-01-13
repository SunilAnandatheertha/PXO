function Visualize_W_Matrix(WM)

    [x, y] = meshgrid(0:2, 0:2);
    figure
    contourf(x, y, WM, 2, 'linewidth', 1, 'Showtext', 'on');
    for count = 1:numel(x)
        text(x(count), y(count), num2str(WM(count)), 'BackgroundColor', 'w', 'FontWeight', 'bold', 'fontsize', 12)
    end
    TICKVALUES = [0 0.50 1.0 1.50 2.0];
    cbh                = colorbar('westoutside', 'axislocation', 'out', 'ticks', TICKVALUES, 'TickLabels', {num2str(TICKVALUES')}, 'FontSize', 12); 
    cbh.Label.String   = 'Neighbour weights';
    cbh.Label.FontSize = 12;
    pause(0.2)
    print('-djpeg100', [pwd '\results\' 'WM_Visualization.jpeg'])
    pause(0.2)
    close
end