function [varargout] = SFFO(varargin)

% SMS FILE AND FOLDER OPERATIONS

switch varargin{1}
    case 'ssam' % SMS Simulated Annealing Module
        if varargin{2} == 1
            disp('Setting up folders and files')
            if isdir(strcat(pwd,'\results'))==1
                rmdir(strcat(pwd,'\results'),'s')
                rmdir(strcat(pwd,'\simparameters'),'s')
            end
            if isdir(strcat(pwd,'\results'))==0
                if isdir(strcat(pwd,'\simparameters'))==0
                    mkdir(strcat(pwd,'\simparameters'))
                end
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
                mkdir(strcat(pwd,'\results','\plots'))
                mkdir(strcat(pwd,'\results','\plots','\microstructure_plain'))
                mkdir(strcat(pwd,'\results','\plots','\microstructure_withgb'))
                mkdir(strcat(pwd,'\results','\plots','\microstructure_gbonly'))
                mkdir(strcat(pwd,'\results','\plots','\grainsize'))
                mkdir(strcat(pwd,'\results','\plots','\CNT'))
            end
            delthesefiles()
            set(0,'DefaultFigureWindowStyle','docked')
        elseif strcmp(varargin{2}, 'MoveResults') == 1
            copyfile(strcat(pwd,'\results'),strcat(pwd,'\SSAM_Results_Run.No.',num2str(varargin{3}),'\results'),'f')
            switch varargin{2}
                case '2d'
                    copyfile(strcat(pwd,'\grainsize_interceptmethod2d.m'),...
                        strcat(pwd,'\SSAM_Results_Run.No.',num2str(count),'\results'), 'f')
                    copyfile(strcat(pwd,'\plotgrainstructure2d.m'),...
                        strcat(pwd,'\SSAM_Results_Run.No.',num2str(count),'\results'),'f')
                case'3d'
            end
        end
    case 'sfeam'
        switch varargin{2}
            case 'ag'
                switch varargin{3}
                    case 'checkroot'
                        if isdir(strcat(pwd,'\results')) == 1
                            if isdir(strcat(pwd,'\results\sfeam')) == 1
                                rmdir(strcat(pwd,'\results\sfeam'),'s')
                                if isdir(strcat(pwd,'\results\sfeam\g1')) == 1
                                    rmdir(strcat(pwd,'\results\sfeam\g1'),'s')
                                else
                                    mkdir(strcat(pwd,'\results','\sfeam\g1'))
                                end
                            else
                                mkdir(strcat(pwd,'\results','\sfeam'))
                                mkdir(strcat(pwd,'\results','\sfeam\g1'))
                            end
                        else
                            mkdir(strcat(pwd,'\results'))
                            mkdir(strcat(pwd,'\results','\sfeam'))
                            mkdir(strcat(pwd,'\results','\sfeam\g1'))
                        end
                    case 'wrtd' % Write Results To Disk
                        if nargin <= 5
                            FileName = strcat(pwd, '\results\sfeam\', varargin{4}, '.txt');
                        elseif nargin == 7
                            switch varargin{6}
                                case {'loadstep','ls'}
                                    FileName = strcat(pwd, '\results\sfeam\', varargin{4}, num2str(varargin{7}),'.txt');
                            end
                        end
                        DataToWrite = varargin{5};
                        dlmwrite(FileName, DataToWrite, 'delimiter', '\t')
                    case 'rrfd' % Read Result From Disk
                        switch varargin{4}{1}
                            case 'NNNCM_LS=1'
                                varargout{1} = dlmread(strcat(pwd,'\results\sfeam\','NNNCM_LS=1','.txt'));
                        end
                    case 'ragfd' % Read Atomistic Geometry Results From Disk
                        FileName    = strcat(pwd, '\results\sfeam\');
                        switch varargin{4}
                            case {'all','a'}
                                varargout{1} = dlmread(strcat(FileName,'\','xsgs','.txt'));
                                varargout{2} = dlmread(strcat(FileName,'\','ysgs','.txt'));
                                varargout{3} = dlmread(strcat(FileName,'\','zsgs','.txt'));
                                varargout{4} = dlmread(strcat(FileName,'\','cov_gra_appended','.txt'));
                                varargout{5} = dlmread(strcat(FileName,'\','vd1_gra_appended','.txt'));
                                varargout{6} = dlmread(strcat(FileName,'\','vd2_gra_appended','.txt'));
                            case {'xyzsgs', 'xyz'}
                                varargout{1} = dlmread(strcat(FileName,'\','xsgs','.txt'));
                                varargout{2} = dlmread(strcat(FileName,'\','ysgs','.txt'));
                                varargout{3} = dlmread(strcat(FileName,'\','zsgs','.txt'));
                            case {'xysgs', 'xy'}
                                varargout{1} = dlmread(strcat(FileName,'\','xsgs','.txt'));
                                varargout{2} = dlmread(strcat(FileName,'\','ysgs','.txt'));
                            case {'xsgs', 'x'}
                                varargout{1} = dlmread(strcat(FileName,'\','xsgs','.txt'));
                            case {'ysgs', 'y'}
                                varargout{1} = dlmread(strcat(FileName,'\','ysgs','.txt'));
                            case {'zsgs', 'z'}
                                varargout{1} = dlmread(strcat(FileName,'\','zsgs','.txt'));
                            case {'elements', 'e'}
                                varargout{1} = dlmread(strcat(FileName,'\','cov_gra_appended','.txt'));
                                varargout{2} = dlmread(strcat(FileName,'\','vd1_gra_appended','.txt'));
                                varargout{3} = dlmread(strcat(FileName,'\','vd2_gra_appended','.txt'));
                            case {'e_cov', 'ecov', 'ec', 'e1'}
                                varargout{1} = dlmread(strcat(FileName,'\','cov_gra_appended','.txt'));
                            case {'e_vd1', 'evd1', 'ev1', 'e2'}
                                varargout{1} = dlmread(strcat(FileName,'\','vd1_gra_appended','.txt'));
                            case {'e_vd2', 'evd2', 'ev2', 'e3'}
                                varargout{1} = dlmread(strcat(FileName,'\','vd2_gra_appended','.txt'));
                        end
                end
            case 'cont'
        end
    case 'smd'
end

end