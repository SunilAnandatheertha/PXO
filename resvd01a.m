% revd02a -- results for paper "vasudeva02" - code a
if isdir(strcat(pwd,'\compiled_results'))==0
    mkdir(strcat(pwd,'\compiled_results'))
end
if isdir(strcat(pwd,'\compiled_results\monte_carlo'))==0
    mkdir(strcat(pwd,'\compiled_results\monte_carlo'))
end
set(0,'DefaultFigureWindowStyle','docked')
clear all,close all
%% Results at Vfi = 1.0000
agsvsvfi_100p_0pnt01250r_250x250 = (24.0854+22.8337)/2;
agsvsvfi_100p_0pnt01250r_300x300 = (28.0109+32.2384)/2;
agsvsvfi_100p_0pnt01250r_500x500 = (44.2949+46.8010)/2;

figure(1)

h1 = plot([250 300 500],[agsvsvfi_100p_0pnt01250r_250x250 agsvsvfi_100p_0pnt01250r_300x300 agsvsvfi_100p_0pnt01250r_500x500],...
    'ks','MarkerFaceColor','k');
axis square, axis tight

agsvsvfi_100p_0pnt00625r_500x500 = (48.5111+49.0880)/2;



agsvsvfi_150p_0pnt01250r_250x250 = (18.7501+19.2510)/2;
agsvsvfi_150p_0pnt01250r_500x500 = (29.3432+29.4161)/2;