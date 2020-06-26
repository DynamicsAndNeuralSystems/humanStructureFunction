function [grpNS,adjMatGroup] = GroupNodeStrength(dataParams)
% Compute group-average weighted degree
%-------------------------------------------------------------------------------

if nargin < 1
    params = GiveMeDefaultParams();
    dataParams = params.data;
end
%-------------------------------------------------------------------------------

% Load in subjects:
% vector of subject IDs, subIDList
subfile = load('subs100.mat');
subIDList = subfile.subs100.subs;
numSubjects = length(subIDList);

% Get number of regions from ComputeNodeStrength:
test = ComputeNodeStrength(subIDList(1),dataParams);
numRegions = length(test);

% Load in connectome data:
[connectomes,theDataFile] = GiveMeSC([],dataParams);

%-------------------------------------------------------------------------------
% Group connectome
% -> compute node strength as grpNS
switch dataParams.groupMethod % mean, consistency (default), variance
    case 'mean' % take the mean across all subjects
        NSmat = zeros(numRegions,numSubjects);
        for i = 1:numSubjects
            NSmat(:,i) = ComputeNodeStrength(subIDList(i),dataParams);
        end
        grpNS = mean(NSmat,2);
    case 'consistency' % VDH method
        load(theDataFile,'SIFT2_length');
        distances = SIFT2_length;
        adjMatGroup = GroupAdjConsistency(connectomes,distances,...
                        dataParams.threshold,dataParams.whichHemispheres);
        grpNS = sum(adjMatGroup)';
    case 'variance' % Roberts method
        adjMatGroup = giveMeGroupAdj_variance(connectomes,dataParams.dens,...
                                dataParams.whichHemispheres);
        grpNS = sum(adjMatGroup)';
    otherwise
        error('Unknown group connectome generation method: ''%s''',dataParams.groupMethod);
end

end
