%Plot the linear transient chirp signal
% Generates a linear transient chirp signal S. X is the vector of
% time stamps at which the samples of the signal are to be computed. A is
% the matched filtering signal-to-noise ratio of S 
%Ta is the initial time and L is the certain increment in time
%F0 and F1 are the frequency parameters
% and I is the initial phase

% Signal parameters
A=5;
ta=1;
L=10;
f0=20;
f1=4;
% Instantaneous frequency after 1 sec is 
maxFreq = f0+2*f1*(50-ta);
% sampling frequency 5 times the maximum frequency
samplFreq= 5*maxFreq;
samplIntrvl = 1/samplFreq;
% Time samples
timeVec = 0:samplIntrvl:50;
% Number of samples
nSamples = length(timeVec);

% Generate the signal
sigVec = genltcsig_correct(timeVec,A,ta,L,f0,f1,I);
%Plot the signal 
figure;
plot(timeVec,sigVec,'Marker','.','MarkerSize',24);
title('linear transient chirp signal'); 
xlabel('time in second');
ylabel('amplitude in arbitrary units');

%Plot a spectrogram
%----------------
winLen = 0.2;%sec
ovrlp = 0.1;%sec
%Convert to integer number of samples 
winLenSmpls = floor(winLen*samplFreq);
ovrlpSmpls = floor(ovrlp*samplFreq);
[S,F,T]=spectrogram(sigVec,winLenSmpls,ovrlpSmpls,[],samplFreq);
figure;
imagesc(T,F,abs(S)); axis xy;
xlabel('Time (sec)');
ylabel('Frequency (Hz)');

