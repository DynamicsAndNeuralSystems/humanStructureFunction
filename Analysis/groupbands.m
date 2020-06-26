% gives scatter of correlation strengths for WD against 14 evenly spaced
% frequency bands, controlling for region volume

% load subfile
subfile = load('subs98.mat');

N = size(subfile.subs98,1); % number of subs
numBands = 14; % 14 ~ .05 Hz bands

for j = 1:numBands
    for i = 1:N
        subid = subfile.subs98.subs98(i);
        bands = getfreq(subid,numBands);
        band(j).mat(:,i) = bands(j).band;
    end
end

% group averages
for j = 1:numBands
    band(j).grp = mean(band(j).mat,2);
end

% load in group volume and WD data
group_vol;
grpWD = group_WD;

% Partial correlation between group WD and group frequency bands
for j = 1:numBands
    [r(j) p(j)] = partialcorr(band(j).grp,grpWD,grpVOL,'type','spearman');
end

% Plot correlations across bands
marker = [0.5:14];
f = figure('color','w');
lot(marker,r,'-bo','linewidth',2,'MarkerSize',8);
line([0 14],[0 0])
xlabel('Frequency Band (Hz)')
xticks([0:14])
xticklabels(linspace(0,.6944,15))
xtickangle(90)
ylabel('Spearman Correlation')
title('Correlation between WD and 14 Frequency Bands')
ylim([-0.7 0.7])
