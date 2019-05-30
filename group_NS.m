function [grpNS,adjMatGroup] = group_NS(whichHemispheres,whatParcellation,edgeType,groupMethod)
% Compute group-average weighted degree
%-------------------------------------------------------------------------------
% Paramaters
threshold = 0.75; % consistency threshold as per Van den Heuvel & Sporns (2011)
dens = 0.29; % density threshold for variance method (if > .29, then values don't change)

if nargin < 1
    whichHemispheres = 'left';
end
if nargin < 2
    whatParcellation = 'DK';
end
if nargin < 3
    edgeType = 'SIFT2_connectome';
end
if nargin < 4
    groupMethod = 'consistency'; % default
end

% Load in subjects:
subfile = load('subs100.mat');
subIDList = subfile.subs100.subs; % vector of data

% Get number of regions from getNS:
test = getNS(subIDList(1),whichHemispheres,whatParcellation,edgeType);
numRegions = length(test);

% Load in connectome data:
[connectomes,theDataFile] = givemeSC([],edgeType,whatParcellation);

% group connectome
numSubjects = length(subIDList);

switch groupMethod % mean, consistency (default), variance
    case 'mean' % take the mean across all subs (used in John's thesis)
        NSmat = zeros(numRegions,numSubjects);
        for i = 1:numSubjects
            NSmat(:,i) = getNS(subIDList(i),whichHemispheres,whatParcellation,edgeType);
        end
        grpNS = mean(NSmat,2);
    case 'consistency' % VDH method
        load(theDataFile,'SIFT2_length');
        distances = SIFT2_length;
        adjMatGroup = giveMeGroupAdj_consistency(connectomes,distances,threshold,whichHemispheres);
        grpNS = sum(adjMatGroup)';
    case 'variance' % Roberts method
        adjMatGroup = giveMeGroupAdj_variance(connectomes,dens,whichHemispheres);
        grpNS = sum(adjMatGroup)';
end
