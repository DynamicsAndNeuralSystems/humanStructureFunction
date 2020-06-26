function powerInBand = giveMePower(y,samplingPeriod,numBands,bandOfInterest)
%-------------------------------------------------------------------------------
% Check inputs and set defaults:
if nargin < 3
    numBands = 5;
end
if nargin < 4
    bandOfInterest = 1;
end
%-------------------------------------------------------------------------------

% Get the frequency index
sampleFreq = 1/samplingPeriod;
N = length(y);

% Detrend and normalize variance
y = zscore(detrend(y));

% Compute frequency in the band of interest:
bandIntervals = linspace(0,sampleFreq/2,numBands+1);
bandFreqRange = bandIntervals(bandOfInterest:bandOfInterest+1);
powerInBand = bandpower(y,sampleFreq,bandFreqRange);

% totalPower = bandpower(y,sampleFreq,[0,sampleFreq/2]);

%-------------------------------------------------------------------------------
% ?? Zero padding
% paddedLength = 2^nextpow2(sampleLength);
% y = [y; zeros(paddedLength - sampleLength,1)];
% N = sampleLength;

% % Compute power spectrum:
% [S,F] = periodogram(y,[],N,sampleFreq,'power');
%
% totalArea = trapz(S);
%
% freqVector = (0:1/N:1/2-1/N)*sampleFreq; % frequency vector
% deltaF = sampleFreq/N;
% totalArea = trapz(S)*(deltaF);
%
% % Perform FFT:
% Y = abs(fft(y,N)); % amplitude spectrum
% S = Y.^2/N; % power spectrum
% % freqVector = (0:N-1)*(sampleFreq/N);
%
% plot(F,10*log10(P))
%
% S_oneSided = S(2:(N/2 + 1));
% totalArea = trapz(S_oneSided)*(sampleFreq/N);
% % totalArea = sampleFreq/N*sum(Y(2:(N/2 + 1)));
%
% %-------------------------------------------------------------------------------
% %% Compute fALFF measure:
% % Thresholds for each frequency band:
%
%
% relPower = zeros(1,numBands);
% for i = 1:numBands
%     LCO = bandIntervals(i);
%     HCO = bandIntervals(i+1);
%
%     idx_LCO = floor(LCO * N * samplingPeriod) + 1;
%     idx_HCO = floor(HCO * N * samplingPeriod);
%
%     bandArea = sampleFreq*sum(S(idx_LCO:idx_HCO));
%
%     relPower(i) = bandArea/totalArea;
% end


end
