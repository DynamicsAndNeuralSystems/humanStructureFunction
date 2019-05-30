% gives a subs x regions colour graphic showing HFP for each individual sub
% with group WD
% load data
grpWD = groupWD;
group_HFP;

f = figure('color','w'); ax = gca;

[sortWD index]=sort(grpWD,'descend');
[sortHFP indexhfp] = sort(grpHFP,'descend')
index2 = [index indexhfp]
sortHFP = HFPmat(index,:);

b=imagesc([BF_NormalizeMatrix([sortHFP repmat(sortWD,1,5)],'maxmin')])
ax.XTick = 8:10:98;
colormap(copper)
xlabel('Participant ID')
ylabel('Region')


