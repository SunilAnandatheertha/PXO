function [GrainSize] = CalculateGrainSize(GrainArea)

GrainSize = (4/pi)*sqrt(GrainArea);

end