function AGG_GRX_PlotGrapheneStack(xgstack, ygstack, zgstack, cgstack, vd1gstack, vd2gstack, GrapheneStackLayUp,...
                                   PlotAtoms,PlotCovEle,PlotVd1Ele,PlotVd2Ele,PlotDifferentViewsInSP,StoredGrapheneStackNumber)
% AGG -- Atomic Geometry Generator
% GRX -- Graphics
% This function plots the stack of graphene sheet


set(0,'DefaultFigureWindowStyle','docked')
close all

% FIGURE01_h = figure('renderer','opengl'); % DO NOT USE this.. It sucks !!
FIGURE01_h = figure;
hold on

%
NoOfStacks = size(GrapheneStackLayUp,1);
for ct1 = 1:NoOfStacks
    covalent = cgstack{1,ct1};
    %%%%%%%% PLOT ATOMS
    if PlotAtoms == 1
        plot3(xgstack{1,ct1}, ygstack{1,ct1}, zgstack{1,ct1}, 'bo', 'MarkerFaceColor', 'b', 'MarkerSize', 5)
    end
    %%%%%%%% PLOT COVALENT BOND FINITE ELEMENTS
    if PlotCovEle == 1
        for ct2 = 1:size(covalent,1)
            plot3([covalent(ct2,3) covalent(ct2,5)],...
                [covalent(ct2,4) covalent(ct2,6)],...
                [max(max(zgstack{1,ct1})) max(max(zgstack{1,ct1}))],...
                'k','LineWidth',1)
        end
    end
    %%%%%%%% PLOT VAN-DER WALLS 1 BOND FINITE ELEMENTS
    if PlotVd1Ele == 1
        vanderwall1 = vd1gstack{1,ct1};
        for ct2 = 1:size(vanderwall1,1)
            plot3([vanderwall1(ct2,3) vanderwall1(ct2,5)],...
                [vanderwall1(ct2,4) vanderwall1(ct2,6)],...
                [max(max(zgstack{1,ct1})) max(max(zgstack{1,ct1}))],...
                'k--','LineWidth',0.1)
        end
    end
    %%%%%%%% PLOT VAN-DER WALLS 2 BOND FINITE ELEMENTS
    if PlotVd2Ele == 1
        vanderwall2 = vd2gstack{1,ct1};
        for ct2 = 1:size(vanderwall2,1)
            plot3([vanderwall2(ct2,3) vanderwall2(ct2,5)],...
                [vanderwall2(ct2,4) vanderwall2(ct2,6)],...
                [max(max(zgstack{1,ct1})) max(max(zgstack{1,ct1}))],...
                'k:','LineWidth',0.1)
        end
    end
end
% axis equal
% axis tight
% box on
% xlabel('x-axis (WIDTH), nm')
% ylabel('y-axis (LENGTH), nm')
% zlabel('z-axis (THICKNESS), nm')
% title('Stacked Graphene Sheets')
% view(40,40)
% axesLabelsAlign3D
print('-depsc',strcat(pwd,'\results\plots\GrapheneSheet\','\Stack_View4040','.eps'))

if StoredGrapheneStackNumber == 1
    view(40,16)
    axesLabelsAlign3D
    print('-depsc',strcat(pwd,'\results\plots\GrapheneSheet\','\Stack_View4016','.eps'))
elseif StoredGrapheneStackNumber == 3
    view(35,50)
    axesLabelsAlign3D
    print('-depsc',strcat(pwd,'\results\plots\GrapheneSheet\','\Stack_View3550','.eps'))
end

%%
if PlotDifferentViewsInSP == 1
    FIGURE01_h_children   = get(FIGURE01_h,'children');
    FIGURE01_h_g_children = get(FIGURE01_h_children, 'children');
    
    FIGURE02_h            = figure('renderer','opengl');
    
    FIGURE02SP01_h        = subplot(2,2,1);
    copyobj(FIGURE01_h_g_children,FIGURE02SP01_h)
    SUMF('agg','s')
%     axis equal, axis tight, box on
%     xlabel('x-axis (WIDTH), nm')
%     ylabel('y-axis (LENGTH), nm')
%     zlabel('z-axis (THICKNESS), nm')
%     title('Stacked Graphene Sheets: [Left view]'), view(0,0)
    
    FIGURE02SP02_h        = subplot(2,2,2);
    copyobj(FIGURE01_h_g_children,FIGURE02SP02_h)
    axis equal, axis tight, box on
    xlabel('x-axis (WIDTH), nm')
    ylabel('y-axis (LENGTH), nm')
    zlabel('z-axis (THICKNESS), nm')
    title('Stacked Graphene Sheets: [Top view]'), view(90,90)
    
    FIGURE02SP03_h        = subplot(2,2,3);
    copyobj(FIGURE01_h_g_children,FIGURE02SP03_h)
    axis equal, axis tight, box on
    xlabel('x-axis (WIDTH), nm')
    ylabel('y-axis (LENGTH), nm')
    zlabel('z-axis (THICKNESS), nm')
    title('Stacked Graphene Sheets: [3D view (10,10)]'), view(10,10)
    
    FIGURE02SP04_h        = subplot(2,2,4);
    copyobj(FIGURE01_h_g_children,FIGURE02SP04_h)
    axis equal, axis tight, box on
    xlabel('x-axis (WIDTH), nm')
    ylabel('y-axis (LENGTH), nm')
    zlabel('z-axis (THICKNESS), nm')
    title('Stacked Graphene Sheets: [3D view (40,40)]'), view(40,40)
    
    figure(2)
    axis equal
    
    print('-depsc2',strcat(pwd,'\results\plots\GrapheneSheet\','\Stack_Projected_Views','.eps'))
    % FOR BETTER QUALITY (ONLY MARGINAL IMPROVEMENT)
    % print('-r200', '-loose', '-zbuffer', '-depsc2', strcat(pwd,'\results\plots\GrapheneSheet\','\Stack_Projected_Views','.eps') )  
end

end