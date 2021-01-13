function Build_PHASE_Struct()
% [----] = Build_PHASE_Struct(-----)
% Internal function calls: (1) NONE
% todo_A [AA-AA-20]-[AA-AA-20]: 

    global PHASE
    
    PHASE.Num_Phases                               = 1;
    
    
    
    PHASE.Ph_01.PhaseInformation.Composition             = 'aluminium';
    PHASE.Ph_01.PhaseInformation.XTalSymm                = 'cubic';
    PHASE.Ph_01.PhaseInformation.SpecimenSymm            = 'orthorhombic';
    PHASE.Ph_01.PhaseInformation.VolumeFraction          = 1.0;

    PHASE.ProcessingParameters.Process             = 'extruded';
    PHASE.ProcessingParameters.Temperature         = 350; % deg Celcius
    PHASE.ProcessingParameters.Shape               = 'T';
    PHASE.ProcessingParameters.Reduction           = 60; % Percentage
    


    PHASE.Ph_01.TEX_Model.Comp__Name_Consider_GHW_fg_res = {{'W'         , 1, [00 00 00]    + [00 00 00], 15.0, 0.5, 2.5}; % The addition to EA is the EA_Offset
                                                            {'RC'        , 1, [45 00 00]    + [00 00 00], 20.0, 0.0, 2.5};
                                                            {'G'         , 1, [00 45 00]    + [00 00 00], 15.0, 0.2, 2.5};
                                                            {'B'         , 1, [35.26 45 00] + [00 00 00], 10.0, 0.6, 2.5};
                                                            {'S1'        , 0, [32 58 18]    + [00 00 00], 10.0, 0.6, 2.5};
                                                            {'S2'        , 0, [48 75 34]    + [00 00 00], 10.0, 1.0, 2.5};
                                                            {'S3'        , 0, [64 37 63]    + [00 00 00], 10.0, 1.0, 2.5};
                                                            {'S3_123_634', 0, [59 37 27]    + [00 00 00], 10.0, 1.0, 2.5};
                                                            {'C1'        , 1, [40 65 26]    + [00 00 00], 10.0, 0.6, 2.5};
                                                            {'C2'        , 0, [90 35 45]    + [00 00 00], 10.0, 1.0, 2.5};
                                                            {'T1'        , 0, [42 71 20]    + [00 00 00], 10.0, 1.0, 2.5};
                                                            {'T2'        , 0, [90 27 45]    + [00 00 00], 10.0, 1.0, 2.5};
                                                            {'user1'     , 0, [99 99 99]    + [00 00 00], 00.0, 0.0, 0.0}};

    PHASE.Ph_01.TEX_Model.Gradient.Direction1.Vector     = [0 0 0];
    PHASE.Ph_01.TEX_Model.Gradient.Direction2.Vector     = [0 0 0];
    PHASE.Ph_01.TEX_Model.Gradient.Direction3.Vector     = [0 0 0];

    PHASE.Ph_01.TEX_Model.Gradient.Direction1.Domain     = [0 0]; % Start and end of vector
    PHASE.Ph_01.TEX_Model.Gradient.Direction2.Domain     = [0 0]; % Start and end of vector
    PHASE.Ph_01.TEX_Model.Gradient.Direction3.Domain     = [0 0]; % Start and end of vector

end