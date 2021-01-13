function [varargout] = SPlotMyGSM(varargin)
% THIS FUNCTION PLOTS THE GLOBAL STIFFNESS MATRIX

GSM = varargin{1}; % Global Stiffness Matrix

% [x, y]  = meshgrid(1:size(GSM,1), (1:size(GSM,2))-size(GSM,1));

x = varargin{2};
y = varargin{3};

NonZero = find(GSM~=0);

figure(222)

fh1 = plot(x(NonZero), y(NonZero), 'b.','MarkerSize',4);

% axis off
box on

axis equal
axis square
axis tight

varargout{1} = fh1;

end