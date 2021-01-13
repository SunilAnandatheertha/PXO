function [varargout] = SElemConn(varargin)

% CREATE ELEMENT CONNECTIVITY
% [econ] = SElemConn('ag', '2d', ecov, evd1, evd2); % STEP 04: CREATE ELEMENT CONNECTIVITY
switch varargin{1}
    case {'ag'}
        switch varargin{2}
            case {'2d'}
                IndElConn = varargin{3};
                for count = 1:2:numel(IndElConn)-1
                    switch IndElConn{count}
                        case 'ecov'
                            ecov = IndElConn{count+1};
                            ecov = [ecov ones(size(ecov,1),1)];  % 1, in the end is an identifier for ecov
                        case 'evd1'
                            evd1 = IndElConn{count+1}; % 2, in the end is an identifier for evd1
                            evd1 = [evd1 repmat(2,size(evd1,1),1)];
                        case 'evd2'
                            evd2 = IndElConn{count+1}; % 3, in the end is an identifier for evd2
                            evd2 = [evd2 repmat(3,size(evd2,1),1)];
                    end
                end
                % 'ecov', ecov, 'evd1', evd1, 'evd2', evd2
                econUA = [ecov; evd1; evd2];
                varargout{1} = econUA;
                switch varargin{4}
                    case {'ArrangeByNode','n'}
                        % econUA : econ UnArranged & econA  : econ Arranged
                        [sortednodes, SortFlags] = sort(econUA(:,1),1,'ascend');
                        econA = zeros(size(econUA));
                        econA(:,1) = sortednodes;
                        for count = 1:size(econUA,1)
                            econA(count,2:size(econUA,2)) = econUA(SortFlags(count,1),2:size(econUA,2));
                        end
                        varargout{2} = econA;
                    case {'ByX','x'}
                    case {'ByY','y'}
                end
                % Calculate the Total number of nodes
                temp = [econA(:,1); econA(:,2)];
                Nodes = unique(temp);
                varargout{3} = Nodes; % Totak Number Of Nodes
                disp('FINSHED FORMING ELEMENT CONNECTIVITY')
        end
end

end