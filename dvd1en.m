function dvd1en(vd1_gra,vd1ENTD)

% 1) dcoven(cov_gra,1:size(cov_gra,1))
% 2) dcoven(cov_gra,[1 5 2 77 160 250])

% den -- display covalent element number
% covENTD = [59 79 2 14]; % Covalent Element Number To Display

for ct1 = 1:numel(vd1ENTD)
    plot([vd1_gra(vd1ENTD(ct1),3) vd1_gra(vd1ENTD(ct1),5)],...
         [vd1_gra(vd1ENTD(ct1),4) vd1_gra(vd1ENTD(ct1),6)],...
          'c--','LineWidth',2.5);
    hold on
end

end
