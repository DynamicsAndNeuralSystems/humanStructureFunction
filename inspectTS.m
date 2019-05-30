N= 5
subfile = load('subs100.mat');

for i = 1:N
	subid = subfile.subs100.subs(i);
    timeSeriesSubject_i = givemeTS(subid); % assume this is ROI x time
	timeSeriesSubject_i_z = zscore(timeSeriesSubject_i)';
	subplot(5,1,i);
	imagesc(timeSeriesSubject_i_z);
colormap(gray)
caxis([-1.5,1.5])
end

