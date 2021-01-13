% mtexdata small
EBSDDATA = EBSDDATA('indexed');		% Remove unindexed points
grains = calcGrains(EBSDDATA);	% Compute grains
plot(grains)

G = gmshGeo(grains);

mesh(G,'Tri_MESH.inp' ,'ElementType','Tri')
mesh(G,'Quad_MESH.inp','ElementType','Quad')