function [varargout] = AtomicGeometryWarper(varargin)
% THIS FUNCTION WARPS THE GEOMETRY OF THE ATOMIC SYSTEM ACCORDING TO THE DESIRED WARPING FUNCTION
% VERSION - 1.00 STARTED ON 17-01-2014. AUTHOR: SUNIL ANANDATHEERTHA sunilanandatheertha@gmail.com
switch varargin{1} % which geometry to warp
    case 'G1'
        %---------------------------------
        PerturbFactor = 0.200;
        %----------------
        switch varargin{3} % random perturabtion
            case 'xPerturbYes' % random perturbation required along x
                acc   = SPGMC('AGG','basic','acc');
                x     = varargin{5} + acc*rand(size(varargin{5}))*PerturbFactor;
            case 'xPerturbNo'
                x     = varargin{5};
        end
        %----------------
        switch varargin{4}
            case 'yPerturbYes' % random perturbation required along y
                acc   = SPGMC('AGG','basic','acc');
                y     = varargin{6} + acc*rand(size(varargin{6}))*PerturbFactor;
            case 'yPerturbNo'
                y     = varargin{6};
        end
        %----------------
        z             = varargin{7};
        ScaleFactor   = varargin{8}; % positive number. greater this is, smaller the perturbation
        %---------------------------------
        switch varargin{2} % which warping function to use
            case 'trig01'
                % HERE WARPING FUNCTION IS {sin(x)}
                if ScaleFactor == 999.999 % THIS 999.999 IS RESERVED
                    z = z + sin(x)/max(max(x));
                else
                    z = z + sin(x)/ScaleFactor;
                end
                %---------------------------------
            case 'trig02'
                % HERE WARPING FUNCTION IS {sin(Y)}
                if ScaleFactor == 999.999 % THIS 999.999 IS RESERVED
                    z = z + sin(y)/max(max(y));
                else
                    z = z + sin(y)/ScaleFactor;
                end
                %---------------------------------
            case 'trig03'
                % HERE WARPING FUNCTION IS {sin(x) + cos(x)}
                if ScaleFactor == 999.999 % THIS 999.999 IS RESERVED
                    z = z + (x.*sin(x) + y.*cos(y))/(0.5*(max(max(x))+max(max(y))));
                else
                    z = z + (x.*sin(x) + y.*cos(y))/ScaleFactor;
                end
                %---------------------------------
            case 'trig04'
                % HERE WARPING FUNCTION IS {sin(x) - cos(x)}
                if ScaleFactor == 999.999 % THIS 999.999 IS RESERVED
                    z = z + (x.*sin(x) - y.*cos(y))/(0.5*(max(max(x))+max(max(y))));
                else
                    z = z + (x.*sin(x) - y.*cos(y))/ScaleFactor;
                end
                %---------------------------------
            case 'trig05'
                % HERE WARPING FUNCTION IS {sin(x) - cos(x)}
                if ScaleFactor == 999.999 % THIS 999.999 IS RESERVED
                    z = z + (x.*sin(x) - y.*cos(y))/(0.5*(max(max(x))+max(max(y))));
                else
                    z = z + (x.*sin(x) - y.*cos(y))/ScaleFactor;
                end
                %---------------------------------
        end
        
        
        %-----------------------------------------
        %-----------------------------------------
        %plot3(x,y,z,'k.'), axis equal, box on
        %-----------------------------------------
        %-----------------------------------------
        
        
        
        % UPDATE CO-ORDINATES IN BOND INFORMATION MATRICES;
        cov_gra = varargin{9};
        vd1_gra = varargin{10};
        vd2_gra = varargin{11};
        cov_gra(:,3:6) = [x(cov_gra(:,1)) y(cov_gra(:,1)) x(cov_gra(:,2)) y(cov_gra(:,2))];
        vd1_gra(:,3:6) = [x(vd1_gra(:,1)) y(vd1_gra(:,1)) x(vd1_gra(:,2)) y(vd1_gra(:,2))];
        vd2_gra(:,3:6) = [x(vd2_gra(:,1)) y(vd2_gra(:,1)) x(vd2_gra(:,2)) y(vd2_gra(:,2))];
        % GRAB RESULTS TO VARARGOUT:
        varargout{1} = x;
        varargout{2} = y;
        varargout{3} = z;
        varargout{4} = [cov_gra(:,1:2) x(cov_gra(:,1)) y(cov_gra(:,1)) z(cov_gra(:,1)) x(cov_gra(:,2)) y(cov_gra(:,2)) z(cov_gra(:,2))];
        varargout{5} = [vd1_gra(:,1:2) x(vd1_gra(:,1)) y(vd1_gra(:,1)) z(vd1_gra(:,1)) x(vd1_gra(:,2)) y(vd1_gra(:,2)) z(vd1_gra(:,2))];
        varargout{6} = [vd2_gra(:,1:2) x(vd2_gra(:,1)) y(vd2_gra(:,1)) z(vd2_gra(:,1)) x(vd2_gra(:,2)) y(vd2_gra(:,2)) z(vd2_gra(:,2))];
    case 'Gn'
end

end