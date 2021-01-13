function FEA_FUN_FileFolderOperations(AnalysisType)

%% NECESSARY OTHER FILE-FOLDER OPERATIONS

switch AnalysisType
    case '1DNonLinearBar'
        if  isdir(strcat(pwd,'\results\FEANL1DS'))==1
            rmdir(strcat(pwd,'\results\FEANL1DS'),'s')
            mkdir(strcat(pwd,'\results\FEANL1DS\KGBL_UNPARTITIONED'))
            mkdir(strcat(pwd,'\results\FEANL1DS\KGBL_PARTITIONED'))
        else
            mkdir(strcat(pwd,'\results\FEANL1DS\KGBL_UNPARTITIONED'))
            mkdir(strcat(pwd,'\results\FEANL1DS\KGBL_PARTITIONED'))
        end
    case '1DNonLinearSpring'
end

end