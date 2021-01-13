function justplot(TD, DATSPE, C, P)

% justplot('p', DAT, C, P)
if iscell(TD)
    nTD = numel{TD};
end

if iscell(DATSPE)
    if numel(DATSPE)==2
        if iscell(DATSPE{1})
            if numel(DATSPE{1})==1
                DAT = DATSPE{1}; % Actual data
            else
                DAT = cell(1, numel(DATSPE{1}));
                DAT(1,:) = DATSPE{1}{:};
            end
        end
        if iscell(DATSPE{2})
            if numel(DATSPE{2})==1
                SPE = repcell(DATSPE{2}, [1 numel(DATSPE{1}) 1]);
            else
                SPE = cell(1, numel(DATSPE{2}));
                SPE(1,:) = DATSPE{2}{:};
            end
        end
    else
        DAT = DATSPE{1}; % Actual data. Default specifiers
    end
    ndata      = numel{DATSPE};
end
if iscell(C)   ncontrols  = numel{C};   end
if iscell(P)   nprintopts = numel{P};   end

end

function SPE = repcell(cellcontent, n)
    SPE = cell(n);
    for count = 1:numel(SPE)
        SPE{count} = cellcontent;
    end
end