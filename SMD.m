function SMD(varargin)
%\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
%\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
% SMD:: S M S    M O L E C U L A R    D Y N A M I C S
%\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
%\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
% version 1.00 Start: 11-01-2014
% THIS IS THE MAIN FUNCTION OF MOLECULAR DYNAMICS MODULE
switch varargin{1}
    case '0100' % For single graphene sheet: 3-D analysis
    case '0200' % For stack of graphene sheets: 3-D analysis
        AGG('Gn','RFFyes',[1 2 1 2],'SortNo',1);
        % SMD_SETUP(INPUT ARGUMENTS)
        % SMD_SOLVER(INPUT ARGUMENTS)
        % SMD_SRV(INPUT ARGUMENTS)
    case '9800' % For single graphene sheet: 2-D analysis
    case '9900' % C-C covalent bonding: 1-D analysis
        % Testing purposes only
        T = varargin{2}; % Simulation temperature in Kelvin
        k = SPC('SMD', 'boltzmann'); % Boltzmann Constant
        m = SPC('SMD', 'c12mass'); % Mass of C-12 atom     
end