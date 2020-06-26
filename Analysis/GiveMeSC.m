function [SCMat,fileName] = GiveMeSC(subID,dataParams)
% Pull a structural connectivity matrix for a given subject from file
%-------------------------------------------------------------------------------
if nargin < 2
    params = GiveMeDefaultParams();
    dataParams = params.data;
end

%-------------------------------------------------------------------------------
% Pick the right file:
switch dataParams.whatParcellation
    case {'DK','aparc'}
        % APARC
        fileName = 'aparc_acpc_connectome_data.mat';
    case 'HCP'
        % HCP
        fileName = 'HCPMMP1_acpc_connectome_data';
    case 'cust200'
        % Custom_200
        fileName = 'custom200_acpc_connectome_data.mat';
    otherwise
        error('Unknown parcellation: ''%s''',whatParcellation);
end
% inFile = load(fileName);

%-------------------------------------------------------------------------------
% Pick the right edge measure:
switch dataParams.edgeType
    case 'SIFT2_density'
        load(fileName,'SIFT2_den');
        SCMat = SIFT2_den;
    case 'SIFT2_connectome'
        load(fileName,'SIFT2');
        SCMat = SIFT2;
    case 'standard_connectome'
        load(fileName,'standard');
        SCMat = standard;
    case 'standard_density'
        load(fileName,'standard_den');
        SCMat = standard_den;
    otherwise
        error('Unknown edge type: ''%s''',edgeType);
end

%-------------------------------------------------------------------------------
% Pick the appropriate subject (otherwise return all):
if ~isempty(subID)
    load(fileName,'subs');
    indx = (subs==subID);
    SCMat = SCMat{indx};
end

end
