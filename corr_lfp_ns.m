% Correlating group NS and LFP - gives a scatter of LFP and NS

%-------------------------------------------------------------------------------
% Parameters:
%-------------------------------------------------------------------------------
whichHemispheres = 'left';
whatParcellation = 'DK';
edgeType = 'SIFT2_connectome';
groupMethod = 'consistency';
numBands = 5;
bandOfInterest = 1;

%-------------------------------------------------------------------------------
% Load data, compute LFP
%-------------------------------------------------------------------------------
% Compute group NS:
grpNS = group_NS(whichHemispheres,edgeType,groupMethod);

% Compute group LFP:
[grpLFP,LFPmat] = group_LFP(whichHemispheres,whatParcellation,numBands,bandOfInterest);

%-------------------------------------------------------------------------------
%% Analysis
%-------------------------------------------------------------------------------
% Correlation (without controlling for region volume)
[r_raw,p_raw] = corr(grpNS,grpLFP,'type','Spearman');

% Load volume data:
[~,grpVOL] = group_vol(whichHemispheres);

% Partial Correlation (controlling for region volume):
[r_corr,p_corr,resids] = partialcorr_with_resids(grpNS,grpLFP,grpVOL,'type','Spearman','rows','complete');
grpNS_resid = resids(:,1);
grpLFP_resid = resids(:,2);

%-------------------------------------------------------------------------------
%% Plotting
%-------------------------------------------------------------------------------
% Scatter plot of NS against LFP (uncorrected)
f = figure('color','w');
plot(grpNS,grpLFP,'ok','MarkerFaceColor','k','LineWidth',2);
% lsline;
xlabel('Node strength')
ylabel('Low frequency power')
axis('square')
fprintf(1,'Spearman correlation %.3f\n',r_raw);
title({r_raw;p_raw})
f.Position(3:4) = [256,230];

%-------------------------------------------------------------------------------
% Scatter plot of residual NS against residual LFP
f = figure('color','w');
plot(resids(:,1),resids(:,2),'ok','MarkerFaceColor','k','LineWidth',2);
xlabel('Node Strength residual')
ylabel('Low Frequency Power residual')
title({r_corr;p_corr})

%% Plot scatter with labels corresponding to regions
[r,p,resids] = partialcorr_with_resids(grpNS,grpLFP,grpVOL,'type','Spearman','rows','complete');
x = resids(:,1); y = resids(:,2); scatter(x,y);
a = [1:34]'; b = num2str(a); c = cellstr(b);
dx = 0.3; dy = 0.3; % displacement so the text does not overlay the data points
text(x+dx, y+dy, c);

f = figure('color','w');
plot(grpNS_resid,grpLFP_resid,'ok','MarkerFaceColor','k','LineWidth',2);
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
[r_vol,p_vol] = corr(grpVOL,grpLFP,'type','Spearman');
f = figure('color','w');
plot(grpVOL,grpLFP,'ok','MarkerFaceColor','k','LineWidth',2);
xlabel('Group-level volume')
ylabel('Low Frequency Power')
title({r_vol;p_vol})
