close

xstart = 0;
xincr  = 1;
xend   = 4;

ystart = 0;
yincr  = 1;
yend   = 4;

[x, y] = meshgrid(xstart:xincr:xend, ystart:yincr:yend);
e      = reshape(1:numel(x), size(x));

x_sparse_start = 0.8;
x_sparse_end   = 3.4;

y_sparse_start = 0.8;
y_sparse_end   = 5.6;

if x_sparse_start<min(min(x))
    x_sparse_start = min(min(x));
end
if x_sparse_end>max(max(x))
    x_sparse_end= max(max(x));
end
if y_sparse_start<min(min(y))
    y_sparse_start = min(min(y));
end
if y_sparse_end>max(max(y))
    y_sparse_end= max(max(y));
end


[~, loc_x] = ismember(round(x_sparse_start:xincr:x_sparse_end), x);
[~, loc_y] = ismember(round(y_sparse_start:yincr:y_sparse_end), y);

[~, col] = ind2sub(size(x), loc_x);
[row, ~] = ind2sub(size(y), loc_y);

x(row, col)
y(row, col)

plot(x, y, 'rs')
hold on
plot(x(row,col), y(row,col), 'k.')
plot(x_sparse_start, y_sparse_start, 'go')
plot(x_sparse_end, y_sparse_end, 'mo')





sparse_skip_row = 1;
sparse_skip_col = 2;
a__red_sparsed  = a(1:1+sparse_skip_row:size(a,1), 1:1+sparse_skip_col:size(a,2));


sparse_skip_row = 1;
sparse_skip_col = 2;
a__red_sparsed  = a(1:1+sparse_skip_row:size(a,1), 1:1+sparse_skip_col:size(a,2));

subset_start_row = 2;
subset_start_row_skip = 1;
subset_close_row = size(a,1);

subset_start_col = 1;
subset_start_col_skip = 1;
subset_close_col = size(a,1);

a__red_subset  = a(subset_start_row:subset_start_row_skip:subset_close_row,...
                   subset_start_col:subset_start_col_skip:subset_close_col)