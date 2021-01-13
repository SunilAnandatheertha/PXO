% this function generates carbon nanotube geometry
function [x,y,z,ec,eva,evb] = mcg(w,M,N,VDD)
% INPUT varibales briefing:
    % w = number of walls
    % M = [m1; m2 ; ... ; mw]: chiral index M
    % N = [n1; n2 ; ... ; nw]: chiral index N
    % vdd = vacancy defect density (per unit nanometer length)
        % vdd = [vdd1; vdd2; ... ; vddw]
% OUTPUT variables briefing:
    % x, y, z = {x1 to xw}, {y1 to yw},{z1 to zw} cell variables of x y z data
    % ec      = { [e1],[e2],...[ew] } cell variable of colavent bond pair details
        % [ew] description:
            % first column node:  i
            % second column node: j
            % third, fourth, fifth columns:  xi, yi, zi
            % sixth, seventh, eigth columns: xj, yj, zj
    % eva = { [eva1],[eva2],...[evaw] } cell variable of van-der waals type a bond pair details
        % [evaw] description:
            % first column node:  i
            % second column node: j
            % third, fourth, fifth columns:  xi, yi, zi
            % sixth, seventh, eigth columns: xj, yj, zj
    % evb = { [evb1],[evb2],...[evbw] } cell variable of van-der waals type b bond pair details
        % [evbw] description:
            % first column node:  i
            % second column node: j
            % third, fourth, fifth columns:  xi, yi, zi
            % sixth, seventh, eigth columns: xj, yj, zj
for wall = 1:w
    m = M(wall);    n = N(wall);    vdd = VDD(wall);
    
    [xsw,ysw,zsw,ecw,evaw,evbw] = gswcnt(m,n,vdd);
    
    x{wall}   = xsw;    y{wall}   = ysw;    z{wall}   = zsw;
    ec{wall}  = ecw;    eva{wall} = evaw;    evb{wall} = evbw;
end
end