function dataPlotsForSchematic(doSurfacePlots)
% Produce some useful plots of the data for a schematic figure

if nargin < 1
    doSurfacePlots = false;
end

% Parameters:
whichHemispheres = 'left';
whatParcellation = 'DK'; % 'HCP', 'DK', 'cust200'
surfaceParcellation = 'aparc';
%===============================================================================

% Structural connectivity data:
[~,adjMat] = group_NS(whichHemispheres,whatParcellation,'SIFT2_connectome','consistency');

% Binarize:
adjMatBin = adjMat;
adjMatBin(adjMatBin > 0) = 1;

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
% BOLD data:
subfile = load('subs100.mat');
timeSeriesData = GiveMeTimeSeries(subfile.subs100.subs(1),whichHemispheres,false,whatParcellation);
timeSeriesData = zscore(timeSeriesData);
timeSeriesData = timeSeriesData';
f = figure('color','w');
imagesc(timeSeriesData(ord,:))
caxis([-1.2,1.2])
colormap(gray)
f.Position = [634        1050         366         257];

%-------------------------------------------------------------------------------
% RLFP:
[grpRLFP,RLFPmat] = group_RLFP(whichHemispheres,whatParcellation,5,1);

f = figure('color','w');
imagesc(grpRLFP(ord))
colormap(flipud(BF_getcmap('spectral',10,0)))

if doSurfacePlots
    PlotCDataSurface(BF_NormalizeMatrix(grpRLFP,'scaledSigmoid'),surfaceParcellation,'l','medial');
    PlotCDataSurface(BF_NormalizeMatrix(grpRLFP,'scaledSigmoid'),surfaceParcellation,'l','lateral');
end

%-------------------------------------------------------------------------------
% Node strength, NS
if doSurfacePlots
    NS_scaled = BF_NormalizeMatrix(sum(adjMat,2),'scaledSigmoid');
    PlotCDataSurface(NS_scaled,surfaceParcellation,'l','medial');
    PlotCDataSurface(NS_scaled,surfaceParcellation,'l','lateral');
end

f = figure('color','w');
NS_ord = sum(adjMat(ord,ord),2);
imagesc(log10(NS_ord))
colormap(flipud(BF_getcmap('spectral',10,0)))

end
