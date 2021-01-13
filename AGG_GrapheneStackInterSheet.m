function [vd3_gra] = AGG_GrapheneStackInterSheet(xsheeti, ysheeti, zsheeti, xsheetj, ysheetj, zsheetj, varargin)
% NOTE:::: FIND PSEUDO-CODE AT THE END OF THE PROGRAM
%///////////////////////////////
MissingAtomsi = isnan(xsheeti);
MissingAtomsj = isnan(xsheetj);
%///////////////////////////////
vd3_gra = zeros(4*max([numel(xsheeti) numel(xsheetj)]),2);
count = 0;

if nargin == 7 % INCLUSIVE OF 6 MUST INPUTS
    issl = min(abs((varargin{1}(:)))); % INTER SHEET SPACING LOWER
    issu = max(abs((varargin{1}(:)))); % INTER SHEET SPACING UPPER
end 

for cti = 1 : numel(xsheeti)           % SHEET i
    if MissingAtomsi(cti) == 0
        for ctj = 1 : numel(xsheetj)   % SHEET i
            if MissingAtomsj(ctj) == 0
                D = sqrt( (xsheeti(cti) - xsheetj(ctj)).^2 +...
                          (ysheeti(cti) - ysheetj(ctj)).^2 +...
                          (zsheeti(cti) - zsheetj(ctj)).^2 );
                if D > issl && D < issu
                    count = count + 1;
                    vd3_gra(count,:) = [cti ctj];
                end
            end
        end
    end
end
%///////////////////////////////
%  C L E A N   U P  >-->  vd3_gra
vd3_gra(find(vd3_gra(:,1) == 0),:) = []; % REMOVE ZEROS
exclude = zeros(size(vd3_gra,1),1);

% for ct1 = 1:size(vd3_gra,1)
%     a = vd3_gra(ct1,1:2);
%     for ct2 = ct1+1:size(vd3_gra,1)
%         if ct1 ~= ct2
%             b = [vd3_gra(ct2,2) vd3_gra(ct2,1)];
%             if a(1)==b(1) && a(2)==b(2)
%                 exclude(ct2) = ct2;
%             end
%         end
%     end
% end

exclude(exclude==0) = [];
vd3_gra(exclude,:)  = [];
%///////////////////////////////
% APPEND vd3_gra WITH NODE NUMBER AND NODE POSITION INFORMATION
vd3_gra = [vd3_gra zeros(size(vd3_gra,1),6)];

for count = 1:size(vd3_gra,1)
    vd3_gra(count,3:8) = [xsheeti(vd3_gra(count,1)), ysheeti(vd3_gra(count,1)), zsheeti(vd3_gra(count,1)),...
                        xsheetj(vd3_gra(count,2)), ysheetj(vd3_gra(count,2)), zsheetj(vd3_gra(count,2))];
end
%\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
%\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
%% PSEUDO CODE FOR THIS FUNCTION
%///////////////////////////////
% Function vesrion history: V.2.00. As on 09-01-2014
%                           V.1.00. Sometime in Dec. 2013 <<--< START
%///////////////////////////////
% Function input description:
% xsheeti, ysheeti, zsheeti :: Co-ordinates of i'th graphene sheet
% xsheetj, ysheetj, zsheetj :: Co-ordinates of j'th graphene sheet
%\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
%\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
end