function amp = getfALFF(subID,whichHemispheres,doRandomize,numBands,bandOfInterest)
% Returns fALFF
%-------------------------------------------------------------------------------

% If only input subID
if nargin < 2
    whichHemispheres = 'left'; % 'right','both','left
end
if nargin < 3
    doRandomize = false;
end
% Take lowest fifth of frequencies:
if nargin < 4
    numBands = 5;
end
if nargin < 5
    bandOfInterest = 1;
end
%-------------------------------------------------------------------------------

%% Load in functional data
timeSeriesData = GiveMeTimeSeries(subID,whichHemispheres);
numRegions = size(timeSeriesData,2);
%numBands = 5;

amp = zeros(numRegions,1);
for i = 1:numRegions
    spectralProperties = SP_fALFF(timeSeriesData(:,i),864/1200);
    amp(i) = spectralProperties.fALFF;
end


end
