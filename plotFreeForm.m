numToPlot = 10;
maxN = 1200;
theColors = {'k'};
lw = 1;

% Load BOLD data:
subfile = load('subs100.mat');
timeSeriesData = givemeTS(subfile.subs100.subs(1),whichHemispheres,false);
timeSeriesData = zscore(timeSeriesData);
timeSeriesData = timeSeriesData';

% Plot as freeform:
f = figure('color','w');
ax = gca;
ax.Box = 'on';
hold(ax,'on');

yr = linspace(1,0,numToPlot+1);
inc = abs(yr(2)-yr(1)); % size of increment
yr = yr(2:end);

pHandles = zeros(numToPlot,1); % keep plot handles
for i = 1:numToPlot
    x = timeSeriesData(i,:);
    N0 = length(x);
    if ~isempty(maxN) && (N0 > maxN)
        % Specified a maximum length of time series to plot
        sti = 1; % randi(N0-maxN,1);
        x = x(sti:sti+maxN-1); % subset random segment
        N = length(x);
    else
        N = N0; % length isn't changing
    end
    xx = (1:N) / maxN;
    xsc = yr(i) + 0.8*(x-min(x))/(max(x)-min(x)) * inc;

    pHandles(i) = plot(xx,xsc,'-','color','k','LineWidth',lw);
end
