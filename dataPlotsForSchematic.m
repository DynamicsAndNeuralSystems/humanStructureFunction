% dataPlotsForSchematic

% Parameters:
whichHemispheres = 'left';
whatParcellation = 'DK'; % 'HCP', 'DK', 'cust200'

% Structural connectivity data:
[~,adjMat] = group_NS(whichHemispheres,whatParcellation,'SIFT2_connectome','consistency');

adjMatBin = adjMat;
adjMatBin(adjMatBin>0) = 1;

allEdges = adjMat(triu(true(size(adjMatBin))));
connectomeDensity = mean(adjMatBin(triu(true(size(adjMatBin)))));
minEdgeWeight = min(allEdges(allEdges>0));
maxEdgeWeight = max(allEdges(allEdges>0));

% Get reordering for fun:
ord = BF_ClusterReorder(adjMatBin,'euclidean','average');

% Plot the data as adjacency matrix:
f = figure('color','w');
imagesc(log10(adjMat(ord,ord)))
colormap([0,0,0;flipud(BF_getcmap('spectral',10,0))])
axis('square')
caxis([2,max(log10(adjMat(:)))])
f.Position = [634        1050         366         257];

%-------------------------------------------------------------------------------
% NS
NS_scaled = BF_NormalizeMatrix(sum(adjMat,2),'scaledSigmoid');
PlotCDataSurface(NS_scaled,whatParcellation,'l','medial');
PlotCDataSurface(NS_scaled,whatParcellation,'l','lateral');

f = figure('color','w');
NS_ord = sum(adjMat(ord,ord),2);
imagesc(log10(NS_ord))
colormap(flipud(BF_getcmap('spectral',10,0)))

%-------------------------------------------------------------------------------
% BOLD data:
subfile = load('subs100.mat');
timeSeriesData = givemeTS(subfile.subs100.subs(1),whichHemispheres,false,whatParcellation);
timeSeriesData = zscore(timeSeriesData);
timeSeriesData = timeSeriesData';
f = figure('color','w');
imagesc(timeSeriesData(ord,:))
caxis([-1.2,1.2])
colormap(gray)
f.Position = [634        1050         366         257];

%-------------------------------------------------------------------------------
[grpLFP,LFPmat] = group_LFP(whichHemispheres,whatParcellation,5,1);
PlotCDataSurface(BF_NormalizeMatrix(grpLFP,'scaledSigmoid'),whatParcellation,'l','medial');
PlotCDataSurface(BF_NormalizeMatrix(grpLFP,'scaledSigmoid'),whatParcellation,'l','lateral');

%-------------------------------------------------------------------------------
% LFP
f = figure('color','w');
imagesc(grpLFP(ord))
colormap(flipud(BF_getcmap('spectral',10,0)))
