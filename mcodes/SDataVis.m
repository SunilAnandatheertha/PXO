function [varargout] = SDataVis(varargin)

% SDV -- S.MS     DATA     VIS.UALIZER
% AUTHOIR: SUNIL ANANDATHEERTHA (sunilanandatheertha@gmail.com)


% SDataVis('gsm',{0, 0}, {GSM, nEle})

switch varargin{1}
    case {'gsm','sm'}
        PlotGSM    = varargin{2}{1};
        PrintPlots = varargin{2}{2};
        GSM        = varargin{3}{1};
        nEle       = varargin{3}{2};
        count      = varargin{4}{1};
        lscount    = varargin{4}{2};
        
        [x,y]      = meshgrid(1:size(GSM,1), size(GSM,2):-1:1);
        if PlotGSM == 1;
            [fh1] = SPlotMyGSM(GSM, x, y);
            if PrintPlots == 1
                if isdir(strcat(pwd,'\results\sfeam\GSM_plots')) == 0
                    mkdir(strcat(pwd,'\results\sfeam\GSM_plots'))
                end
                print('-djpeg100',strcat(pwd,'\results\sfeam\GSM_plots\GSM_Sparsity_At_EleNum','LS=',num2str(lscount),'.jpeg'))
                if count < nEle
                    delete(fh1);
                end
            end
        end
        close
end

end