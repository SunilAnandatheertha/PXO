function smc3(NumberOfTrials)
% smc2: SMS Monte Carlo 2d
%<><><><><><><><><><><><><><><><><><>
if nargin == 0||nargin == 0 
    NumberOfTrials = 1;
end
for CountTrials = 1:NumberOfTrials
    mcinstance();
end
end
%%
%<><><><><><><><><><><><><><><><><><>
function mcinstance(NumberOfTrials)
%% before starting
clear all
close all
RandStream.setDefaultStream(RandStream('mt19937ar','seed',sum(100*clock)));
makeremovedir3d();
[latpar,simpar,slspinfo,icntinfo,clusterinfo,solset,ffo,grapho] = pi3d();
[x,y,z,s,e,secondaryphaseinfo] = im3d(latpar,simpar,slspinfo,icntinfo,clusterinfo);
tic
mcsolver3d(latpar,s,e,simpar,secondaryphaseinfo,ffo);
toc
% postprocessPROPERTIES2d();
% grainsize_interceptmethod2d;
% plotgrainstructure2d(1,1,1);
display('END OF SIMULATION')
end