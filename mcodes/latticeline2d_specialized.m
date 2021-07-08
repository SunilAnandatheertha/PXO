function [AGSvsMCS_cell] = latticeline2d_specialized(typeofintercept,attri1,attri2)



SHOULDIPLOT = 1;
SHOULDIPLOTHISTOGRAM = 0;
% |||| type ofintercept |||| = V (vertical), H (horizontal), I (inclined) :::::::: 'STRING'

% |||| attri1 |||| = attribute 1
% attri1 = interceptincrements :::::::: '+ve INTEGER > 0'

% |||| attri2 |||| = attribute 2
% attri2  = 00 -- vertical  (attri1 not required, dummied to 00)
%           = 00 -- horizontal (attri1 not required, dummied to 00)
%           = theta -- inclined (theta -- angle in degrees + ve acc)

interceptlineincrements = attri1;
angle = attri2; % for inclined intercepts only

% siminf = dlmread(strcat(pwd,'\simdata.txt'));

latpar1 = dlmread(strcat(pwd,'\simparameters','\latpar.txt'));
simpar1 = dlmread(strcat(pwd,'\simparameters','\simpar.txt'));
ffo1    = dlmread(strcat(pwd,'\simparameters','\ffo.txt'));

xmin  = latpar1(1);
xmax  = latpar1(2);
ymin  = latpar1(3);
ymax  = latpar1(4);
xincr = latpar1(5);
yincr = latpar1(6);

PERTURBfactor = latpar1(7);

xlength = abs(xmin)+abs(xmax);
ylength = abs(ymin)+abs(ymax);
[x,y]   = meshgrid(xmin:xincr:xmax,ymin:yincr:ymax);

q           = simpar1(1);
mcsmax      = simpar1(2);
mcsinterval = ffo1(1);
mcs1        = mcsinterval;
AGCMCScount = 0;
[x,y]       = readcoordinates(); % read coordinates from hard disk

if strcmp(typeofintercept,'V')==1
    display('<><><><><><><><><><><><><><><><><><>'),display('<><><><><><><><><><><><><><><><><><>')
    numberofverticalintercepts = numel(interceptlineincrements:interceptlineincrements:size(x,2)-interceptlineincrements);
    fprintf('Number of Vert. Intercepts used: %d \n',numberofverticalintercepts);
end
if strcmp(typeofintercept,'H')==1
    display('<><><><><><><><><><><><><><><><><><>'),display('<><><><><><><><><><><><><><><><><><>')
    numberofhorizontalintercepts = numel(interceptlineincrements:interceptlineincrements:size(x,1)-interceptlineincrements);
    fprintf('Number of Horz. Intercepts used: %d \n',numberofhorizontalintercepts);
end

AGSvsMCS_cell = cell(4,1);
AGSvsMCS_cell{2,1} = cell(numel(mcs1:mcsinterval:mcsmax),1);

for mcsnumber = mcs1:mcsinterval:mcsmax
    [qstates] = readstatematrixmc(mcsnumber); % read the state matrix from hard disk
    
    if strcmp(typeofintercept,'V')==1
        max_intercepts_wrt = size(x,2);
    elseif strcmp(typeofintercept,'H')==1
        max_intercepts_wrt = size(x,1);
        qstates = qstates';
        x = x'; y = y';
    end
    
    AGCMCScount = AGCMCScount + 1;
    
    fprintf('Analyzing Monte-Carlo step no. %d....',mcsnumber)
    agscount = 1;
    
    for n = interceptlineincrements:interceptlineincrements:max_intercepts_wrt-interceptlineincrements
        lineele = (n*size(x,1)+1):((n+1)*size(x,1));
        q_along_lineele = qstates(lineele);
        grainboundaryele = [];
        graintograindist = [];
        for count =1:numel(lineele)-1
            if q_along_lineele(count)~=0 % This command ignores the zener sites. Hence their size will not affect the average grain size calculation
                % With above line, average grain size will be smaller than
                % withoutthe above line
                if q_along_lineele(count) == q_along_lineele(count+1)
                    grainboundaryele(count) = 0;
                    graintograindist(count) = 0;
                else
                    grainboundaryele(count) =1;
                    graintograindist(count) = count;
                end
            end
        end
        if q_along_lineele(numel(lineele)) == q_along_lineele(1)
            grainboundaryele(numel(lineele)) =0;
        else
            grainboundaryele(numel(lineele)) =1;
        end
        graintograindist1 = graintograindist;
        graintograindist1(graintograindist1==0)=[];
        %nonzero = 0;
        graintograindist2 = zeros(1,numel(graintograindist1));
        graintograindist2(2:numel(graintograindist2)) = graintograindist1(1:numel(graintograindist1)-1);
        graintograindist3 = graintograindist1-graintograindist2;
        agscount = agscount+1;
        AGS(agscount) = sum(graintograindist3)/numel(graintograindist3);
    end
    AGSvsMCS_cell{2,1}{AGCMCScount, 1} = AGS;
    AGSvsMCS(AGCMCScount) = sum(AGS)/numel(AGS);
    fprintf('Average grain size = %d units \n',AGSvsMCS(AGCMCScount));
end

if SHOULDIPLOTHISTOGRAM == 1
    hist(graintograindist3)
    axis square
    print('-djpeg100',strcat(pwd,'\results\plots\grainsize\','Itercept_AGS_HISTogram_','HorizontalIntercepts.jpeg'))
end
     
     
     
AGSvsMCS_cell{1,1} = AGSvsMCS;

if SHOULDIPLOT == 1
    figure
    h1 = plot(mcs1:mcsinterval:mcsmax,AGSvsMCS(:),'-k.','LineWidth',0.2,'MarkerSize',8); hold on
    % h2 = plot(mcs1:mcsinterval:mcsmax,AGSvsMCS(:),'k.','MarkerSize',5);
    xlabel('Lattice edge')
    ylabel('Average Grain Size')
    mcsteps = mcs1:mcsinterval:mcsmax;

    grid off,axis tight, axis square
    xlabel('MC Step number')
    ylabel('Intercept grain size')
    % title('Variation of average grain size during microstructure evolution')

     if strcmp(typeofintercept,'V')==1
         h3 = text(0.50*mcsmax,0.3*((max(AGSvsMCS)+min(AGSvsMCS))/2),...
             strcat(num2str(xlength),'x',num2str(ylength),'--',num2str(numberofverticalintercepts),typeofintercept,'intercepts'),...
             'HorizontalAlignment','left','BackgroundColor',[1 1 1],'Margin',7.5,'EdgeColor','none','LineWidth',1);
         print('-djpeg100',strcat(pwd,'\results\plots\grainsize\','AGS_vs_MCS--',...
             num2str(numel(interceptlineincrements:interceptlineincrements:size(x,1)-interceptlineincrements)),'VerticalIntercepts.jpeg'))
     elseif strcmp(typeofintercept,'H')==1
         h3 = text(0.50*mcsmax,0.3*((max(AGSvsMCS)+min(AGSvsMCS))/2),...
             strcat(num2str(xlength),'x',num2str(ylength),'--',num2str(numberofhorizontalintercepts),typeofintercept,'intercepts'),...
             'HorizontalAlignment','left','BackgroundColor',[1 1 1],'Margin',7.5,'EdgeColor','none','LineWidth',1);
         print('-djpeg100',strcat(pwd,'\results\plots\grainsize\','AGS_vs_MCS--',...
             num2str(numel(interceptlineincrements:interceptlineincrements:size(x,1)-interceptlineincrements)),'HorizontalIntercepts.jpeg'))
     end
    end
    % dlmwrite(strcat(pwd,'\AGSvsMCS.txt'),AGSvsMCS,'delimiter','\t')
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [x,y] = readcoordinates()

x = dlmread(strcat(pwd,'\results\datafiles\coordinates','\x.txt'));
y = dlmread(strcat(pwd,'\results\datafiles\coordinates','\y.txt'));
end
function [qstates] = readstatematrixmc(mcsnumber)

qstates = dlmread(strcat(pwd,'\results\datafiles\statematrices','\s',num2str(mcsnumber),'mcs1','.txt'));
end