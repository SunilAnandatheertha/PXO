function Build__CTF__ARTIFICIAL(phi1, psi, phi2, PHASEMATRIX, CTF_FILENAME)
% CTF_FILENAME
%------------------------------------------------------------------------------------------------------------
global Lattice EBSD_LIKE_DATA
%------------------------------------------------------------------------------------------------------------
x                = Lattice.size.x;
y                = Lattice.size.y;
x                = x - min(min(x));
y                = y - min(min(y));
xincr            = Lattice.size.i_incr;
yincr            = Lattice.size.j_incr;
LatticeSize      = size(x);
NumLatticeSites  = numel(x);
%------------------------------------------------------------------------------------------------------------
Ctf_Build.line01 = 'Channel Text File';
Ctf_Build.line02 = 'Prj	Project 1';
Ctf_Build.line03 = 'Author	';
Ctf_Build.line04 = 'JobMode	Grid';
Ctf_Build.line05 = ['XCells	' num2str(LatticeSize(1))];
Ctf_Build.line06 = ['YCells	' num2str(LatticeSize(2))];
Ctf_Build.line07 = ['XStep	' num2str(xincr)];
Ctf_Build.line08 = ['YStep	' num2str(yincr)];
Ctf_Build.line09 = 'AcqE1	90.0000';
Ctf_Build.line10 = 'AcqE2	90.0000';
Ctf_Build.line11 = 'AcqE3	-90.0000';

hasvoids = 0;

Ctf_Build.line12 = 'Euler angles refer to Sample Coordinate system (CS0)!	Mag	100.0000	Coverage	74	Device	0	KV	20.0000	TiltAngle	70.0000	TiltAxis	0	DetectorOrientationE1	358.7268	DetectorOrientationE2	92.6504	DetectorOrientationE3	358.2069	WorkingDistance	10.6012	InsertionDistance	202.8906';
if hasvoids == 1
    Ctf_Build.line13a = 'Phases	3';
else
    Ctf_Build.line13a = 'Phases	2';
end
Ctf_Build.line14a = '4.050;4.050;4.050	90.000;90.000;90.000	Aluminium	11	225			Cryogenics18,54-55';
Ctf_Build.line14b = '2.000;2.000;2.000	90.000;90.000;90.000	PARTICLES	11	225			Cryogenics18,54-55';
if hasvoids == 1
    Ctf_Build.line14c = '1.000;1.000;1.000	90.000;90.000;90.000	HOLEVOIDS	11	225			Cryogenics18,54-55';
end
Ctf_Build.line15 = 'Phase	X	Y	Bands	Error	Euler1	Euler2	Euler3	MAD	BC	BS';
%------------------------------------------------------------------------------------------------------------
%------------------------------------------------------------------------------------------------------------
Phase1 = reshape(PHASEMATRIX, NumLatticeSites, 1)
x1     = reshape(x', NumLatticeSites, 1);
y1     = reshape(y', NumLatticeSites, 1);
Bands1 = reshape(05 + randi(5, LatticeSize), NumLatticeSites, 1);
Error1 = reshape(00 + randi(3, LatticeSize), NumLatticeSites, 1);
phi1_1 = reshape(phi1, NumLatticeSites, 1);
psi_1  = reshape(psi , NumLatticeSites, 1);
phi2_1 = reshape(phi2, NumLatticeSites, 1);
MAD_1  = reshape(rand(LatticeSize), NumLatticeSites, 1);
BC_1   = reshape(60 + randi(30, LatticeSize), NumLatticeSites, 1);
BS_1   = reshape(60 + randi(30, LatticeSize), NumLatticeSites, 1);
%1111111111111111111111111111111111111111111111111111111111111111111111
%1111111111111111111111111111111111111111111111111111111111111111111111
% THESE CONTAIN CODES TO INTRODUCE:
% (1). Voids in the grain structure
% (2). Crack in the grain structure with major configurations

% PSEUDO CODE TO INTRODUCE VOIDS IN THE GRAIN STRUCTURE:
% a. Obtain x, y and associated parameters as a column matrix.
% b. Then find the indices of x and y elemenbts which are inside all the voids
% c. Remove elements with these indices from x, y and all associated
% parameter columm matrices.

% PSEUDO CODE TO INTRODUCE CRACKS IN THE GRAIN STRUCTURE:
% a. Obtain x, y and associated parameters as a column matrix.
% b. Then find the indices of x and y elements which are a part of the
% crack's negative volume
% c. emove elements with these indices from x, y and all associated
% parameter columm matrices.

INTRODUCE_GS_DEFECTS_FLAG = 'Void_type_01';
switch INTRODUCE_GS_DEFECTS_FLAG
    case 'Void_type_01'
        % identify the limits of the domain.
        xmin = min(min(x1));
        xmax = max(max(x1));
        ymin = min(min(y1));
        ymax = max(max(y1));
        % make a  simple circle at the centre with a 0.2 x min(xmax-xmin,
        % ymax-ymin) diameter
        void_cent_x      = (xmax + xmin)/2; void_cent_y = (ymax + ymin)/2;
        void_radius      = 0.2 * min(xmax-xmin, ymax-ymin);
        angles           = 0:1:360;
        void_perimeter_x = void_cent_x + void_radius*cosd(angles);
        void_perimeter_y = void_cent_y + void_radius*sind(angles);
        
        [invoid, ~] = inpolygon(x1, y1, void_perimeter_x, void_perimeter_y)
        
    case 'Void_type_02'
    case 'Crack_type_01'
    case 'Crack_type_02'
end
%1111111111111111111111111111111111111111111111111111111111111111111111
%1111111111111111111111111111111111111111111111111111111111111111111111
if hasvoids == 1
    Phase1(invoid) = 3;
end
Phase1
% x2     = x1(~invoid);
% y2     = y1(~invoid);
% figure
% plot(x2, y2, 'k.')
% Bands2 = Bands1(~invoid);
% Error2 = Error1(~invoid);
% phi1_2 = phi1_1(~invoid);
% psi_2  = psi_1(~invoid);
% phi2_2 = phi2_1(~invoid);
% MAD_2 = MAD_1(~invoid);
% BC_2   = BC_1(~invoid);
% BS_2   = BS_1(~invoid);

% REMOVING THE LOCATIONS DOES NOT SEEM TO WORK IN MTEX. SO VOIDS ARE
% TREATED AS A NEW PHASE. With this, no other change is needed

% USE VARIABLE numbers 3 to 9 for other operations as may be necessary
Phase10 = Phase1;
x10     = x1;
y10     = y1;
Bands10 = Bands1;
Error10 = Error1;
phi1_10 = phi1_1;
psi_10  = psi_1;
phi2_10 = phi2_1;
MAD_10  = MAD_1;
BC_10   = BC_1;
BS_10   = BS_1;

% 2222222222222222222222222222222222222222222222222222222222222222222
%------------------------------------------------------------------------------------------------------------
% Convention in ctf file is different. Therefore, POLY-XTAL generated data is altered to suit ctf
% Hence the transpose.


rset = 1;
EBSD_LIKE_DATA.Phase = Phase10;
EBSD_LIKE_DATA.X     = x10;
EBSD_LIKE_DATA.Y     = y10;
EBSD_LIKE_DATA.Bands = Bands10;
EBSD_LIKE_DATA.Error = Error10;
EBSD_LIKE_DATA.phi1  = phi1_10;
EBSD_LIKE_DATA.psi   = psi_10;
EBSD_LIKE_DATA.phi2  = phi2_10;
EBSD_LIKE_DATA.MAD   = MAD_10;
EBSD_LIKE_DATA.BC    = BC_10;
EBSD_LIKE_DATA.BS    = BS_10;
EBSD_LIKE_DATA__MATRIX = [EBSD_LIKE_DATA.Phase,...
                          EBSD_LIKE_DATA.X,...
                          EBSD_LIKE_DATA.Y,...
                          EBSD_LIKE_DATA.Bands,...
                          EBSD_LIKE_DATA.Error,...
                          EBSD_LIKE_DATA.phi1,...
                          EBSD_LIKE_DATA.psi,...
                          EBSD_LIKE_DATA.phi2,...
                          EBSD_LIKE_DATA.MAD,...
                          EBSD_LIKE_DATA.BC,...
                          EBSD_LIKE_DATA.BS];
%------------------------------------------------------------------------------------------------------------
dlmwrite(CTF_FILENAME, Ctf_Build.line01, 'delimiter','')
dlmwrite(CTF_FILENAME, Ctf_Build.line02, 'delimiter','', '-append')
dlmwrite(CTF_FILENAME, Ctf_Build.line03, 'delimiter','', '-append')
dlmwrite(CTF_FILENAME, Ctf_Build.line04, 'delimiter','', '-append')
dlmwrite(CTF_FILENAME, Ctf_Build.line05, 'delimiter','', '-append')
dlmwrite(CTF_FILENAME, Ctf_Build.line06, 'delimiter','', '-append')
dlmwrite(CTF_FILENAME, Ctf_Build.line07, 'delimiter','', '-append')
dlmwrite(CTF_FILENAME, Ctf_Build.line08, 'delimiter','', '-append')
dlmwrite(CTF_FILENAME, Ctf_Build.line09, 'delimiter','', '-append')
dlmwrite(CTF_FILENAME, Ctf_Build.line10, 'delimiter','', '-append')
dlmwrite(CTF_FILENAME, Ctf_Build.line11, 'delimiter','', '-append')
dlmwrite(CTF_FILENAME, Ctf_Build.line12, 'delimiter','', '-append')
dlmwrite(CTF_FILENAME, Ctf_Build.line13a, 'delimiter','', '-append')
dlmwrite(CTF_FILENAME, Ctf_Build.line14a, 'delimiter','', '-append')
dlmwrite(CTF_FILENAME, Ctf_Build.line14b, 'delimiter','', '-append')
if hasvoids == 1
    dlmwrite(CTF_FILENAME, Ctf_Build.line14c, 'delimiter','', '-append')
end
dlmwrite(CTF_FILENAME, Ctf_Build.line15, 'delimiter','', '-append')
dlmwrite(CTF_FILENAME, EBSD_LIKE_DATA__MATRIX, 'delimiter',' ', '-append')
%------------------------------------------------------------------------------------------------------------
end