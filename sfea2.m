function sfea2()

%% SINGLE GRAPHENE SHEET STRESS-STRAIN ANANLYSIS
[xsgs, ysgs, cov_gra, vd1_gra, vd2_gra] = SingleGrapheneSheet(10, 0, 3, 2);

FEA_2d_SingleGrapheneSheet(xsgs,ysgs,cov_gra,vd1_gra,vd2_gra);

end