function [xswnt,yswnt,zswnt,cov_swnt,vd1_swnt,vd2_swnt] = gswcnt(m,n,vdd)

m = 8;
n = 0;
l = 3;
vdd = 0.4;
[xsgw,ysgw,cov_gra,vd1_gra,vd2_gra] = gswgraphene(m,n,l,vdd);
dcoven(cov_gra,[10 100 250])
dvd1en(vd1_gra,[10 100 250])
dvd2en(vd2_gra,[10 100 250])


xsw = xsgtubew; ysw = ysgtubew; zsw = zsgtubew;

[ecw]  = findecwcnt(xsw,ysw,zsw);
[evaw] = findecwcnt(xsw,ysw,zsw);
[evbw] = findecwcnt(xsw,ysw,zsw);
end