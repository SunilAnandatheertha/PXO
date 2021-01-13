function create_slsp_2d()

global Lattice zenerindices zslsp

numel_e  = numel(Lattice.s__MATLAB_Indices);
wantslsp = Lattice.zener.slsp.want_slsp;

if wantslsp == 1
    zslsp = floor(1 + numel_e*rand(floor(numel_e  * 0.01 * Lattice.zener.slsp.Vol_Frac), 1)); % Element numbers of z1
elseif wantslsp == 0
    zslsp = -1;
end
zenerindices = [zenerindices; zslsp];

end