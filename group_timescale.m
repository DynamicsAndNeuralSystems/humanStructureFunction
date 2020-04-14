function [timescaleMatDecay, timescaleMatArea] = group_timescale(whichHemispheres,whatParcellation)
% Compute a group-average timescale measure
%-------------------------------------------------------------------------------
if nargin < 1
    whichHemispheres = 'left';
end
if nargin < 2
    whatParcellation = 'HCP';
end
%-------------------------------------------------------------------------------

% Load data:
subfile = load('subs100.mat');
numSubjects = length(subfile.subs100.subs);
timeSeriesData = givemeTS(subfile.subs100.subs(1),whichHemispheres,false,whatParcellation);
numROIs = size(timeSeriesData,2);

% Compute LFP feature in every ROI of every subject:
timescaleMatDecay = zeros(numROIs,numSubjects);
timescaleMatArea = zeros(numROIs,numSubjects);
for i = 1:numSubjects
    fprintf(1,'Subject %u/%u\n',i,numSubjects);
    subID = subfile.subs100.subs(i);
    timeSeriesData = givemeTS(subID,whichHemispheres,false,whatParcellation);
    numRegions = size(timeSeriesData,2);
    for j = 1:numRegions
        out = CO_AutoCorrShape(zscore(timeSeriesData(:,j)),'posDrown');
        if ~isstruct(out) & isnan(out)
            timescaleMat(j,i) = NaN;
        else
            timescaleMatDecay(j,i) = 1/out.fexpabsacf_b;
            timescaleMatArea(j,i) = out.sumacf;
        end
    end
end

% Compute mean (across subjects) in every ROI:
% meanTimescale = nanmean(timescaleMat,2);

end
