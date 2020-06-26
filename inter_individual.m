% Individual-level correlations
%-------------------------------------------------------------------------------

%-------------------------------------------------------------------------------
% Parameters:
whichHemispheres = 'left';
edgeType = 'SIFT2_connectome';
numBands = 5;
bandOfInterest = 1; % LFP
%-------------------------------------------------------------------------------

%-------------------------------------------------------------------------------
% Load in subject data:
subfile = load('subs100.mat');
numSubjects = length(subfile.subs100.subs);

%-------------------------------------------------------------------------------
% Analysis
% Calculate raw_rp and corr_rp for each individual subject
for i = 1:numSubjects
    subID = subfile.subs100.subs(i);

    NS = ComputeNodeStrength(subID,whichHemispheres,edgeType);
    LFP = getFreqBand(subID,whichHemispheres,false,numBands,bandOfInterest);
    VOL = getVOL(subID,whichHemispheres);

    % corr without controlling for region volume
    [raw_rp(i,1),raw_rp(i,2)] = corr(LFP,NS,'type','Spearman');

    % partial corr controlling for region volume:
    [corr_rp(i,1),corr_rp(i,2)] = partialcorr(LFP,NS,VOL,'type','Spearman');
end

%-------------------------------------------------------------------------------
%% Plot histogram
%-------------------------------------------------------------------------------
%% Histogram of individual-specific partial correlations:
f = figure('color','w');
ax = gca();
h = histogram(corr_rp(:,1),'numBins',15);
h.EdgeColor = 'k';
h.FaceColor = 'w';
h.LineWidth = 1.5;
xlabel('Partial Spearman correlation')
ylabel('Number of participants')
line([0.537,0.537],[0,15],'color','red','LineWidth',2)
f.Position(3:4) = [342,230];

%-------------------------------------------------------------------------------
%% part_rho
% f = figure('color','w');
% h = histogram(rho);
% h.EdgeColor = 'k';
% h.FaceColor = 'b';
% h.LineWidth = 2;
% xlabel('Spearman correlation')
% ylabel('Number of hctsa features')
% title('Correlating hctsa features with group-level node strength')
% line([-.752,-.752],[0,1400],'color','red','LineWidth',4)
