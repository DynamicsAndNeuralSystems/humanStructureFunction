% makes group connectome using Roberts variance method
function [groupAdj, consist] = giveMeGroupAdj_variance(connectomes, dens, whichHemispheres)

if nargin < 3
    whichHemispheres = 'left';
end
    
M = zeros(size(connectomes{1},1),size(connectomes{1},2),size(connectomes,2));
nSubs = size(connectomes,2);
d = zeros(nSubs,1);
for i=1:nSubs
    M(:,:,i) = connectomes{i};
    d(i) = density_und(connectomes{i});
end
dMean = mean(d);

% if density is specified, use that value
if nargin >1
    dMean = dens;
end
    [groupAdj, consist] = threshold_consistency(M, dMean);

switch whichHemispheres
    case 'left'
        groupAdj = groupAdj(1:34,1:34);
    case 'right'
        groupAdj = groupAdj(35:68,35:68);
    case 'both'
        groupAdj = groupAdj(:,:);
end
end
