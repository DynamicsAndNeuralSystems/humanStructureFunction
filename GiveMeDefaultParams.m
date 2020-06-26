function params = GiveMeDefaultParams()

% Data
params.data.subjectInfoFile = 'subs100.mat';
params.data.scanDuration = 864; % (s)

params.data.whichHemispheres = 'left';
params.data.whatParcellation = 'DK';
params.data.edgeType = 'SIFT2_connectome';

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
