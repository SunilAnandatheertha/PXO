function create_high_AR_pseudo_1D_particle_chains()
%--------------------------------------------------------------------------------
global Lattice zenerindices zcnt cntxythetainfo cntele
%--------------------------------------------------------------------------------
if Lattice.zener.cnt.want_cnt == 1
    disp('CNTs are being generated')
    %--------------------------------------------------------------------------------
    % [cntxythetainfo] = mcnt2d(latpar,icntinfo); % <---- FUNCTION CALL: TO mcnt2d
    xmin                     = Lattice.size.xmin;
    xmax                     = Lattice.size.xmax;
    ymin                     = Lattice.size.ymin;
    ymax                     = Lattice.size.ymax;
    xincr                    = Lattice.size.i_incr;
    yincr                    = Lattice.size.j_incr;
    noofcnt                  = Lattice.zener.cnt.noofcnt;
    NpCNT                    = Lattice.zener.cnt.NpCNT;
    genradiusfactor          = Lattice.zener.cnt.genradiusfactor;
    cntinsidefactor          = Lattice.zener.cnt.cntinsidefactor;
    thicknessfactor          = Lattice.zener.cnt.thicknessfactor;
    startingangle            = Lattice.zener.cnt.startingangle;
    thetaone                 = Lattice.zener.cnt.thetaone;
    thetatwo                 = Lattice.zener.cnt.thetatwo;
    ROTATEiCNTs              = Lattice.zener.cnt.ROTATEiCNTs;
    rotateallaboutsameangle  = Lattice.zener.cnt.rotateallaboutsameangle;
    icntrotang               = Lattice.zener.cnt.icntrotang;
    
    cntxythetainfo           = cell(8, noofcnt); % cell to store CNT geometry values
    radius                   = genradiusfactor*0.5*sqrt(xincr^2+yincr^2); % distance between points on the CNT
    angle(1)                 = startingangle; % starting angle
    cntele = cell(0);
    %--------------------------------------------------------------------------------
    for cnt = 1:noofcnt
        fprintf('Generating CNT number %d \n',cnt)
        cntxythetainfo{1,cnt} = zeros(NpCNT,2);
        cntxythetainfo{1,cnt}(1,:) = cntinsidefactor*[floor(xmin+(xmax-xmin)*rand) floor(ymin+(ymax-ymin)*rand)];
        sel = floor(1+(numel(thetaone)+1-1)*rand);
        theta1 = thetaone(sel);
        theta2 = thetatwo(sel);
        cntxythetainfo{2,cnt} = [theta1;theta2];
        for count = 2:NpCNT
            mult = rand(1);
            angle(count) = 0.9*rand*angle(count-1) + theta1 +(theta2-theta1)*mult;
            cntxythetainfo{1,cnt}(count,:) = cntxythetainfo{1,cnt}(count-1,:) + radius*[cosd(angle(count)) sind(angle(count))];
        end
    end
    %--------------------------------------------------------------------------------
    % Rotate individual CNTs about their origins
    % <---- TO BE INCLUDED IN icntinfo{:}
    % ABOVE VALUE DEFAULT IS 1. CHANGE TO 0 IF ALIGNED CNTs ARE NEEDED

    if ROTATEiCNTs == 1
        rotateallaboutsameangle = 0;
        if rotateallaboutsameangle==1
            rotang = 45; % <---- INCLUDE THIS IN "icntinfo{:,:}"
        end
        for count = 1:size(cntxythetainfo,2)
            cntxythetainfo{3,count} = 0; % just a seperator
            cntxythetainfo{4,count} = cntxythetainfo{1,count}(1,:); % origin about which rotation is carried out
            % next line establishes the distance of every point in this cnt from the above origin
            cntxythetainfo{5,count} = sqrt(( ones(size(cntxythetainfo{1,1},1),1).*cntxythetainfo{1,count}(1,1) - cntxythetainfo{1,count}(:,1)).^2 +...
                                           ( ones(size(cntxythetainfo{1,1},1),1).*cntxythetainfo{1,count}(1,2) - cntxythetainfo{1,count}(:,2)).^2);
            % start of rotation algorithm
            if rotateallaboutsameangle==0
                rotang = rand*360;
            end
            origin = cntxythetainfo{1,count}(1,:);
            rot = [cosd(rotang) -sind(rotang); sind(rotang)  cosd(rotang)];
            origin = cntxythetainfo{1,count}(1,:);
            xycnt_ori = cntxythetainfo{1,count} - [cntxythetainfo{1,count}(1,1)*ones(size(cntxythetainfo{1,count},1),1) cntxythetainfo{1,count}(1,2)*ones(size(cntxythetainfo{1,count},1),1)];
            for count1 = 2:size(xycnt_ori,1)
                xycnt_ori_trans(count1,:) = rot*xycnt_ori(count1,:)';
            end
            xy_rot = xycnt_ori_trans + [cntxythetainfo{1,count}(1,1)*ones(size(cntxythetainfo{1,count},1),1) cntxythetainfo{1,count}(1,2)*ones(size(cntxythetainfo{1,count},1),1)];
            % end of rotation algorithm
            cntxythetainfo{6,count} = xy_rot;
        end
    else
        for count = 1:size(cntxythetainfo,2)
            cntxythetainfo{6,count} = cntxythetainfo{1,count};
        end
    end
    %--------------------------------------------------------------------------------
    disp('Storing cntele{1:noofcnt} data')
    for numcnt = 1:noofcnt
        xxx = cntxythetainfo{6,numcnt}(:,1);
        yyy = cntxythetainfo{6,numcnt}(:,2);
        truncxmin = find(xxx<xmin);
        truncxmax = find(xxx>xmax);
        truncx = [truncxmin;truncxmin];
        xxx(truncx)=[]; 
        yyy(truncx)=[];
        truncymin = find(yyy<ymin);
        truncymax = find(yyy>ymax);
        truncy = [truncymin;truncymin];
        xxx(truncx)=[];
        yyy(truncx)=[];

        a = xmin:xincr:xmax;
        b = ymin:yincr:ymax;
        [xx,yy] = meshgrid(a,b);

        cntelements1 = [];
        for cntpnts = 1:numel(xxx)
            cpx = xxx(cntpnts)*ones(size(xx));
            cpy = yyy(cntpnts)*ones(size(yy));
            distances = sqrt( (cpx-xx).^2 + (cpy-yy).^2 );
            cntelements = find(distances<=thicknessfactor*sqrt(xincr^2+yincr^2));
            cntelements1 = [cntelements1; cntelements];
        end
        cntele{numcnt}=unique(cntelements1);
    end
    %--------------------------------------------------------------------------------
    for count = 1:numel(cntele) % THIS WHOLE LOOP CAN GO INSIDE the function - 'creatCNTs'
        zcnt = [zcnt; cntele{count}(:)];
    end
    zenerindices = [zenerindices; zcnt];
else
    cntele         = -1;
    zcnt           = -1;
    cntxythetainfo = -1;
    zenerindices = [zenerindices; zcnt];
end
end