function smc2(varargin)
% smc2: SMS Monte Carlo 2d
%-----------------------------------------------------------
if nargin==0
    mcinstance(1, 'postprocessyes');
else
    PostProcessReq = varargin{1};
    NumberOfTrials = varargin{2};
    if strcmp(version,'7.8.0.347 (R2009a)')
        % This is for my computer. may be different for other systems
        RandStream.setDefaultStream(RandStream('mt19937ar','seed',sum(100*clock)));
    elseif strcmp(version,'8.1.0.604 (R2013a)')
        RandStream.setGlobalStream(RandStream('mt19937ar','seed',sum
        for CountTrials = 1:NumberOfTrials
            mcinstance(NumberOfTrials, PostProcessReq);
        end
    end
end
%-----------------------------------------------------------
%-----------------------------------------------------------
%-----------------------------------------------------------
function mcinstance(NumberOfTrials, PostProcessReq)(100*clock)));
end
%-----------------------------------------------------------
[latpar, simpar, slspinfo, icntinfo, clusterinfo, solset, ffo, grapho] = pi2d();
[x, y, s, e, secondaryphaseinfo] = im2d(latpar, simpar, slspinfo, icntinfo, clusterinfo);
%------------------------------
tic
mcs2d(latpar, s, e, simpar, secondaryphaseinfo, ffo);
toc
%-----------------------------------------------------------
if strcmpi(PostProcessReq, 'postprocessyes')
    postprocessPROPERTIES2d();
    grainsize_interceptmethod2d;
    plotgrainstructure2d(1,1,1);
elseif strcmpi(PostProcessReq, 'postprocessno')
    disp('Post processing is not performed')
end
%-----------------------------------------------------------
display('END OF SIMULATION')
end