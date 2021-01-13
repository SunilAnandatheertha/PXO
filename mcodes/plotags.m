function plotags(i,j)
set(0,'DefaultFigureWindowStyle','docked')
%% RESULTS OF 300X300 (SLSP ONLY)

%% RESULTS OF 500X500 (SLSP ONLY)
if i == 500
    if j == 500
        plottrialno1 = 0;
        plottrialno2 = 1;
        if plottrialno2 == 1
            ags0pnt10T2VI = dlmread(strcat(pwd,...
                '\500x500vf0.10_trial02_averagegrainsize_using249_VERTICAL_intercepts.txt'));
            ags0pnt20T2VI = dlmread(strcat(pwd,...
                '\500x500vf0.20_trial02_averagegrainsize_using249_VERTICAL_intercepts.txt'));
            ags0pnt30T2VI = dlmread(strcat(pwd,...
                '\500x500vf0.30_trial02_averagegrainsize_using249_VERTICAL_intercepts.txt'));
            ags0pnt10T2HI = dlmread(strcat(pwd,...
                '\500x500vf0.10_trial02_averagegrainsize_using249_HORIZONTAL_intercepts.txt'));
            ags0pnt20T2HI = dlmread(strcat(pwd,...
                '\500x500vf0.20_trial02_averagegrainsize_using249_HORIZONTAL_intercepts.txt'));
            ags0pnt30T2HI = dlmread(strcat(pwd,...
                '\500x500vf0.30_trial02_averagegrainsize_using249_HORIZONTAL_intercepts.txt'));
            ags0pnt10T2 = (ags0pnt10T2VI + ags0pnt10T2HI)/2;
            ags0pnt20T2 = (ags0pnt20T2VI + ags0pnt20T2HI)/2;
            ags0pnt30T2 = (ags0pnt30T2VI + ags0pnt30T2HI)/2;
        end
        pint = 2000; % plotinterval
        twi  = 50;   % txtwriteinterval
        ags_h = figure(1);
        set(ags_h,'WindowStyle','docked')
        hold on
        box on
        if plottrialno1 == 0 && plottrialno2 == 1
            ags0pnt10T2_h = plot(twi:pint:twi*numel(ags0pnt10T2),ags0pnt10T2(1:pint/twi:numel(ags0pnt10T2)),...
                '^b-','MarkerSize',5,'MarkerFaceColor','b');
            ags0pnt20T2_h = plot(twi:pint:twi*numel(ags0pnt20T2),ags0pnt20T2(1:pint/twi:numel(ags0pnt20T2)),...
                '^k-','MarkerSize',5,'MarkerFaceColor','k');
            ags0pnt30T2_h = plot(twi:pint:twi*numel(ags0pnt30T2),ags0pnt30T2(1:pint/twi:numel(ags0pnt30T2)),...
                '^r-','MarkerSize',5,'MarkerFaceColor','r'); 
            legend_handle = legend('V_f = 0.10 % Trial2, 249 intercepts',...
                              'V_f = 0.20 % Trial2, 249 intercepts',...
                              'V_f = 0.30 % Trial2, 249 intercepts',...
                              'Location','SouthEast');
            set(legend_handle,'FontSize',10)
            set(legend_handle,'Box','Off')
        end
        title_h = title('500x500. \langle GS \rangle vs. t_{sim}');
        set(title_h,'FontSize',10)
        xlabel_h = xlabel('t_{mcs}');
        set(xlabel_h,'FontSize',10)
        ylabel_h = ylabel('\langle GS \rangle');
        set(ylabel_h,'FontSize',10);
        axis tight
        axis square
        grid on
        if plottrialno1 == 1 && plottrialno2 == 1
            print('-djpeg100',strcat(pwd,'\ags500x500_trails',...
                num2str(plottrialno1),',',num2str(plottrialno2),'.jpeg'))
            print('-deps',strcat(pwd,'\ags500x500_trails',...
                num2str(plottrialno1),',',num2str(plottrialno2),'.eps'))
        elseif plottrialno1 == 0 && plottrialno2 == 1
            print('-djpeg100',strcat(pwd,'\ags500x500_trails',...
                num2str(plottrialno1),',',num2str(plottrialno2),'.jpeg'))
            print('-deps',strcat(pwd,'\ags500x500_trails',...
                num2str(plottrialno1),',',num2str(plottrialno2),'.eps'))
        end
    end
end
end