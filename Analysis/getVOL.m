function VOL = getVOL(subID,whichHemispheres)
% Get volume vector for a given subject
%-------------------------------------------------------------------------------

%% Settings
if nargin < 2
    whichHemispheres = 'left'; % 'right','both','left'
end

%-------------------------------------------------------------------------------
% Load the data:
%-------------------------------------------------------------------------------
fileName = fullfile('Data','volume',sprintf('%u.nii',subID));
%fileName = fullfile('Data','volHCP',sprintf('%d',subID),'HCPMMP1_standard.nii'); % CHANGE THIS***
%fileName = fullfile('Data','vol200',sprintf('%d',subID),'custom200_standard.nii');

addpath('niftiFunctions');
inFile = load_nii(fileName);
VOL = inFile.img;

% Compute volumes of each area from loaded nifti file:
numAreas = 34; 
VOLMat = zeros(numAreas,1);
for j = 1:numAreas
    VOLMat(j) = nnz(VOL==j);
end

% Filter by hemisphere:
switch whichHemispheres
    case 'both'
        VOL = VOLMat;
    case 'left'
        VOL = VOLMat(1:34);
    case 'right'
        VOL = VOLMat(35:68);
end

end
