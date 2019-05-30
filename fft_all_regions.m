% PHILS SCRIPT
subfile = load('subs100.mat'); 
N = 100;

all_ts = zeros(N,1200,34);

for i = 1:N
    subid = subfile.subs100.subs(i);
    all_ts(i,:,:) = givemeTS(subid);
end

allreg = zeros(N,1200,34);
w = linspace(0,pi,1200);
for i = 1:N
    for j=1:34
        y = squeeze(all_ts(i,:,j));
        allreg(i,:,j) = periodogram(y,hamming(1200),w);
    end
end

all_mean = squeeze(mean(allreg,1));

%% Group WD
grpNS = group_NS();

%% ALL REGIONS PLOT (3rd DIMENSION = WD)
c=jet;
figure; 
hold on
[ind_wd,sorted_wd] = sort(grpNS);
for i=1:size(all_mean,2)
    disp(num2str(i))
    plot3((w/(2*pi)/.72),all_mean(:,sorted_wd(i)),ones(size(w))*grpNS(sorted_wd(i)),'-','LineWidth',1.5,'Color',c(floor(i/34*64),:))
end
hold off
xlabel('Frequency (Hz)')
ylabel('Relative Power')
zlabel('kW')

%% ALL REGIONS PLOT (3rd DIMENSION = GRP VOLUME) AND ROTATE PLOT
load('grpVOL.mat')
c=jet;
figure; 
hold on
for i=1:size(all_mean,2)
    disp(num2str(i))
    plot3((w/(2*pi)/.72),all_mean(:,i),ones(size(w))*grpVOL(i),'-','LineWidth',2,'Color',c(floor(i/34*64),:))
end
hold off
xlabel('Frequency (Hz)')
ylabel('Relative Power')
zlabel('Group Volume')

hPan = [-sin(-pi:.1:pi) sin(-pi:.1:pi)];
vPan = [-cos(-pi:.1:pi) cos(-pi:.1:pi)];
zPan = [-cos(-pi:.1:pi) cos(-pi:.1:pi)];
for k = 1:length(hPan)
camorbit(hPan(k),vPan(k),zPan(k))
pause(.3)
end