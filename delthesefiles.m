function delthesefiles()

delete(strcat(pwd,'\','resultdatafiles','\','*.txt'))
delete(strcat(pwd,'\','resultmicrostrucureplots','\','*.jpeg'))

% delete(strcat(pwd,'\*.txt'))
delete(strcat(pwd,'\results','\*.txt'))
delete(strcat(pwd,'\results\datafiles','\*.txt'))
delete(strcat(pwd,'\results\datafiles\graindata','\*.txt'))
delete(strcat(pwd,'\results\datafiles\graindata\grainboundarye','\*.txt'))
delete(strcat(pwd,'\results\datafiles\graindata\grainelements','\*.txt'))
delete(strcat(pwd,'\results\datafiles\graindata\grainsizes','\*.txt'))
delete(strcat(pwd,'\results\datafiles\statematrices','\*.txt'))
delete(strcat(pwd,'\results\datafiles\e','\*.txt'))

delete(strcat(pwd,'\results','\*.jpeg'))
delete(strcat(pwd,'\results\plots','\*.jpeg'))
delete(strcat(pwd,'\results\plots\grainsize','\*.jpeg'))
delete(strcat(pwd,'\results\plots\microstructure_gbonly','\*.jpeg'))
delete(strcat(pwd,'\results\plots\microstructure_plain','\*.jpeg'))
delete(strcat(pwd,'\results\plots\microstructure_withgb','\*.jpeg'))
end