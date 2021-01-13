latpar1     = dlmread(strcat(pwd,'\simparameters','\latpar.txt'));

slspinfo1     = dlmread(strcat(pwd,'\simparameters','\slspinfo.txt'));
icntinfo1   = dlmread(strcat(pwd,'\simparameters','\icntinfo.txt'));
slpclustinfo1 = dlmread(strcat(pwd,'\simparameters','\slpclustinfo.txt'));

simpar1     = dlmread(strcat(pwd,'\simparameters','\simpar.txt'));
ffo1        = dlmread(strcat(pwd,'\simparameters','\ffo.txt'));
cm          = dlmread(strcat(pwd,'\results','\colormatrix.txt'));
xmin        = latpar1(1);
xmax        = latpar1(2);
ymin        = latpar1(3);
ymax        = latpar1(4);
xincr       = latpar1(5);
yincr       = latpar1(6);
xlength     = abs(xmin)+abs(xmax);
ylength     = abs(ymin)+abs(ymax);
[x,y]       = meshgrid(xmin:xincr:xmax,ymin:yincr:ymax);
Q           = simpar1(1);
m           = simpar1(2);

wantslsp    = slspinfo1(1);
wantcnt     = icntinfo1(1);
wantslspclust = slpclustinfo1(1);

txtwriteint = ffo1(1);
sz1         = size(x,1);
sz2         = size(x,2);

filename = strcat(pwd,'\results\datafiles\statematrices','\s', num2str(rset*txtwriteint),'mcs',num2str(1),'.txt');
s = dlmread(filename);
%--------------------------------
% 1. Build the set "LS(q=1:Q)"
% 2. Extract all "LS" of a "q"
% 3. Pick an "ls", in LS(q).
%    3a. Initialize SP to 0 if the ls is first in LS(q)
%    3a. If SP = 0 or 2, choose it randomly and update LS(q) to [grain] "g"
%    3b. If SP = 1, use the elements of the [front]
% 4. Identify its [front] "lsf"
%    4a. If the front exists, set GrainFull = 0 else GrainFull = 1
%    4b. If GrainFull = 0
%         4b1. Dump [front] "lsf" to [grain] "g"
%         4b2. Repeat from step 3
%    4c. If GrainFull = 1
%         4c1. Update [grain] to cell GRAINS_In_q{q,1}
%         4c2. Set SP = 2
% 5. Repeat from step 2
%--------------------------------
% \-FUNCTIONS-\
% FUNCTION 1  ====Build_LS_q====
%             INPUTS    Q, x, y, s
%             OUTPUTS   eq, xq, yq, GRAINS_In_q
%             FORMAT    [eq, xq, yq, GRAINS_In_q] = Build_LS_q(Q, x, y, s)
%             COMMENTS
%             ALGORITHM
%                   STEP 01: Extract all elements eq in state mentrix s belonging to q
%                   STEP 02: Get x of eq in xq
%                   STEP 03: Get y of eq in yq
%                   STEP 04: Initialize GRAINS_In_q to unit cell
%             PSEUDO CODE
%                   eq = location in s for s == q
%                   xq = x(eq)
%                   yq = y(eq)
%             CODE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure; axis square; box on; hold on; axis([-101 101 -101 101])
tic
All_Grains_Q = cell(1,Q);
for q = 1:64
    guessnoofgrains = 1e3; % Assuming there are 1E3 grains in each q
    [eq, xq, yq, GRAINS_In_q] = Initialize_eq_xyq_GRAINS_In_q(q, s,...
                                             x, y, guessnoofgrains);
    eq_stat = eq;
    xq_stat = xq;
    yq_stat = yq;
    if ~isempty(eq)
        % This branch only executes when there is atleast 1 lattice
        % in q. That is, when numel(eq)>0
        eq_dyn = eq; % This reduces in size to [], dynamically in the below loop
        xq_dyn = xq;
        yq_dyn = yq;
        
        eq_dyn0 = eq; % This reduces in size to [], dynamically in the below loop
        xq_dyn0 = xq;
        yq_dyn0 = yq;
        for ng = 1:1E3
            % This loop will run till all grains in q have been identified
            GrainFull = 0; % The grain has not yet been identified
            if ~isempty(eq_dyn0)
                Type_of_SP      = 0;
                [grain, eq_dyn, xq_dyn, yq_dyn,...
                        eq_dyn0, xq_dyn0, yq_dyn0] = Identify_one_Grain_In_q(ng, eq_stat, xq_stat,...
                                                                             yq_stat, eq_dyn, xq_dyn,...
                                                                             yq_dyn, xincr, yincr,...
                                                                             Type_of_SP, GrainFull,...
                                                                             eq_dyn0, xq_dyn0, yq_dyn0);
                GRAINS_In_q{ng} = grain;
%                 % Plot to check
                [~, ind_temp] = intersect(eq, GRAINS_In_q{ng});
                rand(1,3)
                plot(xq(ind_temp), yq(ind_temp), 'ks', 'markerfacecolor', cm(q,:), 'markersize', 4, 'markeredgecolor',cm(q,:))
                %% plot rest of points
                %[~, ind_temp] = intersect(eq, eq_dyn0);
                %plot(xq(ind_temp), yq(ind_temp), 'ko', 'markerfacecolor', 'w', 'markersize', 3)
            else
                % When all grains have been identified, 
                % there will be no more elements in eq_dyn
                % If this condition is met, break this loop and 
                % go to next q
                
                % Remove empty cells in GRAINS_In_q:
                [GRAINS_In_q]   = Rem_Empty_cells_GRAINS_In_q(GRAINS_In_q);
                break
            end
%             pause(0.001)
        end
        All_Grains_Q{q} = GRAINS_In_q;
    end
    pause(0.001)
end
toc
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION 2  ====IdentifyGrainInq====
%             INPUTS    eq_dyn, xq, yq, GRAINS_In_q
%             OUTPUTS   GRAINS_In_q
%             COMMENTS
%             ALGORITHM
%                   STEP 01: Copy eq to eq_dyn
%                   STEP 02: Identify those eq_dyn from which the front starts to grow
%                   STEP 03: Initialize an array to store the growing grain
%                   STEP 04: Calculate if the grain has fully grown
%                   STEP 05: If the grain is still growing, choose the source points from front
%                   STEP 06: If the grain has grown, choose the next source point randomnly from eq_dyn
%                   STEP 07: When a grain has fully grown, remove them from eq_dyn
%                   STEP 06: Repeat from step 2 as long as eq_dyn is not null.
%                   STEP 06: When eq_dyn is exhausted go to next q
%             PSEUDO CODE
%                   LOOP START: infinite for. Iterator: sp
    %                   FUNCALL:    ChooseSourcePointForFront
    %                   INITIALIZE: grain = []
    %                   LOOP START: for each element in front
    %                       FUNCALL:   CalculateDistances: CASES: Vertical, Horizontal and Diagonal
    %                       FUNCALL:   Find_Neighbours:    CASES: Vertical, Horizontal and Diagonal
%             CODE
%     -     -     -     -     -     -
%     -     -     -     -     -     -
% FUNCTION 2a ====ChooseSourcePointForFront====
%             INPUTS    eq, front, Type_of_SP, GrainFull
%             OUTPUTS   frontvector
%             COMMENTS
%                  (1) Called inside function 2
%                  (2) Calls no other functions
%             ALGORITHM
%             PSEUDO CODE

%     -     -     -     -     -     -
%     -     -     -     -     -     -
% FUNCTION 2b ====CalculateDistances====
%             INPUTS    eq, front, Type_of_SP, GrainFull
%             OUTPUTS   frontvector
%             COMMENTS
%                  (1) Called inside function 2
%                  (2) Calls no other functions
%             ALGORITHM
%             PSEUDO CODE

%--------------------------------
% \-FLAG VARIABLES-\

%     -     -     -     -     -     -
% FLAG 2 ====GrainFull====    0, 1
%           This identifies whether the growing front has completely reached the physical grain boundary
%               0: Front can grow
%               1: Front has covered the entire grain
%--------------------------------
% \-ITERATORS-\
% ITERATOR 1 ====q==== 1 to Q
%     -     -     -     -     -     -
% ITERATOR 2 ====q==== 1 to Q
%--------------------------------
% STEP n + 00 : Select the monte carlo step
% STEP n + 01 : ====LOOP_1====: Loop over all q in 1 to Q
% STEP n + 02 : Initialize front_stat, front_dyna to null matrices
% STEP n + 03 : ====LOOP_2   in LOOP_1====: Start an infinite for loop with (grain = 1:Inf)
% STEP n + 04 : ====LOOP_3   in LOOP_2====: Start aN infinite for loop with (FR = 1:Inf)
                                            % (1) Picks a random point
                                            % (2) Grow a front from this point till it cant grow anymore
% STEP n + 05 : ====LOOP_4   in LOOP_3====: Distance operations on front
% STEP n + 06 : ====LOOP_5   in LOOP_3====: % (1) Build front_dyna
                                            % (2) Chop  lsq_dyna
%--------------------------------

%--------------------------------



% STEP n + 00 : Select the monte carlo step
%--------------------------------
% STEP n + 01 : ====LOOP_1====: Loop over all q in 1 to Q
    % Retrieve xy coordinates
    % Retrieve xy increments
    % Dump element numbers to lsq_stat and lsq_dyna
    % Initialize Grains cell array
    % Initialize grain null matrix
    %--------------------------------
        % STEP n + 02 : Initialize front_stat, front_dyna to null matrices
        %--------------------------------
        % STEP n + 03 : ====LOOP_2====: Start an infinite for loop (grain = 1:Inf)

            %--------------------------------
                % STEP n + 04 : ====LOOP_3====: Start a infinite for loop with FR = 1:Inf
                    % if FR == 1
                        % StartingFront = pick a random lattice site in lsq_dyna;
                        % repickstartingpoint = 0
                    % else
                        % if repickstartingpoint==1; % StartingFront = pick a random lattice site in lsq_dyna;
                        % else; % StartingFront = front_dyna;
                        % end
                    % end
                    
                    % Retrieve xy coordinates of   StartingFront
                    % Dump     StartingFront  to   front_stat and front_dyna
                    % Remove   StartingFront  from lsq_stat   and lsq_dyna
                    %--------------------------------
                        % STEP n + 05 : ====LOOP_4====: Start a for loop with (fr = StartingFront)    
                            % Identify neighbours "NeigFront" of "StartingFront" using distance calculations with "lsp_dyna"
                            % That is, Get all sites which satisfy distance conditions
                        % if neighbours exist, i.e. numel(NeigFront)>0
                            % Extract unique of   all such sites
                            % Dump    these  to   front_dyna
                            % Remove  them   from lsq_dyna                            
                        % elseif neighbours do no exist, i.e. numel(NeigFront)==0
                            % repickstartingpoint = 1
                        % end
                        % Exit LOOP_4
                        %--------------------------------
                        % if neighbours exist, i.e. numel(NeigFront)>0
                        % elseif neighbours do no exist, i.e. numel(NeigFront)==0
                            % repickstartingpoint = 1
                        % end
                        %-------------------------------- End of loop_5
                    
                    %-------------------------------- End of loop_3
             % if numel(lsq_dyna)==0
               % BREAK loop_2
             % end
            %-------------------------------- End of loop_2
    % Back to STEP n + 04
    % if there are no more 
    
    
    
    % Remove rp from lsq_dyna