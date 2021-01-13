function WeightMatrix = get__weight_matrix(dimensionality, WeightMatrixID)
%-------------------------------------------------------------
global Lattice MC_Param
%-------------------------------------------------------------
switch lower(dimensionality)
    case '2d'
        if Lattice.type.square == 1
            switch WeightMatrixID
                case 'symm_00'
                    if MC_Param.Num_Nearest_Neigh_Level.lattice_square == 1
                        WeightMatrix = ones(3,3);
                    elseif MC_Param.Num_Nearest_Neigh_Level.lattice_square == 2
                    end
                case 'symm_01'
                    % 3 Stable grain structure. 45 deg sharp orientation.
                    if MC_Param.Num_Nearest_Neigh_Level.lattice_square == 1
                        WeightMatrix = [1.0 0.5 0.5;
                                        0.5 1.0 0.5;
                                        0.5 0.5 1.0];
                    elseif MC_Param.Num_Nearest_Neigh_Level.lattice_square == 2
                    end
                case 'symm_02'
                     % Stable grain structure. 45 deg sharp orientation. Grows only along 45 deg by social darwinism
                    if MC_Param.Num_Nearest_Neigh_Level.lattice_square == 1
                        WeightMatrix = [2.0 0.5 0.5;
                                        0.5 1.0 0.5;
                                        0.5 0.5 2.0];
                    elseif MC_Param.Num_Nearest_Neigh_Level.lattice_square == 2
                    end
                case 'symm_03'
                    % 5 Stable grain structure. 45 deg sharp orientation. Grows only along 45 deg by social darwinism
                    if MC_Param.Num_Nearest_Neigh_Level.lattice_square == 1
                        WeightMatrix = [2.0 1.0 0.5;
                                        1.0 1.0 1.0;
                                        0.5 1.0 2.0]; 
                    elseif MC_Param.Num_Nearest_Neigh_Level.lattice_square == 2
                    end
                case 'symm_04'
                    % 6 Stable grain structure. 45 deg sharp orientation. Grows only along 45 deg by social darwinism
                    if MC_Param.Num_Nearest_Neigh_Level.lattice_square == 1
                        WeightMatrix = [2.0 1.0 0.0;
                                        1.0 1.0 1.0;
                                        0.0 1.0 2.0]; 
                    elseif MC_Param.Num_Nearest_Neigh_Level.lattice_square == 2
                    end
                case 'symm_05'
                    % 7 Stable grain structure. Rectangular grains. Quick grain size saturation. Self-pinned grain structure
                    if MC_Param.Num_Nearest_Neigh_Level.lattice_square == 1
                        WeightMatrix = [0.5 1.0 0.0;
                                        1.0 1.0 1.0;
                                        0.0 1.0 0.5]; 
                    elseif MC_Param.Num_Nearest_Neigh_Level.lattice_square == 2
                    end
                case 'symm_06'
                    % 8 Stable grain structure. Rectangular grains. Slower grain size saturation. Self-pinned grain structure
                    if MC_Param.Num_Nearest_Neigh_Level.lattice_square == 1
                        WeightMatrix = [0.5 1.0 0.0;
                                        1.0 0.0 1.0;
                                        0.0 1.0 0.5]; 
                    elseif MC_Param.Num_Nearest_Neigh_Level.lattice_square == 2
                    end
                case 'symm_07'
                    % 9 45 deg rough grains. Quick growth. Too many single pixel grains. Large fluctuations.
                    if MC_Param.Num_Nearest_Neigh_Level.lattice_square == 1
                        WeightMatrix = [0.0 1.0 0.0;
                                        1.0 1.0 0.0;
                                        0.0 0.0 1.0]; 
                    elseif MC_Param.Num_Nearest_Neigh_Level.lattice_square == 2
                    end
                case 'asymm_00_a'
                    % Implemented outsde a MC step
                    if MC_Param.Num_Nearest_Neigh_Level.lattice_square == 1
                        WeightMatrix = rand(3,3);
                    elseif MC_Param.Num_Nearest_Neigh_Level.lattice_square == 2
                    end
                case 'asymm_00_b'
                    % Implemented inside a MC step. Only for Alg. 4445
                    if MC_Param.Num_Nearest_Neigh_Level.lattice_square == 1
                        WeightMatrix = [];
                    elseif MC_Param.Num_Nearest_Neigh_Level.lattice_square == 2
                        WeightMatrix = [];
                    end
                case 'asymm_01'
                    % 1 Moving grain structure. 45 deg sharp orientation.
                    if MC_Param.Num_Nearest_Neigh_Level.lattice_square == 1
                        WeightMatrix = [1.0 1.0 0.0;
                                        1.0 1.0 0.0;
                                        0.0 0.0 1.0];
                    elseif MC_Param.Num_Nearest_Neigh_Level.lattice_square == 2
                    end
                case 'asymm_02'
                    % 2 Moving grain structure. 45 deg sharp orientation.
                    if MC_Param.Num_Nearest_Neigh_Level.lattice_square == 1
                        WeightMatrix = [1.0 0.0 0.0;
                                        1.0 1.0 0.0;
                                        0.0 0.0 1.0]; 
                    elseif MC_Param.Num_Nearest_Neigh_Level.lattice_square == 2
                    end
                case 'asymm_03'
                    % 10 Moving (top to bot) rough grains. Quick growth.
                    if MC_Param.Num_Nearest_Neigh_Level.lattice_square == 1
                        WeightMatrix = [0.0 1.0 1.0;
                                        1.0 1.0 0.0;
                                        0.0 1.0 1.0]; 
                    elseif MC_Param.Num_Nearest_Neigh_Level.lattice_square == 2
                    end
                case 'asymm_04'
                    % 11 Moving (bot to top) rough grains. Quick growth.
                    if MC_Param.Num_Nearest_Neigh_Level.lattice_square == 1
                        WeightMatrix = [1.0 1.0 0.0;
                                        0.0 1.0 1.0;
                                        1.0 1.0 0.0]; 
                    elseif MC_Param.Num_Nearest_Neigh_Level.lattice_square == 2
                    end
                case 'asymm_05'
                    % 12 Stable grains. Rough along 45 degrees. Perefect Horizontal edges. Slow growth.
                    if MC_Param.Num_Nearest_Neigh_Level.lattice_square == 1
                        WeightMatrix = [0.5 1.0 0.0;
                                        0.0 1.0 1.0;
                                        0.5 1.0 0.0]; 
                    elseif MC_Param.Num_Nearest_Neigh_Level.lattice_square == 2
                    end
                case 'asymm_06'
                    if MC_Param.Num_Nearest_Neigh_Level.lattice_square == 1
                        const = 3;
                        WeightMatrix = const + randn(3,3); 
                    elseif MC_Param.Num_Nearest_Neigh_Level.lattice_square == 2
                    end
                    % 14 Implemented inside a MC step. Only for Alg. 4446. If const = 0, grain structure will not develop as expected.
                    % Very random grain structure. GS stable. COntinuous growth. COnst is shifting the mean towards positive.
                otherwise
            end
        elseif Lattice.type.triangular
            
        elseif Lattice.type.hexagonal
            
        elseif Lattice.type.random
            
        end
    case '3d'
end