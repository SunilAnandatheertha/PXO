function [frontvector_eq, localfrontvector_eq, GrainFull] = IdentifyFrontVector(frontvector_eq,...
                                                                                eq_stat, ...
                                                                                xincr, yincr, GrainFull,...
                                                                                dist_dyn0, eq_dyn0)
%------------------------------------------------------
localfrontvector_eq = cell(1, size(dist_dyn0, 2));
fullyempty          = ones(1, size(dist_dyn0, 2));
%------------------------------------------------------
BasicDiagonalLength = sqrt(xincr^2+yincr^2);
%------------------------------------------------------
for count = 1:size(dist_dyn0, 2)
    
    d = dist_dyn0{:,count};
    %------------------------------------------------------
%     [~, eq_stat_ind_zero]   = intersect(eq_stat, eq_dyn0(d==0));
%     [~, eq_stat_ind_xincr]  = intersect(eq_stat, eq_dyn0(d==xincr));
%     [~, eq_stat_ind_yincr]  = intersect(eq_stat, eq_dyn0(d==yincr));
%     [~, eq_stat_ind_xydiag] = intersect(eq_stat, eq_dyn0(d==sqrt(xincr^2+yincr^2)));
%     %------------------------------------------------------
%     localfrontvector_eq{1,count} = eq_stat(unique([eq_stat_ind_zero;
%                                                    eq_stat_ind_xincr;
%                                                    eq_stat_ind_yincr;
%                                                    eq_stat_ind_xydiag]));
%     %------------------------------------------------------
    %[~, eq_stat_ind_zero]   = intersect(eq_stat, eq_dyn0(d==0));
    if xincr == yincr
        [~, eq_stat_ind_xincr]  = intersect(eq_stat, eq_dyn0(d==xincr));
        [~, eq_stat_ind_xydiag] = intersect(eq_stat, eq_dyn0(d==BasicDiagonalLength));
        %------------------------------------------------------
        localfrontvector_eq{1,count} = eq_stat(unique([eq_stat_ind_xincr;
                                                       eq_stat_ind_xydiag]));
    else
        [~, eq_stat_ind_xincr]  = intersect(eq_stat, eq_dyn0(d==xincr));
        [~, eq_stat_ind_yincr]  = intersect(eq_stat, eq_dyn0(d==yincr));
        [~, eq_stat_ind_xydiag] = intersect(eq_stat, eq_dyn0(d==BasicDiagonalLength));
        %------------------------------------------------------
        localfrontvector_eq{1,count} = eq_stat(unique([eq_stat_ind_xincr;
                                                       eq_stat_ind_yincr;
                                                       eq_stat_ind_xydiag]));        
    end
    %------------------------------------------------------
    if isempty(localfrontvector_eq{1,count})
        fullyempty(1,count) = 0;
    else
        frontvector_eq = unique([frontvector_eq; localfrontvector_eq{1,count}]);
    end
end
%------------------------------------------------------
if sum(fullyempty)==0
    GrainFull = 1;
end

end