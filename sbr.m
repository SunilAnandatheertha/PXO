% sbr : start batch run
BATCHRUN = 1;

if BATCHRUN == 1;
    % NOTE: THE FUNCTION IN NEXT LINE IS WORKING ONLY IN COMMAND LINE.. SO, do it manually !!!!
    BatchRuns = dlmread('batch_reference_file_batchrun_02.txt');
    Vf = BatchRuns(:,1);
    NoTrials = BatchRuns(:,2);
    %%%%%%%%%%%%%%%%%%%%%
    if size(BatchRuns,1)>1
        for count1 = 1:numel(Vf)
            for count2 = 1:NoTrials(count1)
                FolderName = strcat('vf',num2str(Vf(count1)),'_T',num2str(count2));
                FolderName = strcat('G:\PROJECT_and_SEMINARS\sms\v.1.3\200x200_new\',FolderName);
                cd(FolderName)
                run(strcat(FolderName,'\smc2.m'));
            end
        end
    end
end