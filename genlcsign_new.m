function sigVec = genlcsign_new(dataX,snr, P)

% Generate a linear chirp signal
% S = GENLCSIG(X,SNR,P)
% Generates a linear chirp signal S.
% X is the vector oftime stamps at which the samples of the signal are to be computed. 
% SNR is the matched filtering signal-to-noise ratio of S 
% P is the structure that holds the values of signal parameters f0,f1 and I
%where I is the initial phase

% Bhawana Sedhai, APR 28, 2022

% Set signal parameters in different fields of a structure
f0 = P.freq0;
f1 = P.freq1;
I = P.I;
% Generate the Signal
phaseVec = f0*dataX + f1*dataX.^2;
sigVec = sin(2*pi*(phaseVec)+I);
sigVec = snr*sigVec./norm(sigVec);