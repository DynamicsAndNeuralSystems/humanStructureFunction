function [SCMat,fileName] = givemeSC(subID,edgeType,whatParcellation)

if nargin < 2
   edgeType = 'SIFT2_connectome';
end
if nargin < 3
    whatParcellation = 'DK';
end

% Pick the right file:
switch whatParcellation
    case 'DK'
        %APARC***
        fileName = 'aparc_acpc_connectome_data.mat';
    case 'HCP'
        fileName = 'HCPMMP1_acpc_connectome_data'; %HCP_parc
    case 'cust200'
        fileName = 'custom200_acpc_connectome_data.mat'; %Custom_200
    otherwise
        error('Unknown parcellation: ''%s''',whatParcellation);
end
inFile = load(fileName);

% Pick the right edge measure:
switch edgeType
    case 'SIFT2_density'
        SCMat = inFile.SIFT2_den;
    case 'SIFT2_connectome'
        SCMat = inFile.SIFT2;
    case 'standard_connectome'
        SCMat = inFile.standard;
    case 'standard_density'
        SCMat = inFile.standard_den;
    otherwise
        error('Unknown edge type: ''%s''',edgeType);
end

% Pick the right subject:
if ~isempty(subID)
    indx = (inFile.subs==subID);
    SCMat = SCMat{indx};
end


end
