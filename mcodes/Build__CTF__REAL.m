function Build__CTF__REAL(EulerAngles_Pixellated)
%------------------------------------------------------------------------------------------------------------
global Lattice EBSD_LIKE_DATA PHASE
%------------------------------------------------------------------------------------------------------------
x                = Lattice.size.x;
y                = Lattice.size.y;
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

Ctf_Build.line12 = 'Euler angles refer to Sample Coordinate system (CS0)!	Mag	100.0000	Coverage	74	Device	0	KV	20.0000	TiltAngle	70.0000	TiltAxis	0	DetectorOrientationE1	358.7268	DetectorOrientationE2	92.6504	DetectorOrientationE3	358.2069	WorkingDistance	10.6012	InsertionDistance	202.8906';
Ctf_Build.line13 = 'Phases	1';
Ctf_Build.line14 = '4.050;4.050;4.050	90.000;90.000;90.000	Aluminium	11	225			Cryogenics18,54-55';
Ctf_Build.line15 = 'Phase	X	Y	Bands	Error	Euler1	Euler2	Euler3	MAD	BC	BS';
%------------------------------------------------------------------------------------------------------------
% Convention in ctf file is different. Therefore, POLY-XTAL generated data is altered to suit ctf
% Hence the transpose.
rset = 1;
EBSD_LIKE_DATA.Phase = reshape(ones(LatticeSize), NumLatticeSites, 1);
EBSD_LIKE_DATA.X     = reshape(x', NumLatticeSites, 1);
EBSD_LIKE_DATA.Y     = reshape(y', NumLatticeSites, 1);
EBSD_LIKE_DATA.Bands = reshape(05 + randi(5, LatticeSize), NumLatticeSites, 1);
EBSD_LIKE_DATA.Error = reshape(00 + randi(3, LatticeSize), NumLatticeSites, 1);
EBSD_LIKE_DATA.phi1  = reshape(EulerAngles_Pixellated.phi1{rset}', NumLatticeSites, 1);
EBSD_LIKE_DATA.psi   = reshape(EulerAngles_Pixellated.psi{rset}' , NumLatticeSites, 1);
EBSD_LIKE_DATA.phi2  = reshape(EulerAngles_Pixellated.phi2{rset}', NumLatticeSites, 1);
EBSD_LIKE_DATA.MAD   = reshape(rand(LatticeSize), NumLatticeSites, 1);
EBSD_LIKE_DATA.BC    = reshape(60 + randi(30, LatticeSize), NumLatticeSites, 1);
EBSD_LIKE_DATA.BS    = reshape(60 + randi(30, LatticeSize), NumLatticeSites, 1);
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
dlmwrite(strcat(pwd, '\CTF_FILE.ctf'), Ctf_Build.line01, 'delimiter','')
dlmwrite(strcat(pwd, '\CTF_FILE.ctf'), Ctf_Build.line02, 'delimiter','', '-append')
dlmwrite(strcat(pwd, '\CTF_FILE.ctf'), Ctf_Build.line03, 'delimiter','', '-append')
dlmwrite(strcat(pwd, '\CTF_FILE.ctf'), Ctf_Build.line04, 'delimiter','', '-append')
dlmwrite(strcat(pwd, '\CTF_FILE.ctf'), Ctf_Build.line05, 'delimiter','', '-append')
dlmwrite(strcat(pwd, '\CTF_FILE.ctf'), Ctf_Build.line06, 'delimiter','', '-append')
dlmwrite(strcat(pwd, '\CTF_FILE.ctf'), Ctf_Build.line07, 'delimiter','', '-append')
dlmwrite(strcat(pwd, '\CTF_FILE.ctf'), Ctf_Build.line08, 'delimiter','', '-append')
dlmwrite(strcat(pwd, '\CTF_FILE.ctf'), Ctf_Build.line09, 'delimiter','', '-append')
dlmwrite(strcat(pwd, '\CTF_FILE.ctf'), Ctf_Build.line10, 'delimiter','', '-append')
dlmwrite(strcat(pwd, '\CTF_FILE.ctf'), Ctf_Build.line11, 'delimiter','', '-append')
dlmwrite(strcat(pwd, '\CTF_FILE.ctf'), Ctf_Build.line12, 'delimiter','', '-append')
dlmwrite(strcat(pwd, '\CTF_FILE.ctf'), Ctf_Build.line13, 'delimiter','', '-append')
dlmwrite(strcat(pwd, '\CTF_FILE.ctf'), Ctf_Build.line14, 'delimiter','', '-append')
dlmwrite(strcat(pwd, '\CTF_FILE.ctf'), Ctf_Build.line15, 'delimiter','', '-append')
dlmwrite(strcat(pwd, '\CTF_FILE.ctf'), EBSD_LIKE_DATA__MATRIX, 'delimiter',' ', '-append')
%------------------------------------------------------------------------------------------------------------
end