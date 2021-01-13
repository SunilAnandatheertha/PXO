function plotham()

figure
% dlmwrite(strcat(pwd,'\results','\datafiles','\hamiltonian.txt'),ham)
finf=dlmread(strcat(pwd,'\txtfiledet.txt'));
hamiltonian=dlmread(strcat(pwd,'\results','\datafiles','\hamiltonian.txt'));
plot(finf(1:numel(hamiltonian)),hamiltonian,'bx',...
    finf(1:numel(hamiltonian)),hamiltonian,'b','LineWidth',2)
xlabel('Monte-Carlo Steps')
ylabel('Hamiltonian')
title('Hamiltonian vs. M.C.S')
axis tight
axis square
grid on
disp('Hamiltonian variation plot is printed to hamiltonian.jpeg')
print('-djpeg100',strcat(pwd,'\results','\plots','\hamiltonian.jpeg'))
pause(4)
close
end