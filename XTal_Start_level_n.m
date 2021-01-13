function XTal_Start_level_n()

    global CFN
    % Get the current figure number in CFN
    close all;
    set(0,'DefaultFigureWindowStyle','docked')
    CFN = length(findobj('type','figure'));
    %-----------------------------------------
    disp('Creating new directory to store XTal visualization__V.2.0')
    try
        rmdir('results\plots\XTal_2D_Visualizaiton__V2_0','s')
    catch
        % Do nothing as of now.
    end
    mkdir('results\plots\XTal_2D_Visualizaiton__V2_0')
    %-----------------------------------------
end