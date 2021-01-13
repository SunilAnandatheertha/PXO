function [xsgs, ysgs, cov_gra, vd1_gra, vd2_gra, Width, Length] = AGG_SingleGrapheneSheet(m, n, l, vdd)

% Inputs:
    %  m: first chiral index
    %  n: second chiral index
    %  l: length of graphene sheet
    %  vdd: vacancy defect density. Units: number of vacancy defects per nanometer square of area: nm^-2

% Outputs:
    %  xsgs: x-coordinate of single graphene sheet
    %  ysgs: y-coordinate of single graphene sheet
    %  cov_gra: covalent elements of the current graphene sheet
    %  vd1_gra: Van-der Walls Type-1 elements of the current graphene sheet
    %  vd2_gra: Van-der Walls Type-1 elements of the current graphene sheet
    
% SAMPLE FUNCTION STATEMENTS:
    % (m,n) = (6,0),    length = 2 units,    VDD = 0.0 nm^-2
        % [xsgs,ysgs,cov_gra,vd1_gra,vd2_gra] = gswgraphene(6,0,2,0.0);
    % (m,n) = (6,0),    length = 2 units,    VDD = 0.4 nm^-2
        % [xsgs,ysgs,cov_gra,vd1_gra,vd2_gra] = gswgraphene(6,0,2,0.4);
    % (m,n) = (6,0),    length = 2 units,    VDD = 3.0 nm^-2
        % [xsgs,ysgs,cov_gra,vd1_gra,vd2_gra] = gswgraphene(6,0,2,3.0);

set(0,'DefaultFigureWindowStyle','docked')
close all
acc = 0.1421; % in nanometers (nm)



if n == 0 % Zigzag carbon nanotube
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % GENERATING UNIT CELL DIMENSIONS
    xu1 = zeros(1,2*m+1); % xu1 -- x-cordinate of unit cell - 1st row
    yu1 = zeros(1,2*m+1); % yu1 -- y-cordinate of unit cell - 1st row
    for mcount = 2:2*m+1
        xu1(1,mcount) = xu1(1,mcount-1) + acc*cosd(30);
        if mod(mcount,2) == 0
            yu1(1,mcount) = -acc*sind(30);
        end
    end
    xu2 = zeros(1,2*m+1); % xu2 -- x-cordinate of unit cell - 2nd row
    yu2 = zeros(1,2*m+1); % yu2 -- y-cordinate of unit cell - 2nd row
    for mcount = 1:2*m+1
        xu2 = xu1;
        if mod(mcount,2) == 0
            yu2(1,mcount) = acc + acc*sind(30);
        else
            yu2(1,mcount) = acc;
        end
    end
    HeightOfOneUnitCell = 3*acc;
    ucopies = floor(l / HeightOfOneUnitCell); % estimate the number of unit-cell copies needed to achieve length l (nm)
    xu = [xu1; xu2]; % assemble the 1st and 2nd row of unit cell co-ordinates
    yu = [yu1; yu2];
    % initialize x - and y - coordinates of the current graphene sheet (next two lines:)
    xsgs = zeros(2*ucopies, numel(xu1)); % xsgs - `x' of Single Graphene Sheet
    ysgs = zeros(2*ucopies, numel(xu1)); % ysgs - `y' of Single Graphene Sheet
    for copies = 1:ucopies
        xsgs(2*copies-1:2*copies,:) = xu;
        ysgs(2*copies-1:2*copies,:) = ( (copies-1)*3 )*acc + yu;
    end
    % Estimation of total number of vacacny defect sites in the current graphene sheet (next 2 lines:)
    GrapheneSheetArea = (max(max(xsgs))-min(min(xsgs))) * (max(max(ysgs))-min(min(ysgs))); % nm^2
    nov = floor(vdd*GrapheneSheetArea); % nov -- Number Of Vacancies
    vacancysites = zeros(1,nov);
    % calculate random 'nov' number of vacancies in the current graphene sheet
    for vcount = 1:nov
        vacancysites(vcount) = floor(1+rand*numel(xsgs));
    end
    xsgs(vacancysites) = NaN; % make an indication that these sites belong to vacancy defect
    ysgs(vacancysites) = NaN;
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % FORMATION OF FINITE ELEMENTS:1.COVALENT ELEMENTS,2.VAN-DER-WALL 1 
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % IDENTIFY FINITE ELEMENTS FOR COVALENT BOND
    covalent = zeros(numel(xsgs),6); % a rough estimate of number of cov. ele. and then initialze VAR:'covalent'
    countcovalent = 0; % Intialize counter
    for ct1 = 1:numel(xsgs)
        if isnan(xsgs(ct1)) ~= 1 % Count only those lattice sites which do not belong to a V.D
            for ct2 = 1:numel(xsgs)
                if ct1 ~= ct2 % don't consider the same site twice
                    if isnan(xsgs(ct2)) ~= 1 % Count only those lattice sites which do not belong to a V.D
                        % estimate the cart.dist. b/w lat sites 'ct1' and 'ct2':Next Line
                        dist = sqrt( (xsgs(ct1)-xsgs(ct2))^2 + (ysgs(ct1)-ysgs(ct2))^2 );
                        if dist > 0.95*acc && dist < 1.05*acc % Criterion for being a cov element
                            countcovalent = countcovalent + 1;
                            % append covalent with an entry described in the next line between quotes:
                            % "[ithLatticeSite jthLatticeSite xsgs(ithLatticeSite) ysgs(ithLatticeSite) xsgs(jthLatticeSite) ysgs(jthLatticeSite)]"
                            covalent(countcovalent,:) = [ct1 ct2 xsgs(ct1) ysgs(ct1) xsgs(ct2) ysgs(ct2)];
                        end
                    end
                end
            end
        end
    end % at this point the covalent elements are identified
    % Next repetitions of the elements in covalene(:,:) are identified and removed
    exclude = zeros(size(covalent,1),1); % initialize list of row entries in "covalent" matrix to exclude
    for ct1 = 1:size(covalent,1)
        a = covalent(ct1,1:2); % extract only 1st and 2nd entries of the ct1'st row of covalent
        for ct2 = ct1+1:size(covalent,1) % ct2 = a row ahead of ct1 till the last row of covalent
            if ct1 ~= ct2
                b = [covalent(ct2,2) covalent(ct2,1)]; % extract b matrix
                if a(1)==b(1) && a(2)==b(2) % compare b matrix against a matrix for equality of elements
                    exclude(ct2) = ct2; % populate exlude() with ct2
                end
            end
        end
    end
    exclude(exclude==0)=[]; % remove zeros in exlude
    covalent(exclude,:)=[]; % perform excluding operation. now there will be no repititions of covalent elements/bonds
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % IDENTIFY FINITE ELEMENTS FOR VAN-DER WALLS BOND OF TYPE 1
    vanderwall1 = zeros(numel(xsgs),6);
    countvanderwall1 = 0;
    for ct1 = 1:numel(xsgs)
        if isnan(xsgs(ct1)) ~= 1
            for ct2 = 1:numel(xsgs)
                if ct1 ~= ct2
                    if isnan(xsgs(ct2)) ~= 1
                        dist = sqrt( (xsgs(ct1)-xsgs(ct2))^2 + (ysgs(ct1)-ysgs(ct2))^2 );
                        if dist > 0.95*sqrt(3)*acc && dist < 1.05*sqrt(3)*acc
                            countvanderwall1 = countvanderwall1 + 1;
                            vanderwall1(countvanderwall1,:) = [ct1 ct2 xsgs(ct1) ysgs(ct1) xsgs(ct2) ysgs(ct2)];
                        end
                    end
                end
            end
        end
    end
    exclude = zeros(size(vanderwall1,1),1);
    for ct1 = 1:size(vanderwall1,1)
        a = vanderwall1(ct1,1:2);
        for ct2 = ct1+1:size(vanderwall1,1)
            if ct1 ~= ct2
                b = [vanderwall1(ct2,2) vanderwall1(ct2,1)];
                if a(1)==b(1) && a(2)==b(2)
                    exclude(ct2) = ct2;
                end
            end
        end
    end
    exclude(exclude==0)=[];
    vanderwall1(exclude,:)=[];
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % IDENTIFY FINITE ELEMENTS FOR VAN-DER WALLS BOND OF TYPE 2
    vanderwall2 = zeros(numel(xsgs),6);
    countvanderwall2 = 0;
    for ct1 = 1:numel(xsgs)
        if isnan(xsgs(ct1)) ~= 1
            for ct2 = 1:numel(xsgs)
                if ct1 ~= ct2
                    if isnan(xsgs(ct2)) ~= 1
                        dist = sqrt( (xsgs(ct1)-xsgs(ct2))^2 + (ysgs(ct1)-ysgs(ct2))^2 );
                        if dist > 0.95*2*acc && dist < 1.05*2*acc
                            countvanderwall2 = countvanderwall2 + 1;
                            vanderwall2(countvanderwall2,:) = [ct1 ct2 xsgs(ct1) ysgs(ct1) xsgs(ct2) ysgs(ct2)];
                        end
                    end
                end
            end
        end
    end
    exclude = zeros(size(vanderwall2,1),1);
    for ct1 = 1:size(vanderwall2,1)
        a = vanderwall2(ct1,1:2);
        for ct2 = ct1+1:size(vanderwall2,1)
            if ct1 ~= ct2
                b = [vanderwall2(ct2,2) vanderwall2(ct2,1)];
                if a(1)==b(1) && a(2)==b(2)
                    exclude(ct2) = ct2;
                end
            end
        end
    end
    exclude(exclude==0)=[];
    vanderwall2(exclude,:)=[];
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    PlotIndividualSheets = 0;
    if PlotIndividualSheets == 1
        figure(1)
        hold on
        for ct1 = 1:size(covalent,1)
            plot([covalent(ct1,3) covalent(ct1,5)],...
                [covalent(ct1,4) covalent(ct1,6)],...
                'k','LineWidth',3)
            %pause(0.001)
        end
        for ct1 = 1:size(vanderwall1,1)
            plot([vanderwall1(ct1,3) vanderwall1(ct1,5)],...
                [vanderwall1(ct1,4) vanderwall1(ct1,6)],...
                'k--','LineWidth',1)
            %pause(0.001)
        end
        for ct1 = 1:size(vanderwall2,1)
            plot([vanderwall2(ct1,3) vanderwall2(ct1,5)],...
                [vanderwall2(ct1,4) vanderwall2(ct1,6)],...
                'k:','LineWidth',1)
            %pause(0.002)
        end
        axis equal,    axis tight
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
elseif n == m % Armchair carbon nanotube
end

cov_gra = covalent; % Data of covalent bonds in the graphene sheet
vd1_gra = vanderwall1;
vd2_gra = vanderwall2;

if PlotIndividualSheets == 1
    print('-deps',strcat(pwd,'\GrapheneSheet',num2str(max(max(xsgs))),'nm',...
        'X',num2str(max(max(ysgs))),'nm','vdd',num2str(vdd),'.eps'))
end

Width  = (0-min(min(xsgs)))+(0+max(max(xsgs)));
Length = (0-min(min(ysgs)))+(0+max(max(ysgs)));

end