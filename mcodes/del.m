















a = zeros(size(GDOFlong));

for count = 1:numel(GTBCD);
    a = a + (GDOFlong == repmat(GTBCD(count), size(GDOFlong,1), 1));
end
GNBCD = find(a==0);