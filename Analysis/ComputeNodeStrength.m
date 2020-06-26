function NS = ComputeNodeStrength(subID,dataParams)
% Get node strength for a given subject, subID
%-------------------------------------------------------------------------------

if nargin < 2
    params = GiveMeDefaultParams();
    dataParams = params.data;
end

%-------------------------------------------------------------------------------
% Load in data:
connDataWeighted = GiveMeSC(subID,dataParams);

%-------------------------------------------------------------------------------
% Get ROI conn data
switch dataParams.whichHemispheres
    case 'both'
        connDataWeighted = givemeSC(subID);
    case 'left'
        connDataWeighted = connDataWeighted(1:end/2,1:end/2);
    case 'right'
        connDataWeighted = connDataWeighted';
        connDataWeighted = connDataWeighted(1:end/2,1:end/2);
end

%-------------------------------------------------------------------------------
% Compute node strength as sum:
NS = sum(connDataWeighted)';

end
