function [varargout] = SFUIM(varargin)

% SFUIM -- Sms Feam Update Important Matrices



switch varargin{1}{1}
    case 'Update.U.With.DISPLACEMENTS'
        % WRITE DISPLACEMENT VALUES INTO ----->>>>  " U "
        U             = varargin{3}{1};
        DISPLACEMENTS = varargin{3}{2};
        
        NaN_inU = find(isnan(U)==1);
        for count = 1:numel(NaN_inU)    
            U(NaN_inU(count,1)) = DISPLACEMENTS(count);
        end                                            
        varargout{1} = U;
    case 'Update.EleCon.With.NewCoord'
%         [econAnew] = SFUIM('Update.EleCon.With.NewCoord',...
%             {'', ''},...
%             {econA, NNNCMnew});
        econA    = varargin{3}{1};
        NNNCMnew = varargin{3}{2};
        SCMD('seperator','type02',4,1);
        disp('UPDATING ELEMENT CONNECTIVITY INFORMATION')
        econAnew = zeros(size(econA));
        econAnew(:,1:2) = econA(:,1:2);
%         NdNum = NNNCMnew(:,1); % node numbers
        for count = 1:size(econAnew,1)
            econAnew(count,3) = NNNCMnew(NNNCMnew(econAnew(count,1)),2); % x-co-ordinate node i
            econAnew(count,4) = NNNCMnew(NNNCMnew(econAnew(count,1)),3); % y-co-ordinate node i
            econAnew(count,5) = NNNCMnew(NNNCMnew(econAnew(count,1)),4); % z-co-ordinate node i
            econAnew(count,6) = NNNCMnew(NNNCMnew(econAnew(count,2)),2); % x-co-ordinate node j
            econAnew(count,7) = NNNCMnew(NNNCMnew(econAnew(count,2)),3); % y-co-ordinate node j
            econAnew(count,8) = NNNCMnew(NNNCMnew(econAnew(count,2)),4); % z-co-ordinate node j
        end
        econAnew(:,9) = econA(:,9);
        varargout{1} = econAnew;
        temp_PAUSE_exec(0, 0.025)
end

end