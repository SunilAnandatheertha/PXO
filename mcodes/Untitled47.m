%   simple matlab script to simulate the order - disorder transition
%   in a non-equilibrium 2 phase material
%   
%   based on Ken Elder's 1993 paper:
%   "Langevin simulations of nonequilibrium phenomena"
%   Computers In Physics, vol. 7, no. 1, 1993, p.27-33
% 
%   A double well free energy curve is defined
%   and composition fluctuations arise from thermal
%   noise which evolves the microstructure into domains of ordered
%   and disordered phases
%
%   The free energy has the form 
%       f = 1/2*r*phi^2 + 1/4*w*phi^4  (bulk energy term)
%       h = 1/2*k*abs(grad(phi^2))     (surface energy term)
%
%   see the paper for more details and additional 
%   problems suggested for further study
%
% just hit F5
%
% adam pilchak, adam.pilchak@gmail.com
%
% define the system size
ni = 128; % number of x pixels
nj = 128; % number of y pixels
nt = 300; % number of time steps
% parameters
kbT = 0.010; % temperature
cm = 1.0; % cm, ck, cw are phenomenological constants
ck = 1;   
cw = 1;
cr = -1;
eta = 0;  
dtt = 0.05; % time step
delta = 1.3; % grid size
% create a 2d square lattice
Fai = zeros(ni,nj);
% you can either seed the lattice by setting some values Fai(i,j) = 1,
% or comment the following out in order to allow random fluctuations 
% to control the evolution
% if uncommented, this 'seed' creates a spherical particle of radius R 
% centered at (ni/2,nj/2);
%
%
% R = 15;
%
%  make that particle!
% for i = 1:ni
%    for j = 1:nj
%        test = (i-ni/2)^2 + (j-nj/2)^2;
%        if test < R^2
%            Fai(i,j)=1;
%        end
%    end
% end
% show the initial microstructure
figure(1)
image(Fai*50)
colormap('bone')
 
% set periodic boundary conditions
Fai(1,:) = Fai(ni-1,:);
Fai(:,1) = Fai(:,ni-1);
Fai(:,2) = Fai(ni-1,:);
Fai(2,:) = Fai(:,ni-1);
% pre allocate space
NFai = zeros(ni,nj);
for t = 1:nt
    for i = 2:ni-1
        for j = 2:nj-1
            
            ranr1 = rand();
            ranr2 = rand();
             
            eta = -2*log(ranr1)*sin(2*pi*ranr2)*cos(2*pi*ranr2)*sqrt(2*kbT*cm/dtt)/delta;
            
            NFai(i,j) = Fai(i,j) + dtt*(-cm*(cr*Fai(i,j) + cw * (Fai(i,j)*Fai(i,j)*Fai(i,j)))...
            + eta + (cm*ck)/delta^2 * (Fai(i+1,j) + Fai(i-1,j) + Fai(i,j+1) + Fai(i,j-1)...
            - 4 * Fai(i,j)));
        end
    end
    
for i = 2:ni-1
    for j = 2:nj-1
        Fai(i,j)=NFai(i,j);
    end
end
% reapply the boundary conditions
Fai(1,:) = Fai(ni-1,:);
Fai(:,1) = Fai(:,ni-1);
Fai(:,2) = Fai(ni-1,:);
Fai(2,:) = Fai(:,ni-1);
% watch the microstructure evolve
figure(2)
image(Fai*50)
colormap('bone')
end
disp('done')