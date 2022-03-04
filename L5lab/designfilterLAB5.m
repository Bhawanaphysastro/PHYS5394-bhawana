% Define signal parameters

A1= 10; %SNR
f1 = 100; % Sine frequency
phi1 = 0; % Initial phase

A2= 5;
f2= 200;
phi2= pi/6;

A3= 2.5;
f3=300;
phi3= pi/4;

%Generate the time vector
samplFreq = 1024; %in HZ
maxFreq = 0.5*samplFreq;
nSamples = 2*samplFreq;
timeVec = (0:(nSamples-1))/samplFreq;

%Declare the 3 sinusoids
s1 = A1*sin(2*pi*f1*timeVec+phi1);
s2 = A2*sin(2*pi*f2*timeVec+phi2);
s3 = A3*sin(2*pi*f3*timeVec+phi3);

%Add the 3 sinusoids
sigVec = s1+s2+s3;

disp(['maximum frequecy of the sum of sinusoids', num2str(maxFreq)]);

%design filter to allow s1 to pass through filter(lowpass)
filtOrder = 30; %use same order for all
%pass frequencies below 120
b1= fir1(filtOrder, 120/(samplFreq/2), 'low');
%apply the low pass filter
filtS1 = fftfilt(b1, sigVec);

%design filter2  to allow s2 to pass band pass filter
%pass frequencies above 100
b2= fir1(filtOrder, [150/(samplFreq/2) 250/(samplFreq/2)], 'bandpass');
filtS2 = fftfilt(b2, sigVec);

%Design filter 3 to allow s3 to pass through filter(high pass)
%pass frequencies above 230
b4= fir1(filtOrder, 260/(samplFreq/2), 'high');
%apply the high pass
filtS3 = fftfilt(b4, sigVec);

%the periodogram
%Length of data 
dataLen = timeVec(end)-timeVec(1);
%DFT sample corresponding to Nyquist frequency
kNyq = floor(nSamples/2)+1;
% Positive Fourier frequencies
posFreq = (0:(kNyq-1))*(1/dataLen);

% FFT of unfiltered signal s
fftSig = fft(sigVec);
% Discard negative frequencies
fftSig = fftSig(1:kNyq);

% FFT of filtered signal 1
fftSig1 = fft(filtS1);
% Discard negative frequencies
fftSig1 = fftSig1(1:kNyq);

% FFT of filtered signal 2
fftSig2 = fft(filtS2);
% Discard negative frequencies
fftSig2 = fftSig2(1:kNyq);

% FFT of filtered signal 3
fftSig3 = fft(filtS3);
% Discard negative frequencies
fftSig3 = fftSig3(1:kNyq);

%plot the peroodogram

subplot(2,3,1);
plot(posFreq,abs(fftSig));
title('Periodogram of the input signal'); 
xlabel('positive frequency');
ylabel('absolute value of the fft signal');
subplot(2,3,4);
plot(posFreq,abs(fftSig1));
title('Periodogram of the output signal from low pass filter'); 
xlabel('positive frequency');
ylabel('absolute value of the fft signal');

subplot(2,3,2);
plot(posFreq,abs(fftSig));
title('Periodogram of the input signal'); 
xlabel('positive frequency');
ylabel('absolute value of the fft signal');
subplot(2,3,5);
plot(posFreq,abs(fftSig2));
title('Periodogram of the output signal from band pass filter'); 
xlabel('positive frequency');
ylabel('absolute value of the fft signal');

subplot(2,3,3);
plot(posFreq,abs(fftSig));
title('Periodogram of the input signal'); 
xlabel('positive frequency');
ylabel('absolute value of the fft signal');
subplot(2,3,6);
plot(posFreq,abs(fftSig3));
title('Periodogram of the output signal from high pass filter'); 
xlabel('positive frequency');
ylabel('absolute value of the fft signal');