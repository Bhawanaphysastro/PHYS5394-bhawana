function glrt = glrtqcsig(dataVec, sampFreq, psdVec, parVec)
% Function that calculates the GLRT for a quadratic chirp signal with
% unknown amplitude.
% DATAVEC is the data vector
% PSDVEC is the vector of psd values
% SAMPFREQ
% PARVEC = [a1,a2,a3] is a vector of input parameters to construct quadratic chirp
%   llr = innerproduct<DATAVEC, NORMSIG>^2
%   where NORMSIG is the signal normalized to unit norm.

% number of samples
nSamples = length(dataVec);
% Define timeVec
timeVec = (0:(nSamples-1))/sampFreq;

% Create quadratic chirp signal.
sigVec = crcbgenqcsig(timeVec,10,parVec);

% Normalize the signal vector (template). Set snr = 10.
% We do not need normalization factor (~), only the normalized signal.
[templateVec,~] = normsig4psd(sigVec,sampFreq,psdVec,10);

% Inner product of data and template
llr = innerprodpsd(dataVec,templateVec,sampFreq,psdVec);

% Square the inner product to get the glrt
glrt = llr^2;


