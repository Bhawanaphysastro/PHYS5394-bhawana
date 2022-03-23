%% Plot the linear chirp signal
% Generates a linear chirp signal S. X is the vector of
% time stamps at which the samples of the signal are to be computed. SNR is
% the matched filtering signal-to-noise ratio of S 
% C is the vector of two coefficients[f0, f1] that parametrize the frequency 
% of the signal: f0*t+f1*t^2 and I is the initial phase

%path to genlcsign
L5lab/genlcsign.m


% Signal parameters
A=2;
f0=500;
f1=10;
I=4;
%generalized to an arbitrary signal length
sigLen = 10;%sec


%Generalized to an arbitrary signal length
maxFreq = f0+2*f1*sigLen;

%Sampling frequency is 5 times the Nyquist sampling frequency
samplFreq= 5*(2*maxFreq);
samplIntrvl = 1/samplFreq;
% Time samples
timeVec = 0:samplIntrvl:sigLen;
% Number of samples
nSamples = length(timeVec);


% Generate the signal
sigVec = genlcsign(timeVec,A,f0,f1,I);

%Plot the signal 
figure;
plot(timeVec,sigVec,'Marker','.','MarkerSize',24);
title('linear chirp signal'); 
xlabel('time in second');
ylabel('amplitude in arbitrary units');

%Plot a spectrogram
%----------------
winLen = 0.6;%sec
ovrlp = 0.1;%sec
%Convert to integer number of samples 
winLenSmpls = floor(winLen*samplFreq);
ovrlpSmpls = floor(ovrlp*samplFreq);
[S,F,T]=spectrogram(sigVec,winLenSmpls,ovrlpSmpls,[],samplFreq);
figure;
imagesc(T,F,abs(S)); axis xy;
xlabel('Time (sec)');
ylabel('Frequency (Hz)');
