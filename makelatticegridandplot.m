function [x,y]=makelatticegridandplot(xmin,xmax,ymin,ymax,xincr,yincr)

[x,y]=meshgrid(xmin:xincr:xmax,ymin:yincr:ymax);
end