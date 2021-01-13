close all; clear all

xa = 0; ya = 0;
xb = 1.00; yb = 0; % Line AB is horizontal

syms x y
% [xc, yc] = solve( (x-xa)^2+(y-ya)^2==1, (x-xb)^2+(y-yb)^2==1 );
% xc = vpa(xc); xc = sum(abs(xc))/2;
% yc = vpa(yc); yc = sum(abs(yc))/2
xc = 0.5;
yc = sqrt(3)/2;

plot([xa xb],[ya yb],'k','LineWidth',1),hold on
plot([xb xc],[yb yc],'k','LineWidth',1)
plot([xc xa],[yc ya],'k','LineWidth',1)
fill([xa xb xc], [ya yb yc],'c'), axis equal, axis off

th1 = text(xa+0.02,+0.02,'A','FontWeight','bold');
th2 = text(xb-0.05,+0.02,'B','FontWeight','bold');
th3 = text(xc-0.01,yc-0.04,'C','FontWeight','bold');

x1 = 0.05; y1 = ya;
plot(x1, y1, 'ko','MarkerFaceColor','k')
text(x1-0.05, y1-0.03, '(x1, y1)','FontSize',8)

m1 = (yb-ya)/(xb-xa); m2 = (yc-yb)/(xc-xb); m3 = (ya-yc)/(xa-xc);

x2 = x1;
y2 = yc-m3*xc+m3*x2;
plot(x2,y2,'ko','MarkerFaceColor','k')
text(x2-0.10, y2+0.03, '(x2, y2)','FontSize',8)
plot([x1 x2], [y1 y2], 'k:')

x3 = (x2/m2 + y2 + m2*xb - yb)/(m2 + 1/m2);
y3 = -m2*xb + yb + m2*x3;
plot(x3,y3,'ko','MarkerFaceColor','k')
text(x3+0.02, y3, '(x3, y3)','FontSize',8)
plot([x2 x3], [y2 y3], 'k:')

x4 = x3;
y4 = ya;
plot(x4,y4,'ko','MarkerFaceColor','k')
text(x4-0.05, y4-0.03, '(x4, y4)','FontSize',8)
plot([x3 x4], [y3 y4], 'k:')

title('AGS VS ICVF and ICR')
print('-djpeg100',strcat(pwd,'\AGS VS ICVF and ICR.jpeg'))
text(0.78,0.45,'ICR','rotation',-60,'FontSize',10)
text(0.50-0.1,ya-0.035,'ICVF','rotation',00,'FontSize',10)
text(0.075,0.225,'<AGS>_{norm}','rotation', 60,'FontSize',10)

