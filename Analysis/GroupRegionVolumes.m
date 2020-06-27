function [VOLmat,grpVOL] = GroupRegionVolumes(params)
%% group-level region volumes
%-------------------------------------------------------------------------------

subfile = load(params.data.subjectInfoFile);
subIDs = subfile.subs100.subs;
numSubjects = length(subIDs);

%-------------------------------------------------------------------------------
VOLmat = zeros(params.data.numAreas,numSubjects);
for i = 1:numSubjects
    subID = subIDs(i);
    VOLmat(:,i) = GetRegionVolumes(subID,params.data);
end

%-------------------------------------------------------------------------------
% Mean across subjects
grpVOL = mean(VOLmat,2);

end
