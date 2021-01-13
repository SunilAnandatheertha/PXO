function SRV(varargin)

switch varargin{1}
    %///////////////////////////////////////////
    %///////////////////////////////////////////
    case 'agg' % Atomic Geometry Generator
        switch varargin{2}
            case 's' % s -- static
                axis equal
                axis tight
                box on
                xlabel('x-axis (WIDTH), nm')
                ylabel('y-axis (LENGTH), nm')
                zlabel('z-axis (THICKNESS), nm')
                title('Stacked Graphene Sheets')
                view(40,40)
                axesLabelsAlign3D
            case 'd' % d -- dynamic
        end
    %///////////////////////////////////////////
    %///////////////////////////////////////////
    case 'smc2' % for 2-dimensional sms monte-carlo simulation
        switch varargin{2} % <--< decides which plot is necessary : ms or hamiltonian, etc.
            case 'm' % for Microstructure plot
                switch varargin{3}
                    case 's' % for static microstructure plot
                        switch varargin{4}
                            case '11' % colorplot = 1 and grainboundarylineplot = 1
                            case '01' % colorplot = 0 and grainboundarylineplot = 1
                            case '10' % colorplot = 1 and grainboundarylineplot = 0
                        end
                    case 'd' % for dynamic microstructure plot
                        switch varargin{4}
                            case '11' % colorplot = 1 and grainboundarylineplot = 1
                            case '01' % colorplot = 0 and grainboundarylineplot = 1
                            case '10' % colorplot = 1 and grainboundarylineplot = 0
                        end
                end
            case 'g' % for Graph
                switch varargin{3}
                    case '0010' % graph of hamiltonian
                    case '0020' % graph of average grain size vs 
                end
                        
        end
    %///////////////////////////////////////////
    %///////////////////////////////////////////
    case 'smc3'
    %///////////////////////////////////////////
    %///////////////////////////////////////////
    case 'sfea1'
end