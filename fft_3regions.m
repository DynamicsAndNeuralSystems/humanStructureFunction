% Gives 3 regions (high/med/low freq) FFTs on the same plot to exhibit
% inter-reigonal differences in frequency content

subfile = load('subs100.mat');

N = 100;

for i = 1:N
    subid = subfile.subs100.subs(i);
    ts = givemeTS(subid);

    lowns = ts(:,31);
    mediumns = ts(:,9);
    highns = ts(:,23);

    lowmat(:,i) = lowns;
    mediummat(:,i) = mediumns;
    highmat(:,i) = highns;
end

%% NEW (WITHOUT dividing by sum)
% calc PSD for each sub in the one region (high/med/low)
low = zeros(N,1200);
for i = 1:N
    y = lowmat(:,i);
    w = linspace(0,pi,1200);
    [S_low, w] = periodogram(y,hamming(1200),w);
    low(i,:) = S_low;
end

med = zeros(N,1200);
for i = 1:N
    y = mediummat(:,i);
    w = linspace(0,pi,1200);
    [S_med, w] = periodogram(y,hamming(1200),w);
    med(i,:) = S_med;
end

high = zeros(N,1200);
for i = 1:N
    y = highmat(:,i);
    w = linspace(0,pi,1200);
    [S_high, w] = periodogram(y,hamming(1200),w);
    high(i,:) = S_high;
end

%% OLD: calc PSD for each sub in the one region (high/med/low)
low = zeros(N,1200);
for i = 1:N
    y = lowmat(:,i);
    w = linspace(0,pi,1200);
    [S_low, w] = periodogram(y,hamming(1200),w);
    low(i,:) = S_low./sum(S_low);
end

% MEDIUM WD
med = zeros(N,1200);
for i = 1:N
    y = mediummat(:,i);
    w = linspace(0,pi,1200);
    [S_med, w] = periodogram(y,hamming(1200),w);
    med(i,:) = S_med./sum(S_med);
end

% HIGH WD (> lfp)
high = zeros(N,1200);
for i = 1:N
    y = highmat(:,i);
    w = linspace(0,pi,1200);
    [S_high, w] = periodogram(y,hamming(1200),w);
    high(i,:) = S_high./sum(S_high);
end

low_mean = mean(low);
med_mean = mean(med);
high_mean = mean(high);

%% ALL 3 REGIONS IN ONE PLOT
f = figure('color','w');
plot((w/(2*pi)/.72),low_mean,'.-b','linewidth',2)
hold on
plot((w/(2*pi)/.72),med_mean,'.-m','linewidth',2);
plot((w/(2*pi)/.72),high_mean,'.-k','linewidth',2);
xlabel('Frequency (Hz)')
ylabel('Relative Power')
legend('Frontal Pole (WD=0.31)','Isthmus Cingulate (WD=4.45)','Pre-central (WD=17.12)')
line([.56 .56],[.0007 0],'Color','r','linewidth',3)
line([.69 .69],[.0007 0],'Color','r','linewidth',3)

%% 3D PLOT
c=jet;
figure;
hold on
[ind_wd,sorted_wd] = sort(grpWD);

plot3((w/(2*pi)/.72),low_mean,ones(size(w))*grpWD(1),'.-b','linewidth',2)

%plot3((w/(2*pi)/.72),smooth(low_mean(:,sorted_wd)),ones(size(w))*grpWD(sorted_wd(i)),'-','LineWidth',2,'Color',c(floor(i/34*64),:))

hold off
xlabel('Frequency (Hz)')
ylabel('Relative Power')
zlabel('kW')

hPan = [-sin(-pi:.1:pi) sin(-pi:.1:pi)];
vPan = [-cos(-pi:.1:pi) cos(-pi:.1:pi)];
zPan = [-cos(-pi:.1:pi) cos(-pi:.1:pi)];
for k = 1:length(hPan)
camorbit(hPan(k),vPan(k),zPan(k))
pause(.3)
end
