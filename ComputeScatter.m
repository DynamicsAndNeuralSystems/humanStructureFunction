function ComputeScatter(params,whatTimeSeriesMeasure)
% Correlating group NS and LFP - gives a scatter of RLFP and NS

%-------------------------------------------------------------------------------
% Parameters:
%-------------------------------------------------------------------------------
if nargin < 1
    params = GiveMeDefaultParams();
end
if nargin < 2
    whatTimeSeriesMeasure = 'timescale';
end

%-------------------------------------------------------------------------------
% Load data, compute LFP
%-------------------------------------------------------------------------------
% Compute group NS:
grpNS = GroupNodeStrength(params.data);

switch whatTimeSeriesMeasure
case 'RLFP'
    % Compute group LFP:
    [grpTSstat,TSstatMat] = GroupRLFP(whichHemispheres,whatParcellation,numBands,bandOfInterest);
case 'timescale'
    % Compute timescale:
    [timescaleMatDecay,timescaleMatArea] = group_timescale(whichHemispheres,whatParcellation);
    switch whatTimeScale
        case 'decay' % as Murray
            grpTSstat = nanmean(timescaleMatDecay,2);
        case 'area' % as Watanabe
            grpTSstat = nanmean(timescaleMatArea,2);
    end
otherwise
    error('Unknown time series feature, ''%s''',whatTimeSeriesMeasure);
end

%-------------------------------------------------------------------------------
%% Analysis
%-------------------------------------------------------------------------------
% Correlation (without controlling for region volume)
[r_raw,p_raw] = corr(grpNS,grpTSstat,'type','Spearman');

% Load volume data:
[~,grpVOL] = group_vol(whichHemispheres);

% Partial Correlation (controlling for region volume):
[r_corr,p_corr,resids] = partialcorr_with_resids(grpNS,grpTSstat,grpVOL,'type','Spearman','rows','complete');
grpNS_resid = resids(:,1);
grpTSstat_resid = resids(:,2);

%-------------------------------------------------------------------------------
%% Plotting
%-------------------------------------------------------------------------------
% Scatter plot of NS against LFP (uncorrected)
f = figure('color','w');
plot(grpNS,grpTSstat,'ok','MarkerFaceColor','k','LineWidth',2);
% lsline;
xlabel('Node strength')
ylabel(whatTimeSeriesMeasure)
% ylabel('Low frequency power')
axis('square')
fprintf(1,'Spearman correlation %.3f\n',r_raw);
title({r_raw;p_raw})
f.Position(3:4) = [256,230];

%-------------------------------------------------------------------------------
% Scatter plot of residual NS against residual LFP
f = figure('color','w');
plot(resids(:,1),resids(:,2),'ok','MarkerFaceColor','k','LineWidth',2);
xlabel('Node Strength residual')
ylabel(sprintf('%s residual',whatTimeSeriesMeasure))
% ylabel('Low Frequency Power residual')
title({r_corr;p_corr})

%% Plot scatter with labels corresponding to regions
[r,p,resids] = partialcorr_with_resids(grpNS,grpTSstat,grpVOL,'type','Spearman','rows','complete');
x = resids(:,1); y = resids(:,2); scatter(x,y);
a = [1:34]'; b = num2str(a); c = cellstr(b);
dx = 0.3; dy = 0.3; % displacement so the text does not overlay the data points
text(x+dx, y+dy, c);

f = figure('color','w');
plot(grpNS_resid,grpTSstat_resid,'ok','MarkerFaceColor','k','LineWidth',2);
xlabel('Node strength (residual)')
ylabel('Low frequency power (residual)')
fprintf(1,'Spearman correlation %.3f\n',r_corr);
f.Position(3:4) = [256,230];

% Add text labels corresponding to regions
doAddLabels = true;
if doAddLabels
    a = [1:34]';
    b = num2str(a);
    c = cellstr(b);
    dx = 0.3;
    dy = 0.3; % displacement so the text does not overlay the data points
    text(x+dx,y+dy,c);
end

%% Plot region volume against LFP
[r_vol,p_vol] = corr(grpVOL,grpTSstat,'type','Spearman');
f = figure('color','w');
plot(grpVOL,grpTSstat,'ok','MarkerFaceColor','k','LineWidth',2);
xlabel('Group-level volume')
ylabel('Low Frequency Power')
title({r_vol;p_vol})

end
