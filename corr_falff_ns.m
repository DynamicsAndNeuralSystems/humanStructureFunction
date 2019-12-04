% Correlating group NS and f-ALFF - gives a scatter of f-ALFF and NS

%-------------------------------------------------------------------------------
% Parameters:
%-------------------------------------------------------------------------------
whichHemispheres = 'left';
edgeType = 'SIFT2_connectome';
groupMethod = 'consistency';
numBands = 5;
bandOfInterest = 1;

%-------------------------------------------------------------------------------
% Load data, compute f-ALFF
%-------------------------------------------------------------------------------
% Compute group NS:
grpNS = group_NS(whichHemispheres,edgeType,groupMethod);

% Compute group f-ALFF:
[grpfALFF,fALFFmat] = group_fALFF(whichHemispheres,numBands,bandOfInterest);

%-------------------------------------------------------------------------------
%% Analysis
%-------------------------------------------------------------------------------
% Correlation (without controlling for region volume)
[r_raw,p_raw] = corr(grpNS,grpfALFF,'type','Spearman');

% Load volume data:
[~,grpVOL] = group_vol(whichHemispheres);

% Partial Correlation (controlling for region volume):
[r_corr,p_corr,resids] = partialcorr_with_resids(grpNS,grpfALFF,grpVOL,'type','Spearman','rows','complete');
grpNS_resid = resids(:,1);
grpfALFF_resid = resids(:,2);

%-------------------------------------------------------------------------------
%% Plotting
%-------------------------------------------------------------------------------
% Scatter plot of NS against f-ALFF (uncorrected)
f = figure('color','w');
plot(grpNS,grpfALFF,'ok','MarkerFaceColor','k','LineWidth',2);
% lsline;
xlabel('Node strength')
ylabel('f-ALFF')
axis('square')
fprintf(1,'Spearman correlation %.3f\n',r_raw);
title({r_raw;p_raw})
%f.Position(3:4) = [256,230];

%-------------------------------------------------------------------------------
% Scatter plot of residual NS against residual f-ALFF
f = figure('color','w');
plot(resids(:,1),resids(:,2),'ok','MarkerFaceColor','k','LineWidth',2);
xlabel('Node strength (residual)')
ylabel('f-ALFF (residual)')
title({r_corr;p_corr})

%% Plot scatter with labels corresponding to regions
[r,p,resids] = partialcorr_with_resids(grpNS,grpfALFF,grpVOL,'type','Spearman','rows','complete');
x = resids(:,1); y = resids(:,2); scatter(x,y);
a = [1:34]'; b = num2str(a); c = cellstr(b);
dx = 0.3; dy = 0.3; % displacement so the text does not overlay the data points
text(x+dx, y+dy, c);

f = figure('color','w');
plot(grpNS_resid,grpfALFF_resid,'ok','MarkerFaceColor','k','LineWidth',2);
xlabel('Node strength (residual)')
ylabel('f-ALFF (residual)')
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

%% Plot region volume against f-ALFF
[r_vol,p_vol] = corr(grpVOL,grpfALFF,'type','Spearman');
f = figure('color','w');
plot(grpVOL,grpfALFF,'ok','MarkerFaceColor','k','LineWidth',2);
xlabel('Group-level volume')
ylabel('f-ALFF')
title({r_vol;p_vol})
