function [timescaleMatDecay, timescaleMatArea] = group_timescale(whichHemispheres,whatParcellation)
% Compute a group-average timescale measure
%-------------------------------------------------------------------------------


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
            timescaleMatDecay(j,i) = NaN;
            timescaleMatArea(j,i) = NaN;
        else
            timescaleMatDecay(j,i) = out.decayTimescale;
            timescaleMatArea(j,i) = out.sumacf;
        end
    end
end

% Compute mean (across subjects) in every ROI:
% meanTimescale = nanmean(timescaleMat,2);

end
