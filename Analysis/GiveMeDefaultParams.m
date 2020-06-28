function params = GiveMeDefaultParams(whatParcellation)

if nargin < 1
    whatParcellation = 'DK'; % 'cust200', 'HCP'
end

% Data
params.data.subjectInfoFile = 'subs100.mat';
params.data.scanDuration = 864; % (s)

params.data.whichHemispheres = 'left';
params.data.whatParcellation = whatParcellation;
params.data.edgeType = 'SIFT2_connectome';

% Compute useful constant, numAreas, from parcellation
switch params.data.whatParcellation
case {'DK','aparc'}
    params.data.numAreasTotal = 34*2;
case 'HCP'
    params.data.numAreasTotal = 180*2;
case 'cust200'
    params.data.numAreasTotal = 100*2;
end
switch params.data.whichHemispheres
case {'left','right'}
    params.data.numAreas = params.data.numAreasTotal/2;
case 'both'
    params.data.numAreas = params.data.numAreasTotal;
end

% Consistency-based group connectome parameters
params.data.groupMethod = 'consistency';
params.data.threshold = 0.75; % consistency threshold as per Van den Heuvel & Sporns (2011)
params.data.dens = 0.29; % density threshold for variance method (if > .29, then values don't change)

% RLFP
params.rlfp.numBands = 5;
params.rlfp.bandOfInterest = 1;

% Timescale metric
params.timescale.whatTimeScale = 'decay';

end
