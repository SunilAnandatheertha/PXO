function [GrapheneStackLayUp, xgstack, ygstack, zgstack,...
          cgstack,vd1gstack, vd2gstack, vd3gstack,...
          InfoDisplayMatrix] = AGG_StackGrapheneSheets(GrapheneStackLayUp, InterGSSpacing, WriteToDisk, ISSL)
% AGG -- Atomic Geometry Generator
%\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
% ISSL --- INTER SHEET SPACING LIMITS
%\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
% StoredGrapheneStackNumber = 16;
% 
% if StoredGrapheneStackNumber == 1
%     GrapheneStackLayUp = [10 0 2.0000 0.0000];
% elseif StoredGrapheneStackNumber == 2
%     GrapheneStackLayUp = [05 0 2.0000 0.0000;
%                           05 0 2.0000 10.0000;];
% elseif StoredGrapheneStackNumber == 3
%     GrapheneStackLayUp = [04 0 1.0000 0.0000;
%                           08 0 2.5000 2.0000;
%                           12 0 4.000 4.0000;];
% elseif StoredGrapheneStackNumber == 4
%     GrapheneStackLayUp = [10 0 2.0000 0.0000;
%                           10 0 2.0000 1.0000;
%                           10 0 2.0000 2.0000;
%                           10 0 2.0000 3.0000;];
% elseif StoredGrapheneStackNumber == 16
%     GrapheneStackLayUp = [10 0 3.0000 0.0000;
%                           10 0 3.0000 1.0000;
%                           10 0 3.0000 2.0000;    
%                           10 0 3.0000 3.0000;
%                           10 0 3.0000 4.0000;
%                           10 0 3.0000 5.0000;
%                           10 0 3.0000 6.0000;];
% end
%\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
%\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
NoOfStacks        = size(GrapheneStackLayUp,1);
xgstack           = cell(1,NoOfStacks); % xgstack  - x of graphene stack
ygstack           = cell(1,NoOfStacks); % ygstack  - y of graphene stack
zgstack           = cell(1,NoOfStacks); % zgstack  - z of graphene stack
cgstack           = cell(1,NoOfStacks); % cgstack  - covalent element details of graphene stack
vd1gstack         = cell(1,NoOfStacks); % vd1stack - vd1 element details of graphene stack
vd2gstack         = cell(1,NoOfStacks); % vd2stack - vd2 element details of graphene stack
vd3gstack         = cell(1,NoOfStacks-1); % vd3stack - vd3 element details of graphene stack: Inter sheet vd bonds
InfoDisplayMatrix = zeros(9,NoOfStacks);
%\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
%\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
% InterGSSpacing    = 0.3350; % Inter Graphene Sheet Spacing, in nm
%\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
%\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
for ct1 = 1:NoOfStacks
    m   = GrapheneStackLayUp(ct1,1);
    n   = GrapheneStackLayUp(ct1,2);
    l   = GrapheneStackLayUp(ct1,3);
    vdd = GrapheneStackLayUp(ct1,4);
    %\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
    WriteToDisk = 1;
    [xsgs, ysgw, cov_gra, vd1_gra, vd2_gra, Width, Length] = AGG_SingleGrapheneSheet(m, n, l, vdd, WriteToDisk); % <-- GENERATE A GRAPHENE SHEET
    %\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
    % Populate the cells: xgstack{1,ct1}, ygstack{1,ct1}, zgstack{1,ct1}, cgstack{1,ct1}, vd1gstack{1,ct1} & vd2gstack{1,ct1} -->
    xgstack{1,ct1}   = xsgs;
    ygstack{1,ct1}   = ysgw;
    zgstack{1,ct1}   = InterGSSpacing*(ct1-1)*ones(size(xsgs));
    zgstack{1,ct1}(isnan(xgstack{1,ct1})==1) = NaN; % here "isnan(xgstack{1,ct1})==1" represents Vacancy Defect Site
    %\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
    if ct1 > 1
        xsheeti = xgstack{1,ct1-1};
        ysheeti = ygstack{1,ct1-1};
        zsheeti = zgstack{1,ct1-1};
        xsheetj = xgstack{1,ct1};
        ysheetj = ygstack{1,ct1};
        zsheetj = zgstack{1,ct1};
        [vd3_gra] = AGG_GrapheneStackInterSheet(xsheeti, ysheeti, zsheeti, xsheetj, ysheetj, zsheetj,[ISSL(1) ISSL(2)]);
    end
    %\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
    cgstack{1,ct1}   = cov_gra;
    vd1gstack{1,ct1} = vd1_gra;
    vd2gstack{1,ct1} = vd2_gra;
    if ct1 > 1
        vd3gstack{1,ct1-1} = vd3_gra;
    end
    NumberOfAtoms    = numel(xgstack{1,ct1}) - numel(find(isnan(xgstack{1,ct1})==1));
    NumberOfCovEle   = size(cgstack{1,ct1},1);
    NumberOfVd1Ele   = size(vd1gstack{1,ct1},1);
    NumberOfVd2Ele   = size(vd2gstack{1,ct1},1);
    %\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
    InfoDisplayMatrix(:,ct1) = [m; n; vdd; Width; Length; NumberOfAtoms; NumberOfCovEle; NumberOfVd1Ele; NumberOfVd2Ele];
    %\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
    if ct1 == 1
        ColumnStringName = strcat('LayerNo',num2str(ct1));
    else
        ColumnStringName = [ColumnStringName ' ' strcat('LayerNo',num2str(ct1))];
    end
    %\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
end
%\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
%\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
% CONSOLE DISPLAY :: SHOULD BE A PART OF fn: CONSOLE_MESSAGE_DISPLAY(..)
printmat(InfoDisplayMatrix,'StackInfo','m n VDD Width Length NumberOfAtoms NumberOfCovEle NumberofVd1Ele NumberOfVd2Ele',ColumnStringName)
%\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
PlotAtoms  = 0;
PlotCovEle = 1;
PlotVd1Ele = 1;
PlotVd2Ele = 1;
PlotVd3Ele = 1;
PlotDifferentViewsInSP = 0;

%% NOW CALL SMS RESULT VISUALIZATION MODULE
StoredGrapheneStackNumber = 'dummy';
SRV('ag', 's', 'gn', xgstack, ygstack, zgstack, cgstack,...
                     vd1gstack, vd2gstack, vd3gstack, GrapheneStackLayUp, PlotAtoms,...
                     PlotCovEle, PlotVd1Ele, PlotVd2Ele, PlotVd3Ele,...
                     PlotDifferentViewsInSP, StoredGrapheneStackNumber);

% GRX_PlotGrapheneStack(xgstack, ygstack, zgstack, cgstack,...
%                       vd1gstack, vd2gstack, vd3gstack, GrapheneStackLayUp, PlotAtoms,...
%                       PlotCovEle, PlotVd1Ele, PlotVd2Ele, PlotVd3Ele,...
%                       PlotDifferentViewsInSP, StoredGrapheneStackNumber);

%\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
%\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
end