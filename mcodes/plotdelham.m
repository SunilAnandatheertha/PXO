function [delhamiltonian, CFN] = plotdelham(CFN)
% [----] = plotdelham(-----)
% Internal function calls: (1) NONE
% todo_A [AA-AA-20]-[AA-AA-20]: 

% Plot temporal evolution of change in hamiltonian
% figure(CFN+1)
% dlmwrite(strcat(pwd,'\results','\datafiles','\hamiltonian.txt'),ham)
finf = dlmread(strcat(pwd,'\txtfiledet.txt'));
delhamiltonian = dlmread(strcat(pwd,'\results','\datafiles','\ChangeInHamiltonian.txt'));
line(finf(1:numel(delhamiltonian)),delhamiltonian,...
     'LineStyle','-','color', 'b','LineWidth',1.5,...
     'marker','+', 'markersize', 12, 'markeredgecolor', 'b', 'markerfacecolor', 'b')

xlabel('m, Monte-Carlo Step number')
ylabel('\Delta(H)')
axis tight; 
% axis square; 
box on
% disp('Hamiltonian variation plot is printed to hamiltonian.jpeg')
print('-djpeg100',strcat(pwd,'\results','\plots','\Delta_Hamiltonian.jpeg'))
% pause(4)
% close
CFN = length(findobj('type','figure'));
end