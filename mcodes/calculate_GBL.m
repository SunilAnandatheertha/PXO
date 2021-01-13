function [GBL_time] = calculate_GBL(All_Grains_time)

% This function returns the grain boundary length of all indexed grains.
% GBL: Grain Boundary Length
global Lattice
x = Lattice.size.x;
y = Lattice.size.y;

GBL_time = cell(1, numel(All_Grains_time));
for rset = 1:numel(All_Grains_time)
    GBL_thisrset = cell(1, numel(All_Grains_time{rset}));
    for countq = 1:numel(All_Grains_time{rset})
        if ~isempty(All_Grains_time{rset}{countq})
            GBL_This_q = zeros(numel(All_Grains_time{rset}{countq}), 1);
            for countng = 1:numel(All_Grains_time{rset}{countq})
                gb_el_nums = All_Grains_time{rset}{countq}{countng};
                gb_el_x    = x(gb_el_nums);
                gb_el_y    = y(gb_el_nums);
                if numel(All_Grains_time{rset}{countq}{countng})==1
                    GBL_This_q(countng) = 1; % TO BE REPLACED BY SQRT(XINCR^2+YINCR^2)
                else
                    length = 0;
                    for count_gbe = 1:numel(gb_el_nums)-1
                        length = length + sqrt((gb_el_x(count_gbe)-gb_el_x(count_gbe+1))^2 + (gb_el_y(count_gbe)-gb_el_y(count_gbe+1))^2);
                    end
                    GBL_This_q(countng) = length;
                end
            end
            GBL_thisrset{1, countq} = GBL_This_q;
        end
    end
    GBL_time{1, rset} = GBL_thisrset;
end


end