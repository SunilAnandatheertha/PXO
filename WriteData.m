function [DataFileNames] = WriteData(Data_To_Write, WriteGrainIndicesToDisk, FileLocations,...
                                GenericFileName, All_Grains_time,...
                                m, txtwriteint, NtimeSteps)

switch lower(Data_To_Write)
    case 'grainindices'
        for rset = 1:1:(m/txtwriteint)
            if WriteGrainIndicesToDisk ~= 0
                disp('Writing grain data to files ...')
                ThisFileLocation                      = FileLocations{1,rset};
                ThisGenericName                       = GenericFileName{1,rset};
                All_Grains_Q                          = All_Grains_time{1,rset};
                Datafilenames_in_allq_inthistimeslice = cell(1,numel(All_Grains_Q));
                %------------------------------------------------------
                for countq = 1:numel(All_Grains_Q)
                    if numel(All_Grains_Q{countq})~=0 % If grains exist in q
                        for countng = 1:numel(All_Grains_Q{countq}) % For each grain in q
                            ThisGrain__Eq_Data__FileName = [ThisGenericName, '__q_', num2str(countq),...
                                                            '__IndicesGrainNo_', num2str(countng), '.dat'];
                            if countng==1
                                Datafilenames_in_thisq{1,countng} = ThisGrain__Eq_Data__FileName;
                            else
                                Datafilenames_in_thisq{1,countng} = ThisGrain__Eq_Data__FileName;
                            end
                            DataWriteLocationAndFileName = [pwd filesep ThisFileLocation filesep ThisGrain__Eq_Data__FileName];
                            dlmwrite(DataWriteLocationAndFileName, All_Grains_Q{countq}{countng})
                            Datafilenames_in_allq_inthistimeslice{1,countq} = Datafilenames_in_thisq;
                        end
                    else
                        Datafilenames_in_allq_inthistimeslice{1,countq} = [];
                    end
                end
                %------------------------------------------------------
                DataFileNames{1,rset} = Datafilenames_in_allq_inthistimeslice;
            end
            % Do nothing
        end
    otherwise
        DataFileNames = [];
end
end