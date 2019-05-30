function [meanLFP, LFPmat] = group_LFP(whichHemispheres,whatParcellation,numBands,bandOfInterest)
% Compute group-average LFP
%-------------------------------------------------------------------------------

if nargin < 1
    whichHemispheres = 'left';
end
if nargin < 2
    whatParcellation = 'HCP';
end
if nargin < 3
    numBands = 5;
end
if nargin < 4
    bandOfInterest = 1;
end
%-------------------------------------------------------------------------------

% Load data:
subfile = load('subs100.mat');
numSubjects = length(subfile.subs100.subs);
timeSeriesData = givemeTS(subfile.subs100.subs(1),whichHemispheres,false,whatParcellation);
numROIs = size(timeSeriesData,2);

% Compute LFP feature in every ROI of every subject:
LFPmat = zeros(numROIs,numSubjects);
for i = 1:numSubjects
    subID = subfile.subs100.subs(i);
    LFPmat(:,i) = getFreqBand(subID,whichHemispheres,whatParcellation,false,numBands,bandOfInterest);
end

% Compute mean (across subjects) in every ROI:
meanLFP = mean(LFPmat,2);

end
