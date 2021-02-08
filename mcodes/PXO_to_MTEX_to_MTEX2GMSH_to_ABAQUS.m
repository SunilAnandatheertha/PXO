


G = gmshGeo(GRAINS);

mesh(G,'default.msh')

mesh(G,'constant_elmtSize.msh','ElementSize',50)

mesh(G,'Quad.msh','ElementType','Quad');

mesh(G,'quad_abaqus.inp','ElementType','Quad');

]