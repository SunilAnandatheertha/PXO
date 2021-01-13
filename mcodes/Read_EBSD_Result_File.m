function [data] = Read_EBSD_Result_File(filename)

fid = fopen(filename);
% 01. Nr.
% 02. Phase
% 03. Area [µm²]
% 04. d [µm]
% 05. l
% 06. Xcg
% 07. Ycg
% 08. Aspect ratio
% 09. Slope
% 10. GOS [°]
% 11. MOS [°]
% 12. Mean E1 [°]
% 13. Mean E2 [°]
% 14. Mean E3 [°]
% 15. In current dataset
% 16. Border grain
% 17. Grain ID
%                     01 02 03 04 05 06 07 08 09 10 11 12 13 14 15 16 17
data = textscan(fid, '%d %s %f %f %f %f %f %f %f %f %f %f %f %f %s %s %f');
fclose(fid);

end