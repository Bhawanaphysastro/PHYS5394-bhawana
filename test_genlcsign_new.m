%% Plot the linear chirp signal
% Signal parameters
snr=10;%amplitude
f0=20;
f1=30;
I=4;
%Generalized to an arbitrary signal length
sigLen = 10;%sec

%Generalized to an arbitrary signal length
maxFreq = f0+2*f1*sigLen;
%Sampling frequency is 5 times the Nyquist sampling frequency
samplFreq= 5*(2*maxFreq);
samplIntrvl = 1/samplFreq;

% Time samples
%Generalized to an arbitrary signal length
timeVec = 0:samplIntrvl:sigLen;
% Number of samples
nSamples = length(timeVec);


% Generate the signal
P = struct('freq0', f0, 'freq1', f1, 'I', I);

sigVec = genlcsign_new(timeVec,snr,P);

%Plot the signal 
figure;
%plot(timeVec,sigVec,'Marker','.','MarkerSize',24);
plot(timeVec,sigVec);
title('linear chirp signal using struct'); 
xlabel('time in second');
ylabel('amplitude');

%generate the periodogram
%--------------
%Length of data 
dataLen = timeVec(end)-timeVec(1);
%DFT sample corresponding to Nyquist frequency
kNyq = floor(nSamples/2)+1;
% Positive Fourier frequencies
posFreq = (0:(kNyq-1))*(1/dataLen);
% FFT of signal
fftSig = fft(sigVec);
% Discard negative frequencies
fftSig = fftSig(1:kNyq);

%Plot periodogram
figure;
plot(posFreq,abs(fftSig));
title('Periodogram of the signal'); 
xlabel('frequency(Hz)');
ylabel('magnitude');