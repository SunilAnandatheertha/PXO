function face(varargin)
% THIS FUNCTION MAKES AN FACE ANIMATION
% - SUNIL ANANDATHEERTHA, 07-02-2014

x = 1:100;
y = 1:100;
[X, Y] = meshgrid(x, y);

close all
fh1 = plot(X, Y, 'k.','MarkerSize',2); axis off; axis equal; axis tight; hold on

leor = 5; % left eye out radius
leir = 2; % left eye in radius
reor = 8; % right eye out radius
reir = 2; % right eye in radius

lecx = max(x)/4; % Left Eye Center x
lecy = max(y) - max(y)/4; % Left Eye Center y
recx = max(x) - max(x)/4; % Right Eye Center x
recy = max(y) - max(y)/4; % Right Eye Center y

mllr = 6;  % mouth lower lip radius
mulr = 10; % mouth upper lip radius

lloxulx = 8.00; % Lower Lip Offset x wrt Upper Lip x
lloyuly = 2.00; % Lower Lip Offset y wrt Upper Lip y

mulcx = max(x)/2; % Mouth Upper Lip Center x
mulcy = 0.8*max(y)/2; % Mouth Upper Lip Center y

mllcx = lloxulx + mulcx; % Mouth Lower Lip Center x
mllcy = lloyuly + mulcy; % Mouth Lower Lip Center y

mx_BackLayer_ll = X; % Mouth x back layer Lower Lip
mx_BackLayer_ll(mx_BackLayer_ll < (mllcx - 1.0*mllr)) = 0;
mx_BackLayer_ll(mx_BackLayer_ll > (mllcx + 1.0*mllr)) = 0;
my_BackLayer_ll = Y; % Mouth y back layer Lower Lip
my_BackLayer_ll(my_BackLayer_ll < (mllcy - 1.0*mllr)) = 0;
my_BackLayer_ll(my_BackLayer_ll > (mllcy + 1.0*mllr)) = 0;
% mx_BackLayer_ll = mx_BackLayer_ll~=0;
% my_BackLayer_ll = my_BackLayer_ll~=0;
plot(X(mx_BackLayer_ll~=0), Y(my_BackLayer_ll~=0), 'ko')

mx_BackLayer_ul = X; % Mouth x back layer Upper Lip
mx_BackLayer_ul(mx_BackLayer_ul < (mulcx - 1.0*mulr)) = 0;
mx_BackLayer_ul(mx_BackLayer_ul > (mulcx + 1.0*mulr)) = 0;
my_BackLayer_ul = Y; % Mouth y back layer U Lip
my_BackLayer_ul(my_BackLayer_ul < (mulcy - 1.0*mulr)) = 0;
my_BackLayer_ul(my_BackLayer_ul > (mulcy + 1.0*mulr)) = 0;
% mx_BackLayer_ul = mx_BackLayer_ul~=0;
% my_BackLayer_ul = my_BackLayer_ul~=0;
plot(X(mx_BackLayer_ul~=0), Y(my_BackLayer_ul~=0), 'g.')


lex_BackLayer = X; % Left Eye x back layer
lex_BackLayer(lex_BackLayer < (lecx - 1.25*leor)) = 0;
lex_BackLayer(lex_BackLayer > (lecx + 1.25*leor)) = 0;
ley_BackLayer = Y; % Left Eye x back layer
ley_BackLayer(ley_BackLayer < (lecy - 1.25*leor)) = 0;
ley_BackLayer(ley_BackLayer > (lecy + 1.25*leor)) = 0;
plot(X(lex_BackLayer~=0), Y(ley_BackLayer~=0), 'ro')


rex_BackLayer = X; % Left Eye x back layer
rex_BackLayer(rex_BackLayer < (recx - 1.25*reor)) = 0;
rex_BackLayer(rex_BackLayer > (recx + 1.25*reor)) = 0;
rey_BackLayer = Y; % Left Eye x back layer
rey_BackLayer(rey_BackLayer < (recy - 1.25*reor)) = 0;
rey_BackLayer(rey_BackLayer > (recy + 1.25*reor)) = 0;
plot(X(rex_BackLayer~=0), Y(rey_BackLayer~=0), 'ro')


end