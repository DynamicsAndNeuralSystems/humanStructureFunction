function params = GiveMeDefaultParams()

% Data
params.data.subjectInfoFile = 'subs100.mat';
params.data.scanDuration = 864; % (s)

params.data.whichHemispheres = 'left';
params.data.whatParcellation = 'DK'; % 'cust200', 'HCP'
params.data.edgeType = 'SIFT2_connectome';

% Compute useful constant, numAreas, from parcellation
switch dataParams.whatParcellation
case {'DK','aparc'}
    params.data.numAreas = 34*2;
case 'HCP'
    params.data.numAreas = 180*2;
case 'cust200'
    params.data.numAreas = 100*2;
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
