%% Plot the linear chirp signal
% Signal parameters
A=2;
f0=2;
f1=3;
I=4;


% Instantaneous frequency after 1 sec is 
maxFreq = f0+2*f1;
% sampling frequency 5 times the maximum frequency
samplFreq= 5*maxFreq;
samplIntrvl = 1/samplFreq;

% Time samples
timeVec = 0:samplIntrvl:1;
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

%Plot the periodogram
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
xlabel('frequency');
ylabel('magnitude of the FFT of the frequencies');




