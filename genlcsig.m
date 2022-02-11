function sigVec = genlcsig(dataX,snr,f0,f1,I)

% Generate a linear chirp signal
% S = GENLCSIG(X,SNR,C,I)
% Generates a linear chirp signal S. X is the vector of
% time stamps at which the samples of the signal are to be computed. SNR is
% the matched filtering signal-to-noise ratio of S 
% C is the vector of two coefficients[f0, f1] that parametrize thefrequency 
% of the signal: f0*t+f1*t^2 and I is the initial phase


% Bhawana Sedhai, Feb-10, 2022

phaseVec = f0*dataX + f1*dataX.^2;
sigVec = sin(2*pi*(phaseVec)+I);
sigVec = snr*sigVec./norm(sigVec);