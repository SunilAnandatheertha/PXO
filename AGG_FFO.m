function AGG_FFO()

% AGG_FFO :: Atomic Geometry Generator - File and Folder Operations

% disp('AGG_FFO: Setting up folders and files')

if isdir(strcat(pwd,'\results'))==0
    mkdir(strcat(pwd,'\results'))
    mkdir(strcat(pwd,'\results','\plots'))
    mkdir(strcat(pwd,'\results','\plots','\GrapheneSheet'))
elseif isdir(strcat(pwd,'\results'))==1
    if isdir(strcat(pwd,'\results\plots'))==0
        mkdir(strcat(pwd,'\results','\plots'))
        mkdir(strcat(pwd,'\results','\plots','\GrapheneSheet'))
    elseif isdir(strcat(pwd,'\results\plots'))==1
        if isdir(strcat(pwd,'\results\plots','\GrapheneSheet'))==0
            mkdir(strcat(pwd,'\results','\plots','\GrapheneSheet'))
        end
    end
end