
whatTimeSeriesMeasure = 'timescale';
whatTimeScale = 'decay';
whichHemispheres = 'left';
whatParcellation = 'DK';
edgeType = 'SIFT2_connectome';
groupMethod = 'consistency';
numBands = 5;
bandOfInterest = 1;

% Compute group LFP/timescales:
[grpLFP,LFPMat] = group_LFP(whichHemispheres,whatParcellation,numBands,bandOfInterest);
[meanfALFF, fALFFmat] = group_fALFF(whichHemispheres,numBands,bandOfInterest);
[timescaleMatDecay,timescaleMatArea] = group_timescale(whichHemispheres,whatParcellation);
grpTimeScaleDecay = nanmean(timescaleMatDecay,2);
grpTimeScaleArea = nanmean(timescaleMatArea,2);

f = figure('color','w');
allTogether = [grpLFP,meanfALFF,grpTimeScaleDecay,grpTimeScaleArea];
names = {'RLFP','fALFF','Timescale (decay)','Timescale (area)'}
[S,AX,BigAx,H,HAx] = plotmatrix(allTogether)
AX(2,1).YLabel.String = names{2};
AX(3,1).YLabel.String = names{3};
AX(4,1).YLabel.String = names{4};
AX(4,1).XLabel.String = names{1};
AX(4,2).XLabel.String = names{2};
AX(4,3).XLabel.String = names{3};
AX(4,4).XLabel.String = names{4};


% f = figure('color','w');
% plot(grpLFP,grpTimescaleDecay)
for i = 1:4
    for j = i+1:4
        [r,p] = corr(allTogether(:,i),allTogether(:,j));
        fprintf(1,'%s--%s: r = %g, p = %g\n',names{i},names{j},r,p);
    end
end
