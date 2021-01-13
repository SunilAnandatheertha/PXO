function [frontvector_eq, localfrontvector_eq,...
                              GrainFull] = IdentifyFrontVector(frontvector_eq, dist_stat,...
                                                               eq_stat, xq_stat, yq_stat,...
                                                               eq_dyn,  xq_dyn,  yq_dyn,...
                                                               xincr, yincr, GrainFull,...
                                                               localfrontvector_eq, dist_dyn0, eq_dyn0)
%--------------------------------------------------------------
localfrontvector_eq = cell(1, size(dist_dyn0, 2));
fullyempty          = ones(1, size(dist_dyn0, 2));
for count = 1:size(dist_dyn0, 2)
    
    d = dist_dyn0{:,count};
    
    [~, eq_stat_ind_zero]   = intersect(eq_stat, eq_dyn0(d==0));
    [~, eq_stat_ind_xincr]  = intersect(eq_stat, eq_dyn0(d==xincr));
    [~, eq_stat_ind_yincr]  = intersect(eq_stat, eq_dyn0(d==yincr));
    [~, eq_stat_ind_xydiag] = intersect(eq_stat, eq_dyn0(d==sqrt(xincr^2+yincr^2)));
    
    localfrontvector_eq{1,count} = eq_stat(unique([eq_stat_ind_zero;
                                                   eq_stat_ind_xincr;
                                                   eq_stat_ind_yincr;
                                                   eq_stat_ind_xydiag]));
    [~, indices] = intersect(eq_stat, localfrontvector_eq{1,count});
%     bb = plot(xq_stat(indices), yq_stat(indices), 'r+', 'markersize',3);
%     pause(0.1)
%     delete(bb)
    
    %%%%%%%%%%%%% Remove repetitions in localfrontvector_eq
    
    %%%%%%%%%%%%%
    if isempty(localfrontvector_eq{1,count})
        fullyempty(1,count) = 0;
    else
        frontvector_eq = unique([frontvector_eq; localfrontvector_eq{1,count}]);
        %[~, xyind] = intersect(eq_stat, localfrontvector_eq{1,count});
    end
end

if sum(fullyempty)==0
    GrainFull = 1;
end

end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%