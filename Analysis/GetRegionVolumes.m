function volumes = GetRegionVolumes(subID,dataParams)
% Get volume vector for a given subject
%-------------------------------------------------------------------------------

%% Settings
if nargin < 2
    params = GiveMeDefaultParams();
    dataParams = params.data;
end

%-------------------------------------------------------------------------------
% Load the data:
%-------------------------------------------------------------------------------
switch dataParams.whatParcellation
case {'DK','aparc'}
    fileName = fullfile('Data','volume','DK',sprintf('%u.nii',subID));
case 'HCP'
    fileName = fullfile('Data','volume','HCP',sprintf('%u',subID),'HCPMMP1_standard.nii');
case 'cust200'
    fileName = fullfile('Data','volume','cust200',sprintf('%u',subID),'custom200_standard.nii');
end

% Load the image file
inFile = load_nii(fileName);
VOL = inFile.img;

% Compute volumes of each area from loaded nifti file:
switch dataParams.whichHemispheres
    case 'both'
        regionIDs = 1:dataParams.numAreas;
    case 'left'
        regionIDs = 1:dataParams.numAreas/2;
    case 'right'
        regionIDs = dataParams.numAreas/2+1:dataParams.numAreas;
end

% Compute:
volumes = zeros(length(regionIDs),1);
for j = 1:numAreas
    volumes(j) = nnz(VOL==j);
end

end
