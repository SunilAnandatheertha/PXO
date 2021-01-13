function pramati01()
close

th = linspace(0,360,100);
x = cosd(th);
y = sind(th);

axis([-1 1 -1 1]);
hold on
for count = 1:numel(th)-1
    plot([x(count) x(count+1)], [y(count) y(count+1)], '-ko', 'markerfacecolor', 'r')
    pause(0.1)
end
end