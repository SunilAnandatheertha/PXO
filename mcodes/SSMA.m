function [varargout] = SSMA(varargin)

% SSMA -- S.MS    S.tiffness   M.atrix    A.ssembly
% [GSM] = SSMA({'fe', '2dtruss'}, {nNodes, nEle}, {exkmig})
%  this function assembles the stiffness matrix
% AUTHOR: SUNIL ANANDATHEERTHA (sunilanandatheertha@gmail.com
% A S S E M B L E      S T I F F N E S S    M A T R I X

switch varargin{1}{1}
    case 'fe'
        switch varargin{1}{2}
            case {'2dtruss'}
               % [GSM] = SSMA({'fe', '2dtruss'}, {nNodes, nEle}, {exkmig})
                nNodes  = varargin{2}{1};
                nEle    = varargin{2}{2};
                exkmig  = varargin{3}{1};
                lscount = varargin{4}{1};
                SCMD('seperator','type02',4,1); 
                disp('ASSEMBLING THE STIFFNESS MATRIX')
                GSM = zeros(nNodes * 2);
                for count = 1:nEle
                    exkmigcount = 5 * count;
                    exk   = exkmig(exkmigcount-3:exkmigcount, size(exkmig,2)-3:size(exkmig,2)); % extended stiffness matrix
                    gdofe = exkmig(exkmigcount-3:exkmigcount,2); % gdof of this element
                    
                    GSM(gdofe(1), gdofe(1))  =  GSM(gdofe(1), gdofe(1))  +  exk(1,1);
                    GSM(gdofe(1), gdofe(2))  =  GSM(gdofe(1), gdofe(2))  +  exk(1,2);
                    GSM(gdofe(1), gdofe(3))  =  GSM(gdofe(1), gdofe(3))  +  exk(1,3);
                    GSM(gdofe(1), gdofe(4))  =  GSM(gdofe(1), gdofe(4))  +  exk(1,4);
                    
                    GSM(gdofe(2), gdofe(1))  =  GSM(gdofe(2), gdofe(1))  +  exk(2,1);
                    GSM(gdofe(2), gdofe(2))  =  GSM(gdofe(2), gdofe(2))  +  exk(2,2);
                    GSM(gdofe(2), gdofe(3))  =  GSM(gdofe(2), gdofe(3))  +  exk(2,3);
                    GSM(gdofe(2), gdofe(4))  =  GSM(gdofe(2), gdofe(4))  +  exk(2,4);
                    
                    GSM(gdofe(3), gdofe(1))  =  GSM(gdofe(3), gdofe(1))  +  exk(3,1);
                    GSM(gdofe(3), gdofe(2))  =  GSM(gdofe(3), gdofe(2))  +  exk(3,2);
                    GSM(gdofe(3), gdofe(3))  =  GSM(gdofe(3), gdofe(3))  +  exk(3,3);
                    GSM(gdofe(3), gdofe(4))  =  GSM(gdofe(3), gdofe(4))  +  exk(3,4);
                    
                    GSM(gdofe(4), gdofe(1))  =  GSM(gdofe(4), gdofe(1))  +  exk(4,1);
                    GSM(gdofe(4), gdofe(2))  =  GSM(gdofe(4), gdofe(2))  +  exk(4,2);
                    GSM(gdofe(4), gdofe(3))  =  GSM(gdofe(4), gdofe(3))  +  exk(4,3);
                    GSM(gdofe(4), gdofe(4))  =  GSM(gdofe(4), gdofe(4))  +  exk(4,4);
                    
                    if count == nEle
%                         SDataVis('gsm',{1, 1}, {GSM, nEle}, {count, lscount})
                    end
                    %temp_PAUSE_exec(0, 0.001)
                end
                varargout{1} = GSM;
            case {'3dtruss'}
            case {'2dtruss.2dtorspring','2t.2ts'}
            case {'3dtruss.3dtorspring','3t.3ts'}
        end
    case 'femd'
end

end