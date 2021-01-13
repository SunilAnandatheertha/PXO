function makeremovedir3d()

disp('Setting up folders and files')
if isdir(strcat(pwd,'\results'))==1
    rmdir(strcat(pwd,'\results'),'s')
    rmdir(strcat(pwd,'\simparameters'),'s')
end
delete *.txt *.asv
if isdir(strcat(pwd,'\results'))==0
    mkdir(strcat(pwd,'\simparameters'))
    mkdir(strcat(pwd,'\results'))
    mkdir(strcat(pwd,'\results','\datafiles'))
    mkdir(strcat(pwd,'\results','\datafiles','\coordinates'))
    mkdir(strcat(pwd,'\results','\datafiles','\e'))
    mkdir(strcat(pwd,'\results','\datafiles','\e','\slspce'))
    mkdir(strcat(pwd,'\results','\datafiles','\e','\cntele'))
    mkdir(strcat(pwd,'\results','\datafiles','\statematrices'))
    mkdir(strcat(pwd,'\results','\datafiles','\graindata'))
    mkdir(strcat(pwd,'\results','\datafiles','\graindata','\grainboundarye'))
    mkdir(strcat(pwd,'\results','\datafiles','\graindata','\grainelements'))
    mkdir(strcat(pwd,'\results','\datafiles','\graindata','\grainsizes'))
    mkdir(strcat(pwd,'\results','\datafiles','\graindata','\Qgrainelements'))
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%  THIS FOR LOOP CREATES A LOT OF FOLDERS !!
    %%%%% number of folders it creates = floor(m/txtwriteint) * q
%    disp('Creating folders to store grain charecterization data')
%    pause(2)
%     for countmcs = txtwriteint:txtwriteint:m
%         mkdir(strcat(pwd,'\results','\datafiles','\graindata','\Qgrainelements','\MCS',num2str(countmcs)))
%         for countq = 1:q
%             mkdir(strcat(pwd,'\results','\datafiles','\graindata','\Qgrainelements','\MCS',num2str(countmcs),'\',num2str(countq)))
%         end
%     end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    mkdir(strcat(pwd,'\results','\plots'))
    mkdir(strcat(pwd,'\results','\plots','\microstructure_plain'))
    mkdir(strcat(pwd,'\results','\plots','\microstructure_withgb'))
    mkdir(strcat(pwd,'\results','\plots','\microstructure_gbonly'))
    mkdir(strcat(pwd,'\results','\plots','\grainsize'))
    mkdir(strcat(pwd,'\results','\plots','\CNT'))
end
delthesefiles()
set(0,'DefaultFigureWindowStyle','docked')
end