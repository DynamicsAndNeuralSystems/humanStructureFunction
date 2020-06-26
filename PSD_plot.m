function PSD_plot(params)
% Gives Power SPectral Density (PSD) Curves for 3 representative regions

if nargin < 1
    params = GiveMeDefaultParams();
end

%-------------------------------------------------------------------------------
% Pick the three nodes (low, medium, high WD):
selectedRegionIDs = [13,19,28];
regionNames = {'Medial Orbitofrontal','Pars Triangularis','Superior Parietal'};
numRegions = length(selectedRegionIDs);

%-------------------------------------------------------------------------------
% Load subject data
%-------------------------------------------------------------------------------
subFile = load(params.data.subjectInfoFile);
subIDList = subFile.subs100.subs; % vector of data
numSubjects = length(subIDList);
tsExample = GiveMeTimeSeries(subFile.subs100.subs(1));
numTimePoints = size(tsExample,1);

samplingPeriod = params.data.scanDuration/numTimePoints;

%-------------------------------------------------------------------------------
% Retrieve time-series for 3 regions (low, medium and high WD)
lowMat = zeros(numTimePoints,numSubjects);
mediumMat = zeros(numTimePoints,numSubjects);
highMat = zeros(numTimePoints,numSubjects);
for i = 1:numSubjects
    subID = subIDList(i);
    ts = GiveMeTimeSeries(subID,params.data);

    lowMat(:,i) = ts(:,selectedRegionIDs(1));
    mediumMat(:,i) = ts(:,selectedRegionIDs(2));
    highMat(:,i) = ts(:,selectedRegionIDs(3));
end

%-------------------------------------------------------------------------------
% Calculate PSD for each sub in the one region (high/med/low)
w = linspace(0,pi,numTimePoints);
frequency = (w/(2*pi)/samplingPeriod);

low = zeros(numSubjects,numTimePoints);
med = zeros(numSubjects,numTimePoints);
high = zeros(numSubjects,numTimePoints);
for i = 1:numSubjects
    for j = 1:numRegions
        switch j
        case 1
            y = lowMat(:,i);
        case 2
            y = mediumMat(:,i);
        case 3
            y = highMat(:,i);
        end
        [S,w] = periodogram(y,hamming(numTimePoints),w);
        switch j
        case 1
            low(i,:) = S;
        case 2
            med(i,:) = S;
        case 3
            high(i,:) = S;
        end
    end
end

low_mean = mean(low);
med_mean = mean(med);
high_mean = mean(high);

%-------------------------------------------------------------------------------
%% ALL 3 REGIONS IN ONE PLOT
lw = 1.5;
f = figure('color','w');
ax = gca;
colors = GiveMeColors('lowMediumHigh');
hold('on')
plot(frequency,low_mean,'-','color',colors(1,:),'LineWidth',lw)
plot(frequency,med_mean,'-','color',colors(2,:),'LineWidth',lw);
plot(frequency,high_mean,'-','color',colors(3,:),'LineWidth',lw);
xlabel('Frequency (Hz)')
ylabel('Power spectral density')
legend(regionNames)
ax.XLim = [0,0.4];
f.Position(3:4) = [330,230];
%line([.56 .56],[.0007 0],'Color','r','linewidth',3)
%line([.69 .69],[.0007 0],'Color','r','linewidth',3)
%fill([x(240:300) x(300) x(240)],[y(240:300) 0 0],'r')

end
