function [meanfALFF, fALFFmat] = group_fALFF(whichHemispheres,numBands,bandOfInterest)
% Compute group-average fALFF
%-------------------------------------------------------------------------------

if nargin < 1
    whichHemispheres = 'left';
end
if nargin < 2
    numBands = 5;
end
if nargin < 3
    bandOfInterest = 1;
end
%-------------------------------------------------------------------------------

% Load data:
subfile = load('subs100.mat');
numSubjects = length(subfile.subs100.subs);
timeSeriesData = givemeTS(subfile.subs100.subs(1),whichHemispheres,false);
numROIs = size(timeSeriesData,2);

% Compute LFP feature in every ROI of every subject:
fALFFmat = zeros(numROIs,numSubjects);
for i = 1:numSubjects
    subID = subfile.subs100.subs(i);
    fALFFmat(:,i) = getfALFF(subID,whichHemispheres,false,numBands,bandOfInterest);
end

% Compute mean (across subjects) in every ROI:
meanfALFF = mean(fALFFmat,2);

end
