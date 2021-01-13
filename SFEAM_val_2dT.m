% function [varargout] = SFEAM_val_2dT(varargin)

econA = [ 1 2   0  0   0 40 0  0 1;
          2 3   40 0   0 40 30 0 1;
          3 1   40 30  0 0  0  0 1;
          3 4   40 30  0 0  30 0 1; ]
Nodes = unique([econA(:,1); econA(:,2)]);
nNodes = numel(Nodes);
km   = 29.5E6; % nN/nm
kvd1 = 160; % nN/nm
kvd2 = 027; % nN/nm



IEI = econA(:,1:2); %    I.ndividual    E.lement    I.nformation
% Format of "IEI":: see 2 lines below
%   1     2     3     4        5         6         7         8      9      10     11
% [ ElNum Nodei Nodej BondType Stiffness DireCos_l DireCos_m xNodei yNodei xNodej yNodej ]
IEI = [(1:1:size(econA,1))' IEI econA(:,size(econA,2)) zeros(size(econA,1),1)];
ESsz1 = size(IEI,1);
ESsz2 = size(IEI,2);
for count = 1:ESsz1
    if IEI(count, ESsz2-1) == 1
        IEI(count, ESsz2) = km;
    elseif IEI(count, ESsz2-1) == 2
        IEI(count, ESsz2) = kvd1;
    elseif IEI(count, ESsz2-1) == 3
        IEI(count, ESsz2) = kvd2;
    end
end



% The last column in the above "ES" stores stiffness values.
EleLenM = sqrt( (econA(:,6) - econA(:,3)).^2 + (econA(:,7) - econA(:,4)).^2); % E.lement L.ength M.atrix
dclm    = (econA(:,6) - econA(:,3))./EleLenM; % direction coine "l" matrix
dcmm    = (econA(:,7) - econA(:,4))./EleLenM; % direction coine "m" matrix
IEI = [IEI dclm dcmm econA(:,3:size(econA,2)-1)]; % Assemble Direction Cosines inside " IEI " matrix
% Next 2 lines are only for "2-D FEA-only'... NOT for "2-D FEA-MD", "3-D FEA-only" and "3-D FEA".
IEI(:, size(IEI,2)-3) = []; % Remove z-coordinates of Nodei
IEI(:, size(IEI,2)) = []; % Remove z-coordinates of Nodej

nEle = size(IEI,1); % NUMBER OF ELEMENTS

kil  = IEI(:,5);      % k.         of i.ndividual in l.ocal co. sys.
kil = kil./EleLenM;

format long

kmil = zeros(2*nEle,3); % k. m.atrix of i.ndividual in l.ocal co. sys.

for count = 1:nEle
    temp  = kil(count,1) * [+1 -1;
                            -1 +1];
    kmil_count = 2*count;
    kmil(kmil_count-1:kmil_count,:) = [repmat(IEI(count,1),2,1) temp];
end


GDOF = zeros(nNodes,3);
for count = 1:nNodes
    GDOF(count,:) = [Nodes(count) 2*count-1 2*count];
end


kmig = zeros(nEle*4, 7); % k. m.atrix of i.ndividual in g.lobal co. sys.

for count = 1:nEle
    TransMat = [ IEI(count,6) IEI(count,7) 0            0            ;
                 0            0            IEI(count,6) IEI(count,7) ]; % TRANSFORMATION MATRIX
    kmil_count = 2*count;
    kmig_count = 4*count;
    kmig(kmig_count-3:kmig_count,:) = [ repmat(IEI(count,1),4,1) repmat(IEI(count,2),4,1) repmat(IEI(count,3),4,1) TransMat'*kmil(kmil_count-1:kmil_count,size(kmil,2)-1:size(kmil,2))*TransMat ];
    % the repmat stuff in above line is to write the elem number insoide kmig
end

exkmig = zeros(5*nEle,6);% ex.tended kmig
for count = 1:nEle
    element = IEI(count,1);
    kmigcount = 4*count;
    k = kmig(kmigcount-3:kmigcount,size(kmig,2)-3:size(kmig,2));
    temp = [GDOF(IEI(element,2),2:3) GDOF(IEI(element,3),2:3)];
    k_with_gdof = [ [NaN; temp'] [temp; k] ];
    exkmigcount = 5 * count;
    exkmig(exkmigcount-4:exkmigcount,:) = [repmat(IEI(count,1),5,1) k_with_gdof];
end

GSM = zeros(nNodes * 2);
[x,y]   = meshgrid(1:size(GSM,1), size(GSM,2):-1:1);
for count = 1:nEle
    exkmigcount = 5 * count;
    exk   = exkmig(exkmigcount-3:exkmigcount, size(exkmig,2)-3:size(exkmig,2)); % extended stiffness matrix
    gdofe = exkmig(exkmigcount-3:exkmigcount,2); % gdof of this element
    
    GSM(gdofe(1), gdofe(1)) = GSM(gdofe(1), gdofe(1)) + exk(1,1);
    GSM(gdofe(1), gdofe(2)) = GSM(gdofe(1), gdofe(2)) + exk(1,2);
    GSM(gdofe(1), gdofe(3)) = GSM(gdofe(1), gdofe(3)) + exk(1,3);
    GSM(gdofe(1), gdofe(4)) = GSM(gdofe(1), gdofe(4)) + exk(1,4);
    
    GSM(gdofe(2), gdofe(1)) = GSM(gdofe(2), gdofe(1)) + exk(2,1);
    GSM(gdofe(2), gdofe(2)) = GSM(gdofe(2), gdofe(2)) + exk(2,2);
    GSM(gdofe(2), gdofe(3)) = GSM(gdofe(2), gdofe(3)) + exk(2,3);
    GSM(gdofe(2), gdofe(4)) = GSM(gdofe(2), gdofe(4)) + exk(2,4);
    
    GSM(gdofe(3), gdofe(1)) = GSM(gdofe(3), gdofe(1)) + exk(3,1);
    GSM(gdofe(3), gdofe(2)) = GSM(gdofe(3), gdofe(2)) + exk(3,2);
    GSM(gdofe(3), gdofe(3)) = GSM(gdofe(3), gdofe(3)) + exk(3,3);
    GSM(gdofe(3), gdofe(4)) = GSM(gdofe(3), gdofe(4)) + exk(3,4);
    
    GSM(gdofe(4), gdofe(1)) = GSM(gdofe(4), gdofe(1)) + exk(4,1);
    GSM(gdofe(4), gdofe(2)) = GSM(gdofe(4), gdofe(2)) + exk(4,2);
    GSM(gdofe(4), gdofe(3)) = GSM(gdofe(4), gdofe(3)) + exk(4,3);
    GSM(gdofe(4), gdofe(4)) = GSM(gdofe(4), gdofe(4)) + exk(4,4);
    
end



PlotGSM = 0;
PrintPlots = 0;
for count = 1:nEle
    if PlotGSM == 1;
        %spy(GSM)
        %r = symrcm(GSM);
        %m = symamd(GSM);
        %spy(GSM(r,r))
        [fh1] = SPlotMyGSM(GSM, x, y);
        if PrintPlots == 1
            if count == 1
                mkdir(strcat(pwd,'\results\sfeam\GSM_plots'))
            end
            if nEle < 100
                if count < 10
                    print('-djpeg100',strcat(pwd,'\results\sfeam\GSM_plots\GSM_Sparsity_At_EleNum.0',num2str(count),'.jpeg'))
                else
                    print('-djpeg100',strcat(pwd,'\results\sfeam\GSM_plots\GSM_Sparsity_At_EleNum.',num2str(count),'.jpeg'))
                end
            elseif nEle >= 100 && nEle < 1000
                if count < 10
                    print('-djpeg100',strcat(pwd,'\results\sfeam\GSM_plots\GSM_Sparsity_At_EleNum.00',num2str(count),'.jpeg'))
                elseif count >= 10 && count < 100
                    print('-djpeg100',strcat(pwd,'\results\sfeam\GSM_plots\GSM_Sparsity_At_EleNum.0',num2str(count),'.jpeg'))
                elseif count >= 100 && count < 1000
                    print('-djpeg100',strcat(pwd,'\results\sfeam\GSM_plots\GSM_Sparsity_At_EleNum.',num2str(count),'.jpeg'))
                end
            end
            if count < nEle
                delete(fh1); 
            end
        end
    end
end

% FORM DISPLACEMENT MATRIX
U = zeros(size(GSM,1),1);
U(:) = NaN;

% FORM DIAPLCEMENT CONSTRAIN MATRIX
% FORMAT:: [   NODENUMBER   GDOF1_CONSTRAINT    GDOF2_CONSTRAINT    ]
% NOTE: value of GDOF1_CONSTRAINT refers to 

DispConsMatrix = [ 1 0   0;
                   4 0   0;
                   2 NaN 0];
for count = 1:size(DispConsMatrix,1)
    U(2*DispConsMatrix(count,1)-1,1) = DispConsMatrix(count,2);
    U(2*DispConsMatrix(count,1)  ,1) = DispConsMatrix(count,3);
end


%---------------------------------------------
% FORM LOAD VECTOR
P = zeros(size(GSM,1),1);

LodingMatrix = [ 2 +20000  +0    ;
                 3 +0      -25000; ];

for count = 1:size(LodingMatrix,1)
    P(2*LodingMatrix(count,1)-1,1) = LodingMatrix(count,2);
    P(2*LodingMatrix(count,1)  ,1) = LodingMatrix(count,3);
end


%\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\


% ELIMINATE ROWS and COLUMNS ---> in:
% global stiffness matrix
temp = find(U==0); % find all GDOF positoins which are fully constrauined
GSMae = GSM; % GSM a.fter e.limination
GSMae(:,temp) = [];
GSMae(temp,:) = [];
% displacemebt matrix
Uae = U; % U. a.fter e.limination
Uae(temp,:) = [];
% load matrix
Pae = P; % P. a.fter e.limination
Pae(temp,:) = [];
%---------------------------------------------
% SOLVE THE SYSTEM OF EQUATIONS
% Solve for displacements
%\\\\\\\\\\\\\\\\\\\\\\\\\\
%\\\\\\\\\\\\\\\\\\\\\\\\\\
%det(GSMae)
DISPLACEMENTS = Pae'/GSMae;
%\\\\\\\\\\\\\\\\\\\\\\\\\\
%\\\\\\\\\\\\\\\\\\\\\\\\\\
DISPLACEMENTS = DISPLACEMENTS';
% Solve for forces
Forces        = GSMae * DISPLACEMENTS;
for count = 1:numel(Forces)
    if ( round(abs(Forces(count))) -  abs(Forces(count)) ) < 1E-6
        Forces(count) = round(Forces(count));
    end
end
Pae
GSM
DISPLACEMENTS'
%\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

NaN_inU = find(isnan(U)==1);

for count = 1:numel(NaN_inU)
    U(NaN_inU(count,1)) = DISPLACEMENTS(count);
end

SupportReactionsAtDOF = zeros(numel(find(isfinite(DispConsMatrix(:,2:3))==1)),1);

GoBack = 0;
for count = 1:numel(DispConsMatrix(:,1))
    if isnan(DispConsMatrix(count,2)) ~= 1
        SupportReactionsAtDOF(2*count-1-GoBack,1) = 2*DispConsMatrix(count)-1;
    else
        GoBack = GoBack + 1;
    end
    if isnan(DispConsMatrix(count,3)) ~= 1
        SupportReactionsAtDOF(2*count-GoBack,1) = 2*DispConsMatrix(count);
    else
        GoBack = GoBack + 1;
    end
end

K_To_Find_Reactions = zeros(numel(SupportReactionsAtDOF), size(GSM,2));

SupportReactionsAtDOF = sort(SupportReactionsAtDOF);

for count = 1:numel(SupportReactionsAtDOF)
    K_To_Find_Reactions(count,:) = GSM(SupportReactionsAtDOF(count),:);
end

% SUPPORT REACTIONS: R = KQ-F (Refer chandrupatla. pg. 111)
REACTION = K_To_Find_Reactions * U % These occur at DOFs SupportReactionsAtDOF, as defined in DispConsMatrix