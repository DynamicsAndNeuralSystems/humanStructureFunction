% Gives histogram of rho values between group-level node strength and hctsa
% features

%-------------------------------------------------------------------------------
% Load data
load('hctsa_stats.mat','rho','part_rho','part_pvals');

%-------------------------------------------------------------------------------
%% Correcting using mafdr (false discovery rate)
mafdr_pvals = mafdr(part_pvals,'BHFDR','true');
total_sig_corrs = sum(mafdr_pvals < 0.05);
sigThreshold_FDR = min(abs(part_rho(mafdr_pvals < 0.05)));
LFP_rank = sum(abs(part_rho)>0.53714);

%-------------------------------------------------------------------------------
% Histogram of partial rho values
f = figure('color','w');
box('on')
hold('on')
ax = gca();
h = histogram(abs(part_rho));
h.EdgeColor = 'k';
h.FaceColor = 'w';
h.LineWidth = 1.5;
xlabel('Partial Spearman correlation')
ylabel('Number of features')
% title('Correlating hctsa features with group-level node strength')
plot(0.537*ones(2,1),[0,1500],'color','red','LineWidth',2)
plot(sigThreshold_FDR*ones(2,1),[0,1500],'color','green','LineWidth',2)
f.Position(3:4) = [342,230];

%-------------------------------------------------------------------------------
%% Histogram of rho values
f = figure('color','w');
ax = gca();
h = histogram(rho);
h.EdgeColor = 'k';
h.FaceColor = 'w';
h.LineWidth = 1.5;
xlabel('Spearman correlation')
ylabel('Number of hctsa features')
title('Correlating hctsa features with group-level node strength')
line(-0.752*ones(2,1),ax.YLim,'color','red','LineWidth',2)
f.Position(3:4) = [342,230];
