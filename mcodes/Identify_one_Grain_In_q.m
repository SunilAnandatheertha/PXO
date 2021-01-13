function [grain, eq_dyn0, xq_dyn0, yq_dyn0] = Identify_one_Grain_In_q(ng, eq_stat, xq_stat, yq_stat,...
                                                                      eq, xq, yq, xincr, yincr,...
                                                                      Type_of_SP, GrainFull,...
                                                                      eq_dyn0, xq_dyn0, yq_dyn0)
%------------------------------------------------------
grain   = [];
if ng==1
    eq_dyn0 = eq;
    xq_dyn0 = xq;
    yq_dyn0 = yq;
end
%------------------------------------------------------
for sps = 1:1E3
    if GrainFull == 1
        break
    end
    %------------------------------------------------------
    if sps == 1
        frontvector_eq = 0;  % Just an initialization
    end
    %------------------------------------------------------
    [frontvector_eq, localfrontvector_eq,...
             Type_of_SP, GrainFull, eq_dyn0, xq_dyn0, yq_dyn0] = ChooseSourcePointsForFront(eq_stat, xq_stat,...
                                                                                            yq_stat,...
                                                                                            frontvector_eq, Type_of_SP, GrainFull,...
                                                                                            xincr, yincr,...
                                                                                            eq_dyn0, xq_dyn0, yq_dyn0);
    %------------------------------------------------------
    grain = unique([grain; frontvector_eq]);
    %------------------------------------------------------
end
end