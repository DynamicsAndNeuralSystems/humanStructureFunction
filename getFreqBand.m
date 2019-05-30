function bandPower = getFreqBand(subID,whichHemispheres,whatParcellation,doRandomize,numBands,bandOfInterest)
% Computes low frequency power across ROIs for a given subject
%-------------------------------------------------------------------------------

% Check Inputs:
if nargin < 2
    whichHemispheres = 'left'; % 'right','both','left'
end
if nargin < 3
    whatParcellation = 'HCP';
end
if nargin < 4
    doRandomize = false;
end
% Take lowest fifth of frequencies:
if nargin < 5
    numBands = 5;
end
if nargin < 6
    bandOfInterest = 1;
end
%-------------------------------------------------------------------------------

% Load in BOLD data
timeSeriesData = givemeTS(subID,whichHemispheres,doRandomize,whatParcellation);
[timeSeriesLength,numRegions] = size(timeSeriesData);

% Compute sampling frequency
scanDuration = 864; % (s)
samplingPeriod = scanDuration/timeSeriesLength; % time / sample

%-------------------------------------------------------------------------------
bandPower = zeros(numRegions,1);
for i = 1:numRegions
    bandPower(i) = giveMePower(timeSeriesData(:,i),samplingPeriod,numBands,bandOfInterest);
end

end
