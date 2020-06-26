function bandPower = getFreqBand(subID,params,doRandomize)
% Computes low frequency power across ROIs for a given subject
%-------------------------------------------------------------------------------

% Check Inputs:
if nargin < 2
    params = GiveMeDefaultParams();
end
if nargin < 3
    doRandomize = false;
end
%-------------------------------------------------------------------------------
% Load in BOLD data
timeSeriesData = GiveMeTimeSeries(subID,dataParams,doRandomize);
[timeSeriesLength,numRegions] = size(timeSeriesData);

% Compute sampling frequency (time / sample)
samplingPeriod = params.data.scanDuration/timeSeriesLength;

%-------------------------------------------------------------------------------
% Compute band power across brain regions:
% (details of the band is set in GiveMeDefaultParams)
bandPower = zeros(numRegions,1);
for i = 1:numRegions
    bandPower(i) = giveMePower(timeSeriesData(:,i),samplingPeriod,...
                params.rlfp.numBands,params.rlfp.bandOfInterest);
end

end
