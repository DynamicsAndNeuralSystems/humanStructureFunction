% Plots the time series and FFTs of two example brian regions (1 high freq and 1 low freq).
% HFP area is shaded in to exhibit how HFP is calculated and how it differs
% between regions (red = high HFP, blue = low HFP)
% NB: time series and FFTs do not match up - i.e. they are from different
% regions/different subs

%% Get the time series
subID = 127630; % 101410;
% Time series length
tsLength = 300; % 200 % TS length

% Load in time-series data for a given subject
timeSeriesData = givemeTS(subID);

% low frequency (region 23)
f = figure('color','w');
plot(timeSeriesData(1:tsLength,23),'b-','LineWidth',1.2)
ylabel('Amplitude')
xlabel('Samples')

% high frequency (region 5)
f = figure('color','w');
plot(timeSeriesData(1:tsLength,5),'r-','LineWidth',1.2)
ylabel('Amplitude')
xlabel('Samples')

%-------------------------------------------------------------------------------
%% Calulate and plot FFTs
% LOW frequency - sub 101410, region 30
reg = 30; %which region to plot

% calculate FFT
Y = timeSeriesData(1:tsLength,reg);
w = linspace(0,pi,tsLength);
[S, w] = periodogram(Y,hamming(tsLength),w);
amp = S./sum(S);

% Plot FFT
x = (w/(2*pi)/.72);
y = amp;
f = figure('color','w');
plot((w/(2*pi)/.72),amp,'-k','LineWidth',1.5)
hold on
fill([x(240:300) x(300) x(240)],[y(240:300) 0 0],'b')
ylabel('Power (dB/Hz)');
xlabel('Frequency (Hz)');
ylim([0,0.025]);

%-------------------------------------------------------------------------------
%% HIGH frequency
% sub 111312, region 5
reg = 5 % which region to plot

% load in ts data
%subID = 111312;
% load in data for one sub
timeSeriesData = givemeTS(subID);

% calculate FFT
Y = timeSeriesData(1:tsLength,reg);
w = linspace(0,pi,tsLength);
[S, w] = periodogram(Y,hamming(tsLength),w);
amp = S./sum(S);

% Plot FFT
x=(w/(2*pi)/.72);
y = amp;
figure; plot((w/(2*pi)/.72),amp,'-k','LineWidth',1.5)
hold on
fill([x(240:300) x(300) x(240)],[y(240:300) 0 0],'r')
ylabel('Power (dB/Hz)');
xlabel('Frequency (Hz)');
ylim([0 .025]);
