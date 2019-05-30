function [VOLmat,grpVOL] = group_vol(whichHemispheres)
%% group volume matrix

subfile = load('subs100.mat');

numSubjects = 100;
numAreas = 34;
VOLmat = zeros(numAreas,numSubjects);
for i = 1:numSubjects
    subID = subfile.subs100.subs(i);
    VOLmat(:,i) = getVOL(subID,whichHemispheres);
end

%% group volume means (34X1)
grpVOL = mean(VOLmat,2);

end
