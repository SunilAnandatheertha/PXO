function grainsize_interceptmethod2d()

PLOTOVERLAYPLOT = 0;
%% ASSIGN VARIABLE VALUES
latpar1       = dlmread(strcat(pwd,'\simparameters','\latpar.txt'));
xmin          = latpar1(1);
xmax          = latpar1(2);
ymin          = latpar1(3);
ymax          = latpar1(4);
xincr         = latpar1(5);
yincr         = latpar1(6);
xlength       = abs(xmin)+abs(xmax);
ylength       = abs(ymin)+abs(ymax);

simpar1 = dlmread(strcat(pwd,'\simparameters','\simpar.txt'));
mcsmax      = simpar1(2);
ffo1    = dlmread(strcat(pwd,'\simparameters','\ffo.txt'));
mcsinterval = ffo1(1);
mcs1        = mcsinterval;

[x, y]         = meshgrid(xmin:xincr:xmax,ymin:yincr:ymax);
clearvariableswhileworking = 1;
%% Grain charecterization phase: 05 a -- Vertical Intercept method
display('<><><><><><><><><><><><><><><><><><>'), display('<><><><><><><><><><><><><><><><><><>')
display('Initiating Grain Charecterization Phase 05a::--AGS calc: Vertical intercept metho')
max_interceptincrements = 5;
agsVSintrcptincrPLOTdata = [];

for count = 1:max_interceptincrements
    [AGSvsMCS_cell] = latticeline2d_specialized('V',count,00);
    AGSvsMCS = AGSvsMCS_cell{1,1};
    agstemp = AGSvsMCS;
    numberofvertintercepts = numel(count:count:size(x,1)-count);
    dlmwrite(strcat(pwd,'\results','\datafiles', '\graindata','\grainsizes', '\averagegrainsize_using',...
        num2str(numberofvertintercepts), '_VERTICAL_intercepts.txt'), [[mcs1:mcsinterval:mcsmax]' AGSvsMCS'],'delimiter','\t')
    agsVSintrcptincrPLOTdata = [agsVSintrcptincrPLOTdata;numberofvertintercepts max(agstemp)];
%     close % above line creates a plot and prints it (notice the function latticeline2d(count)), which needs to be closed
    if count == 1
        AGSvsMCS_M_vintincr1 = max(max(AGSvsMCS));
    elseif count == 2
        AGSvsMCS_M_vintincr2 = max(max(AGSvsMCS));
    elseif count == 3
        AGSvsMCS_M_vintincr3 = max(max(AGSvsMCS));
    elseif count == 4
        AGSvsMCS_M_vintincr4 = max(max(AGSvsMCS));
    elseif count == 5
        AGSvsMCS_M_vintincr5 = max(max(AGSvsMCS));
    elseif count == 6
        AGSvsMCS_M_vintincr6 = max(max(AGSvsMCS));
    end    
    % ############################################
%     PLOTCOMPILED = 0; % <<---------------------<<<<<<<<
    % ############################################
%     if count == 1
%         mcscount = 0;
%         for mcsnumber = mcs1:mcsinterval:mcsmax
%             mcscount = mcscount + 1;
%             fh1 = plot(x(1,2:size(y,2)), AGSvsMCS_cell{2,1}{mcscount, 1}(2:numel(AGSvsMCS_cell{2,1}{mcscount, 1})),'ok-','MarkerSize',3);
%             hold on
%             fh2 = plot([min(x(1,2:size(y,2))) max(x(1,2:size(y,2)))],...
%                 [sum(AGSvsMCS_cell{2,1}{mcscount, 1}(2:numel(AGSvsMCS_cell{2,1}{mcscount, 1})))/numel(AGSvsMCS_cell{2,1}{mcscount, 1}(2:numel(AGSvsMCS_cell{2,1}{mcscount, 1})))...
%                 sum(AGSvsMCS_cell{2,1}{mcscount, 1}(2:numel(AGSvsMCS_cell{2,1}{mcscount, 1})))/numel(AGSvsMCS_cell{2,1}{mcscount, 1}(2:numel(AGSvsMCS_cell{2,1}{mcscount, 1})))],...
%                 'k--','LineWidth',1);
%             print('-djpeg100', strcat(pwd, '\results\plots','\vertical_intercepts', num2str(mcsnumber),'.jpeg'))
%             pause(0.001)
%             fh = [fh1, fh2];
%             disp('############################################')
%             disp('############################################')
%             delete(fh)
%         end
%         mcscount = 0;
%         if PLOTCOMPILED == 1
%             xxxx = [];
%             yyyy = [];
%             zzzz = [];
%             if numel(mcs1:mcsinterval:mcsmax) > 5 && numel(mcs1:mcsinterval:mcsmax) < 10
%                 mcsfactor = 5;
%             elseif numel(mcs1:mcsinterval:mcsmax) > 10
%                 mcsfactor = 10;
%             else
%                 mcsfactor = 2;
%             end
%             for mcsnumber = mcs1:mcsfactor*mcsinterval:mcsmax
%                 mcscount = mcscount + 1;
%                 xxx  = mcsnumber*ones(numel(x(1,2:size(y,2))));
%                 yyy  = x(1,2:size(y,2));
%                 zzz  = AGSvsMCS_cell{2,1}{mcscount, 1}(2:numel(AGSvsMCS_cell{2,1}{mcscount, 1}));
%                 xxxx = [xxxx; xxx'];
%                 yyyy = [yyyy; yyy'];
%                 zzzz = [zzzz; zzz'];
%             end
%             plot3(xxxx, yyyy, zzzz,'k.'); view(30,30)
%             xlabel('Simulated Annealing Step')
%             ylabel('Microstructure length')
%             zlabel('Average Grain Size')
%             pause(0.001)
%             print('-djpeg100', strcat(pwd, '\results\plots','\vertical_intercepts_compiled.jpeg'))
%             close
%         end
%     end
end

phase05ab1_data_05a = agsVSintrcptincrPLOTdata;

% h1phase05a = plot(agsVSintrcptincrPLOTdata(:,1), agsVSintrcptincrPLOTdata(:,2), '-k.','MarkerSize',16);
% text(0.60*max(agsVSintrcptincrPLOTdata(:,1)), 0.97*min(agsVSintrcptincrPLOTdata(:,2)),...
%     strcat(num2str(xlength), 'x',num2str(ylength), '--','HOR','intercepts'),...
%     'HorizontalAlignment','center','BackgroundColor',[.7 .9 .7],'Margin',7.5,'EdgeColor','black','LineWidth',2);
% hold on, grid on, axis square
% title('max.ags vs no. of. vertical intercepts')
% xlabel('No. of vertical intercepts')
% ylabel('<GS>_{max}')
% print('-djpeg100',strcat(pwd, '\results\plots\grainsize\', 'AGS_vs_verticalinterceptlineincrements.jpeg'))
% close
%<><><><><><><><><><><><><><><><><><>
%<><><><><><><><><><><><><><><><><><>
%% Grain charecterization phase: 05 b -- Horizontal Intercept method
%  most coding gor this phase (phase 05b) is the same as that for phase 05a
% only major difference is the way the lattice is considered
% taking the horizontal intercepts for an existing lattice would require
% major recoding. But, taking horizontal intercepts of existing lattice is
% the same as taking the vertical intercepts of the same lattice having a
% 90 degree rotation cw or acc. this would require me to only rotate the
% existing lattice as [x_gbele_rotated,y_gbele_rotated] = rotate90(x_gbele_oringinal,y_gbele_oringinal).
% Then [x_gbele_rotated,y_gbele_rotated] data can essentially be passed on into x and y 
% of the vertical intercept coding without any changes being brought about 
% to the coding of the intercept part. This saves huge coding time. More
% time is saved here by also realizing the fact that all this can be
% achieved more easily by just considering the transposed matrices --
% qstates, x and y inside [AGSvsMCS] = latticeline2d(typeofintercept,attri1,attri2), a function called during this
% phase 05b
display('<><><><><><><><><><><><><><><><><><>'), display('<><><><><><><><><><><><><><><><><><>')
display('Initiating Grain Charecterization Phase 05b::--AGS calc: Horizontal intercept metho')
max_interceptincrements = 5;
agsVSintrcptincrPLOTdata = [];
for count = 1:max_interceptincrements
    
    [AGSvsMCS_cell] = latticeline2d_specialized('H',count,00);
    AGSvsMCS = AGSvsMCS_cell{1,1};
    agstemp = AGSvsMCS;
    
    numberofhorzintercepts = numel(count:count:size(x,1)-count);
    dlmwrite(strcat(pwd,'\results','\datafiles', '\graindata','\grainsizes', '\averagegrainsize_using',...
        num2str(numberofhorzintercepts), '_HORIZONTAL_intercepts.txt'), [[mcs1:mcsinterval:mcsmax]' AGSvsMCS'],'delimiter','\t')
    agsVSintrcptincrPLOTdata = [agsVSintrcptincrPLOTdata;numberofhorzintercepts max(agstemp)];
%     close % above line creates a plot and prints it (notice the function latticeline2d(count)), which needs to be closed
    if count == 1
        AGSvsMCS_M_hintincr1 = max(max(AGSvsMCS));
    elseif count == 2
        AGSvsMCS_M_hintincr2 = max(max(AGSvsMCS));
    elseif count == 3
        AGSvsMCS_M_hintincr3 = max(max(AGSvsMCS));
    elseif count == 4
        AGSvsMCS_M_hintincr4 = max(max(AGSvsMCS));
    elseif count == 5
        AGSvsMCS_M_hintincr5 = max(max(AGSvsMCS));
    elseif count == 6
        AGSvsMCS_M_hintincr6 = max(max(AGSvsMCS));
    end
    if count == 1
%         mcscount = 0;
%         for mcsnumber = mcs1:mcsinterval:mcsmax
%             mcscount = mcscount + 1;
%             fh1 = plot(y(2:size(y,1),1), AGSvsMCS_cell{2,1}{mcscount, 1}(2:numel(AGSvsMCS_cell{2,1}{mcscount, 1})),'ok-','MarkerSize',3);
%             hold on
%             fh2 = plot([min(x(1,2:size(y,2))) max(x(1,2:size(y,2)))],...
%                 [sum(AGSvsMCS_cell{2,1}{mcscount, 1}(2:numel(AGSvsMCS_cell{2,1}{mcscount, 1})))/numel(AGSvsMCS_cell{2,1}{mcscount, 1}(2:numel(AGSvsMCS_cell{2,1}{mcscount, 1}))) sum(AGSvsMCS_cell{2,1}{mcscount, 1}(2:numel(AGSvsMCS_cell{2,1}{mcscount, 1})))/numel(AGSvsMCS_cell{2,1}{mcscount, 1}(2:numel(AGSvsMCS_cell{2,1}{mcscount, 1})))],...
%                 'k--','LineWidth',1);
%             print('-djpeg100', strcat(pwd, '\results\plots','\horizontal_intercepts', num2str(mcsnumber),'.jpeg'))
%             pause(0.001)
% %             delete(fh1, fh2)
%         end
%         mcscount = 0;
%         if PLOTCOMPILED == 1
%             xxxx = [];
%             yyyy = [];
%             zzzz = [];
%             if numel(mcs1:mcsinterval:mcsmax) > 5 && numel(mcs1:mcsinterval:mcsmax) < 10
%                 mcsfactor = 5;
%             elseif numel(mcs1:mcsinterval:mcsmax) > 10
%                 mcsfactor = 10;
%             end
%             for mcsnumber = mcs1:mcsfactor*mcsinterval:mcsmax
%                 mcscount = mcscount + 1;
%                 xxx  = mcsnumber*ones(numel(x(1,2:size(y,2))));
%                 yyy  = x(1,2:size(y,2));
%                 zzz  = AGSvsMCS_cell{2,1}{mcscount, 1}(2:numel(AGSvsMCS_cell{2,1}{mcscount, 1}));
%                 xxxx = [xxxx; xxx'];
%                 yyyy = [yyyy; yyy'];
%                 zzzz = [zzzz; zzz'];
%             end
%             plot3(xxxx, yyyy, zzzz,'k.'); view(30,30)
%             xlabel('Simulated Annealing Step')
%             ylabel('Microstructure length')
%             zlabel('Average Grain Size')
%             pause(0.001)
%             print('-djpeg100', strcat(pwd, '\results\plots','\horizontal_intercepts_compiled.jpeg'))
%             close
%         end
    end
end
phase05ab1_data_05b = agsVSintrcptincrPLOTdata;
% h1phase05b = plot(agsVSintrcptincrPLOTdata(:,1),agsVSintrcptincrPLOTdata(:,2),'-k.','MarkerSize',16);
% text(0.60*max(agsVSintrcptincrPLOTdata(:,1)), 0.97*min(agsVSintrcptincrPLOTdata(:,2)),...
%     strcat(num2str(xlength), 'x', num2str(ylength),'--','HOR','intercepts'),...
%     'HorizontalAlignment','center','BackgroundColor',[.7 .9 .7],'Margin',7.5,'EdgeColor','black','LineWidth',2);
% hold on, grid on, axis square
% title('max.ags vs no. of. horizontal intercepts')
% xlabel('No. of horizontal intercepts')
% ylabel('<GS>_{max}')
% print('-djpeg100', strcat(pwd, '\results\plots\grainsize\', 'AGS_vs_horizontalinterceptlineincrements.jpeg'))
% close
%<><><><><><><><><><><><><><><><><><>
%<><><><><><><><><><><><><><><><><><>
%% Grain charecterization phase: 05 ab1 -- Overlay plot
display('<><><><><><><><><><><><><><><><><><>'), display('<><><><><><><><><><><><><><><><><><>')
if PLOTOVERLAYPLOT == 1
    display('Initiating Grain Charecterization Phase 05ab1::--overlay plot')
    figure
    plot(phase05ab1_data_05a(:,1),phase05ab1_data_05a(:,2), '-ko','MarkerSize',8, 'LineWidth',1); hold on
    plot(phase05ab1_data_05b(:,1),phase05ab1_data_05b(:,2), '-kh','MarkerSize',8, 'LineWidth',1);
    plot((phase05ab1_data_05a(:,1)+phase05ab1_data_05b(:,1))/2,...
        (phase05ab1_data_05a(:,2)+phase05ab1_data_05b(:,2))/2, '-ks', 'MarkerSize', 10, 'LineWidth',1, 'markerfacecolor', 'r');
    grid off
    hlegend = legend('AGS_{vertical intercepts}','AGS_{horizontal intercepts}', 'average(AGS_{vert.},AGS_{hor.int})', 'Location', 'SouthEast');
    hxlabel=xlabel('Number of intercepts');
    hylabel=ylabel('Average Grain Size');
    % htitle = title('Variation of average grain size with Number of intercepts');
    set(hlegend,'box','off','FontSize',10,'FontAngle','normal')
    set(hxlabel,'FontSize',11)
    set(hylabel,'FontSize',11)
    % set(htitle,'FontSize',10)
    axis([ min(phase05ab1_data_05a(:,1)) max(phase05ab1_data_05a(:,1))...
        0.85*min([max(phase05ab1_data_05a(:,2)) min(phase05ab1_data_05b(:,2))])...
        1.025*max([max(phase05ab1_data_05a(:,2)) max(phase05ab1_data_05b(:,2))])])
    axis square
    print('-djpeg100',strcat(pwd, '\results\plots\grainsize\', 'Variation_of_AGS_with_Number_of_intercepts.jpeg'))
    % close
end
%<><><><><><><><><><><><><><><><><><>
%<><><><><><><><><><><><><><><><><><>
%% Calculate, Display and Write average of average grain size
for count = 1:max_interceptincrements
    if count == 1
        A_AGSvsMCS_M_intincr1 = (AGSvsMCS_M_hintincr1 + AGSvsMCS_M_vintincr1)/2;
        fprintf('A_AGSvsMCS_M_intincr1 = %2.4f\n',A_AGSvsMCS_M_intincr1);
        dlmwrite(strcat(pwd,'\results','\datafiles','\graindata','\grainsizes',...
            '\averagegrainsize_1_incr = ',num2str(A_AGSvsMCS_M_intincr1),'.txt'),...
            A_AGSvsMCS_M_intincr1','delimiter','\t')
    elseif count == 2
        A_AGSvsMCS_M_intincr2 = (AGSvsMCS_M_hintincr2 + AGSvsMCS_M_vintincr2)/2;
        fprintf('A_AGSvsMCS_M_intincr2 = %2.4f\n',A_AGSvsMCS_M_intincr2);
        dlmwrite(strcat(pwd,'\results','\datafiles','\graindata','\grainsizes',...
            '\averagegrainsize_2_incr = ',num2str(A_AGSvsMCS_M_intincr2),'.txt'),...
            A_AGSvsMCS_M_intincr2','delimiter','\t')
    elseif count == 3
        A_AGSvsMCS_M_intincr3 = (AGSvsMCS_M_hintincr3 + AGSvsMCS_M_vintincr3)/2;
        fprintf('A_AGSvsMCS_M_intincr3 = %2.4f\n',A_AGSvsMCS_M_intincr3);
        dlmwrite(strcat(pwd,'\results','\datafiles','\graindata','\grainsizes',...
            '\averagegrainsize_3_incr = ',num2str(A_AGSvsMCS_M_intincr3),'.txt'),...
            A_AGSvsMCS_M_intincr3','delimiter','\t')
    elseif count == 4
        A_AGSvsMCS_M_intincr4 = (AGSvsMCS_M_hintincr4 + AGSvsMCS_M_vintincr4)/2;
        fprintf('A_AGSvsMCS_M_intincr4 = %2.4f\n',A_AGSvsMCS_M_intincr4);
        dlmwrite(strcat(pwd,'\results','\datafiles','\graindata','\grainsizes',...
            '\averagegrainsize_4_incr = ',num2str(A_AGSvsMCS_M_intincr4),'.txt'),...
            A_AGSvsMCS_M_intincr4','delimiter','\t')
    elseif count == 5
        A_AGSvsMCS_M_intincr5 = (AGSvsMCS_M_hintincr5 + AGSvsMCS_M_vintincr5)/2;
        fprintf('A_AGSvsMCS_M_intincr5 = %2.4f\n',A_AGSvsMCS_M_intincr5);
        dlmwrite(strcat(pwd,'\results','\datafiles','\graindata','\grainsizes',...
            '\averagegrainsize_5_incr = ',num2str(A_AGSvsMCS_M_intincr5),'.txt'),...
            A_AGSvsMCS_M_intincr5','delimiter','\t')
    elseif count == 6
        A_AGSvsMCS_M_intincr6 = (AGSvsMCS_M_hintincr6 + AGSvsMCS_M_vintincr6)/2;
        fprintf('A_AGSvsMCS_M_intincr6 = %2.4f\n',A_AGSvsMCS_M_intincr6);
        dlmwrite(strcat(pwd,'\results','\datafiles','\graindata','\grainsizes',...
            '\averagegrainsize_6_incr = ',num2str(A_AGSvsMCS_M_intincr6),'.txt'),...
            A_AGSvsMCS_M_intincr6','delimiter','\t')
    end
end
A_A_AGSvsMCS_M_intincr_1_and_2 = (A_AGSvsMCS_M_intincr1 +...                                      A_AGSvsMCS_M_intincr2 +...
                                  A_AGSvsMCS_M_intincr2)/2;
fprintf('A_A_AGSvsMCS_M_intincr_1_and_2 = %2.4f\n',A_A_AGSvsMCS_M_intincr_1_and_2);
dlmwrite(strcat(pwd,'\results','\datafiles','\graindata','\grainsizes',...
    '\A_A_AGSvsMCS_M_intincr_1_and_2 = ',num2str(A_A_AGSvsMCS_M_intincr_1_and_2),'.txt'),...
    A_A_AGSvsMCS_M_intincr_1_and_2','delimiter','\t')
A_A_AGSvsMCS_M_intincr_1_2_and_3 = (A_AGSvsMCS_M_intincr1 +...                                      A_AGSvsMCS_M_intincr2 +...
                                    A_AGSvsMCS_M_intincr2 +...
                                    A_AGSvsMCS_M_intincr3)/3;
fprintf('A_A_AGSvsMCS_M_intincr_1_2_and_3 = %2.4f\n',A_A_AGSvsMCS_M_intincr_1_2_and_3);
dlmwrite(strcat(pwd,'\results','\datafiles','\graindata','\grainsizes',...
    '\A_A_AGSvsMCS_M_intincr_1_2_and_3 = ',num2str(A_A_AGSvsMCS_M_intincr_1_2_and_3),'.txt'),...
    A_A_AGSvsMCS_M_intincr_1_2_and_3','delimiter','\t')
A_A_AGSvsMCS_M_intincr_1_2_3_and_4 = (A_AGSvsMCS_M_intincr1 +...
                                      A_AGSvsMCS_M_intincr2 +...
                                      A_AGSvsMCS_M_intincr3 +...
                                      A_AGSvsMCS_M_intincr4)/4;
fprintf('A_A_AGSvsMCS_M_intincr_1_2_3_and_4 = %2.4f\n',A_A_AGSvsMCS_M_intincr_1_2_3_and_4);
dlmwrite(strcat(pwd,'\results','\datafiles','\graindata','\grainsizes',...
    '\A_A_AGSvsMCS_M_intincr_1_2_3_and_4 = ',num2str(A_A_AGSvsMCS_M_intincr_1_2_3_and_4),'.txt'),...
    A_A_AGSvsMCS_M_intincr_1_2_3_and_4','delimiter','\t')
%<><><><><><><><><><><><><><><><><><>
%<><><><><><><><><><><><><><><><><><>
%% Clear variables
if clearvariableswhileworking ~=0
    clear max_interceptincrements agsVSinterceptlineincrements count agstemp numberofvertintercepts phase05ab1_data_05a
end
clear h1phase05a
clear hlegend hxlabel hylabel htitle
%<><><><><><><><><><><><><><><><><><>
%<><><><><><><><><><><><><><><><><><>
end