function SRV(varargin)
%///////////////////////////////////////////////////////////
%///////////////////////////////////////////////////////////
% SRV :::: S M S    R e s u l t    V i s u a l i z a t i o n
% AUTHOR::SUNIL ANANDATHEERTHA
%         sunilanandatheertha@gmail.com
%         https://sites.google.com/site/saraswatimechsolver/
%///////////////////////////////////////////////////////////
%///////////////////////////////////////////////////////////
% VERSION :: 1.00 :: START - 10-01-2014
%///////////////////////////////////////////////////////////
%///////////////////////////////////////////////////////////
AC = 0;                                     % ARGUMENT COUNT
switch varargin{1}
    %///////////////////////////////////////////////////////
    %///////////////////////////////////////////////////////
%0000%0000% SRV(varargin{1})
    case 'ag' % For Atomic Geometry
        AC = AC + 1; % here, AC becomes 1
        switch varargin{2}
            case 's' % s -- static
                AC = AC + 1; % here, AC becomes 2
                switch varargin{3}
                    case 'g1'
                        disp('==========================')
                        % function inputs for fn:GRX_PlotSingleGrapheneSheet(..), in this \\\\case:'g1'////
                            % varargin{1} of SRV(..) -- THIS IS NOT TAKEN INSIDE fn:GRX_PlotSingleGrapheneSheet(..)
                            % varargin{2} of SRV(..) -- 's'. To know whether being used...
                            %                                in static situation or dynamic situation.
                            % varargin{3} of SRV(..) -- cov_gra_appended
                            % varargin{4} of SRV(..) -- vd1_gra_appended
                            % varargin{5} of SRV(..) -- vd2_gra_appended
                            % varargin{6} of SRV(..) -- 'CovYes' or 'CovNo'
                            % varargin{7} of SRV(..) -- 'Vd1Yes' or 'Vd1No'
                            % varargin{8} of SRV(..) -- 'Vd2Yes' or 'Vd2No'
                            % varargin{9} of SRV(..) -- 'AtomYes' or 'AtomNo'
                            StaticOrDynamic  = varargin{2};
                            %                  varargin{3} is not used for GRX_PlotSingleGrapheneSheet
                            cov_gra_appended = varargin{4};
                            vd1_gra_appended = varargin{5};
                            vd2_gra_appended = varargin{6};
                            PlotCovYesNo     = varargin{7};
                            PlotVd1YesNo     = varargin{8};
                            PlotVd2YesNo     = varargin{9};
                            PlotAtomYesNo    = varargin{10};
                            GRX_PlotSingleGrapheneSheet(StaticOrDynamic,  cov_gra_appended, vd1_gra_appended,...
                                                        vd2_gra_appended, PlotCovYesNo,     PlotVd1YesNo,...
                                                        PlotVd2YesNo,     PlotAtomYesNo);
                    case 'gn'
                        AC = AC + 1; % here, AC becomes 3. This AC is x in varargin{x}, at the current level.
                        x = (AC+1):1:20; % Last number is arbitrarily > than No of IP in called function.
                        GRX_PlotGrapheneStack(varargin{x(01)}, varargin{x(02)}, varargin{x(03)}, varargin{x(04)},...
                                              varargin{x(05)}, varargin{x(06)}, varargin{x(07)}, varargin{x(08)},...
                                              varargin{x(09)}, varargin{x(10)}, varargin{x(11)}, varargin{x(12)},...
                                              varargin{x(13)}, varargin{x(14)}, varargin{x(15)});
                    case 'c1'
                    case 'cn'
                end
            case 'd' % d -- dynamic
        end
    %//////////////////////////////////////////////////////
    %//////////////////////////////////////////////////////
    case 'mc2' % for 2-dimensional sms monte-carlo simulation
        switch varargin{2} % <---<< decides which plot is necessary : ms or hamiltonian, etc.
        %0000%0000% SRV('mc2', varargin{2})
            case 'm' % for Microstructure plot
                switch varargin{3}
                %0000%0000% SRV('mc2', 'm', varargin{3})
                    case 's' % for static microstructure plot
                        switch varargin{4}
                         %0000%0000% SRV('mc2', 'm', 's', varargin{4})
                            case '11' % colorplot = 1 and grainboundarylineplot = 1
                            case '01' % colorplot = 0 and grainboundarylineplot = 1
                            case '10' % colorplot = 1 and grainboundarylineplot = 0
                        end
                    case 'd' % for dynamic microstructure plot
                        switch varargin{4}
                        %0000%0000% SRV('mc2', 'm', 'd', varargin{4})
                            case '11' % colorplot = 1 and grainboundarylineplot = 1
                            case '01' % colorplot = 0 and grainboundarylineplot = 1
                            case '10' % colorplot = 1 and grainboundarylineplot = 0
                        end
                end
            case 'g' % for Graph
                switch varargin{3}
                    case '0100' % ham vs. mc sim time
                    case '0210' % ags vs. mc sim time
                    case '0220' % ags vs. 2nd ph vol frac
                    case '0230' % unit normalized ags vs. 2nd ph vol frac
                    case '0240' % ags vs. individual cluster volume fraction
                    case '0250' % ags vs. individual cluster radius
                    case '0260' % ags vs. cnt volume fraction
                    case '0270' % ags vs. cnt cluster radius
                end
        end
    %//////////////////////////////////////////////////////
    %//////////////////////////////////////////////////////
    case 'mc3'
    %//////////////////////////////////////////////////////
    %//////////////////////////////////////////////////////
    case 'sfea1'
        switch varargin{2}
            case 'b' % Bar
            case 's' % Spring
        end
    %//////////////////////////////////////////////////////
    %//////////////////////////////////////////////////////
    case 'sfea2'
        switch varargin{3}
            case 'g1' % Single graphene sheet
        end
    %//////////////////////////////////////////////////////
    %//////////////////////////////////////////////////////
    case 'sfea3'
        switch varargin{3}
            case 'g1' % SIngle graphene sheet
            case 'gn' % Stack of graphene sheets
            case 'c1' % Single walled cnt
            case 'cn' % Multi walled cnt
        end
    %//////////////////////////////////////////////////////
    %//////////////////////////////////////////////////////
    case 'smd1' % 1-Dimensional molecular dynamics
    %//////////////////////////////////////////////////////
    %//////////////////////////////////////////////////////
    case 'smd2' % 2-Dimensional molecular dynamics
    %//////////////////////////////////////////////////////
    %//////////////////////////////////////////////////////
    case 'smd3' % 3-Dimensional molecular dynamics
end

end %   <-------<<<   E N D    O F    T H I S     F U N C T I O N