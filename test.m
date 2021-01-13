a = 0;
count = 0;
while stop == 1
    mynumber = rand(1)
    if mynumber < 0.25
        a = 1
        if a == 1
            stop = 1
        end
    end
    count = count + 1
end
count