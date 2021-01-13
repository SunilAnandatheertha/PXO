% this is a trial fea code for LINEAR springs
% EleCon = [elem1 nodeiOfelem1 nodejOfelem1;
%           elem2 nodeiOfelem2 nodejOfelem2;];
% ExEleCon = [elem1 Kelem1 nodeiOfelem1 nodejOfelem1;
%             elem2 Kelem2 nodeiOfelem2 nodejOfelem2;];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% ELEMENT INFORMATION
EleCon = [1 1 2;
          2 2 3;
          3 3 4
          4 4 5
          5 5 6
          6 6 7;]; % EleCon - Element Connectivity
k      = [100*rand;
          100;
          100;
          100;
          100*rand;
          100;]; % k values in kN/m
NoOfElements = size(EleCon,1);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% BOUNDARY CONDITIONS ---- LOADS:
%   there are no loads applied on nodes 2 to (nd_sys - 1)
%   Hence, if nd_sys = 8, in Kd = F, F values for nodes 2,3,4..,7 are zero
%   P is applied on nd.no. 8
%   But, ther exists a reaction force on node 1 as it is constrained against any motion
NodalForce = [NaN;
              0;
              0;
              0;
              0;
              0;
              5;];
% units: kN
% NaN entries marks unkown force values. These are to be calculated
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% BOUNDARY CONDITIONS ---- DISPLACEMENTS:
%   only node 1 is constrained to move. 
%   hence u1 = 0
NodalDisp = [0;
             NaN;
             NaN;
             NaN;
             NaN;
             NaN;
             NaN;];
% units: m
% NaN entries marks unkown displacement values. These are to be calculated
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% FORMULATE ELEMENT STIFFNESS MATRICES, AND INCLUDE IT AND ELEMENT NODE NUMBERS, IN KLCL_cell
KLCL_cell = cell(NoOfElements,2);
for elem = 1:NoOfElements
    KLCL_cell{elem,1} = [EleCon(elem,2) EleCon(elem,3)];
    KLCL_cell{elem,2} = k(elem)*[1 -1; -1  1];
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% CALCULATE KGBL{1,1}
nodes_in_sys = unique(reshape(EleCon(:,2:3),1,numel(EleCon(:,2:3)))); % these are the nodes in the FE system
NoOfNodes    = numel(nodes_in_sys); % number of nodes in the FE system
MinNdNum_sys = min(nodes_in_sys);   % minimum node number in the FE system
MaxNdNum_sys = max(nodes_in_sys);   % maximum node number in the FE system
NdNumIncr    = 1;                   % node number increment (let it default to 1)
KGBL{1,1}    = MinNdNum_sys:NdNumIncr:max(nodes_in_sys);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% CALCULATE DEGREE OF FREEDOM OF THE COMPLETE FE SYSTEM
NID       = 1; % Number of Independent Directions in which node can move NOTE: NID=1 for 1D, NID=2 for 2D, etc..
DOF_sys   = NoOfNodes * NID; % Only in this case.. In other cases, it should be known apriori
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% \\\\\\\\GLOBAL STIFFNESS MATRIX ASSEMBLY//////////
KGBL{1,2} = zeros(DOF_sys,DOF_sys); % initialize Global K matrix as a cell entry in KGBL
NdNum_sys = KGBL{1,1}; % invoke back the value of NdNum_sys from KGBL_cell
for elem = 1:NoOfElements
    NdNum_elem = KLCL_cell{elem,1}; % invoke back the value of NdNum_elem from KLCL_cell
    p = NdNum_elem(1,1); % this is the ith node of the 'elem'th element
    q = NdNum_elem(1,2); % this is the jth node of the 'elem'th element
    % Next 4 lines take values from KLCL and place them in KGBL at required positions
    KGBL{1,2}(p,p) = KGBL{1,2}(p,p) + KLCL_cell{elem,2}(1,1);
    KGBL{1,2}(p,q) = KGBL{1,2}(p,q) + KLCL_cell{elem,2}(1,2);
    KGBL{1,2}(q,p) = KGBL{1,2}(q,p) + KLCL_cell{elem,2}(2,1);
    KGBL{1,2}(q,q) = KGBL{1,2}(q,q) + KLCL_cell{elem,2}(2,2);
end
% KGBL{1,2}; % display Glo0bal Stiffness Matrix
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% PARTITIONING THE GLOBAL STIFFNESS MATRIX
% First, find out which of the nodes are constrained from moving
ConNdNum = find(NodalDisp==0); % Constrained node number
% Next,  find out which of the nodes are not-constrained from moving
UnConNodes = nodes_in_sys;
UnConNodes(ConNdNum) = [];
% Next, intead of eliminating the (ConNdNum)th col and row from KGBL, extract KGBLp from KGBL
% The above is carried out as follows:
%   First, extract  KGBL{1,2} to KGBLp
KGBL_P = KGBL{1,2}; % KGBL_P; KGBL Partitioned. This is not yet partitioned
% Now partition KGBL_P: first by col and then by row (first by row and then by col will also work)
for col = 1:numel(ConNdNum)
    KGBL_P(:,ConNdNum(col)) = [];% Eliminate these columns
end
for row = 1:numel(ConNdNum)
    KGBL_P(ConNdNum(row),:) = [];% Eliminate these rows
end
% KGBL_P; % Diaplay PARTITIONED GLOBAL STIFFNESS MATRIX
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% PARTITIONING THE LOAD VECTOR
% First, extract NodalForce to NodalForce_P
NodalForce_P = NodalForce;
% Next, eliminate the row belonging to constrained node
for row = 1:numel(ConNdNum)
    NodalForce_P(ConNdNum(row),:) = [];% Eliminate these columns
end
% NodalForceP has now been partitioned
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% SOLVE THE EQUATIONS
% In next line, displacements refer to UnConNodes
nodaldisplacements = KGBL_P\NodalForce_P;
NodalDISP = zeros(NoOfNodes,1);
for ct1 = 1:numel(UnConNodes)
    NodalDISP(UnConNodes(ct1)) = nodaldisplacements(ct1);
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% CALCULATE FINAL NODAL POSITIONS, AFTER UNDERGOING DISPLACEMENT
AssumedEleLength = 1; % unity
InitialNodalPositions = (0:AssumedEleLength:NoOfElements*AssumedEleLength)';
NdDisp = zeros(NoOfNodes,1);
for ct1 = 1:numel(UnConNodes)
    NdDisp(UnConNodes(ct1)) = nodaldisplacements(ct1);
end
FinalNodalPositions = InitialNodalPositions + NdDisp;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %% PLOT THE NODAL DISSPLACEMENTS
close all
set(0,'DefaultFigureWindowStyle','docked')
% GRXh_DISPLACEMENT     = figure(1); hold on
% GRXh_DISPLACEMENTplot = plot(1:numel(NodalDISP),NodalDISP,'-ko','LineWidth',3,'MarkerSize',10,'MarkerFaceColor','r');
% GRXh_DISPLACEMENT_XL  = xlabel('Node Number');
% GRXh_DISPLACEMENT_YL  = ylabel('Displcament along x');
% GRXh_DISPLACEMENT_TT  = title('Plot of nodal displacements');
% axis tight
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% MAKING USE OF SUB-PLOTS
figure
% SUB-PLOT : 01--graph of nodal displacement vs node number
GRXhSP1 = subplot(2,1,1);% GRXhSP: Graphix Handle SubPlot
GRXhSP1_xl = xlabel('Node Number'); % xl - xlabel
GRXhSP1_yl = ylabel('Displcament along x'); % yl - ylabel
GRXhSP1_tt = title('Graph of nodal displacements'); % tt - title
grid on; box on; hold on
GRXhSP1_PLOT = plot(1:numel(NodalDISP),NodalDISP,'-ko','LineWidth',3,'MarkerSize',10,'MarkerFaceColor','r');

% SUB-PLOT : 02--plot of element deformations
GRXhSP2 = subplot(2,1,2);% GRXhSP: Graphix Handle SubPlot
GRXhSP2_xl = xlabel('x - axis'); % xl - xlabel
GRXhSP2_yl = ylabel('y-axis'); % yl - ylabel
GRXhSP2_tt = title('Element Deformation plot'); % tt - title
grid on; box on; hold on
GRXhSP2_plota = plot(InitialNodalPositions, zeros(numel(InitialNodalPositions),1),'-ks','LineWidth',3,'MarkerSize',10,'MarkerFaceColor','r');
GRXhSP2_plotb = plot(FinalNodalPositions, zeros(numel(FinalNodalPositions),1),   '--bs','LineWidth',1,'MarkerSize',7.5,'MarkerFaceColor','c');
axis([min(FinalNodalPositions) max(FinalNodalPositions) -1 +1])
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% PRINT RESULT: plots
print('-depsc',strcat(pwd,'\FEA_PLOTS_1D_LinearSprings.eps'))