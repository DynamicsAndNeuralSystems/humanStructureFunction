function NS = getNS(subID,whichHemispheres,whatParcellation,edgeType)

%-------------------------------------------------------------------------------
if nargin < 2
    whichHemispheres = 'left';
end
if nargin < 3
    whatParcellation = 'DK';
end
if nargin < 4
    edgeType = 'SIFT2_connectome';
    fprintf(1,'USING SIFT2_density BY DEFAULT\n');
end

%-------------------------------------------------------------------------------
% Load in data
connDataWeighted = givemeSC(subID,edgeType,whatParcellation);

% Get ROI conn data
switch whichHemispheres
    case 'both'
        connDataWeighted = givemeSC(subID);
    case 'left'
        connDataWeighted = connDataWeighted(1:end/2,1:end/2);
    case 'right'
        connDataWeighted = connDataWeighted';
        connDataWeighted = connDataWeighted(1:end/2,1:end/2);
end

NS = sum(connDataWeighted)';

end
