%% Generation of White Gaussian Noise
%FIXME Doc: A better title would be "Noise whitening". You are not generating a new noise realization, just whitening a given one.

% Load the data file
data = load('testData.txt');
% Signal parameters
%FIXME Doc: What does the comment "Signal parameters" mean here?

% Sampling frequency for noise realization
%FIXME Use the name of the unit 'Hz' instead of the name of the scientist, 'Hertz'.
sampFreq = 1024; %Hertz
% Number of samples in the data file
nSamples = 16384;
% Time samples
timeVec = data(:,1);

%% Estimate Power Spectral Density
inSigFree = data(data(:,1) <= 5, 2);
[psdVals, freqVec] = pwelch(inSigFree, 256, 128, [], sampFreq);
% Plot the estimated Power Spectral  density
figure;
plot(freqVec,psdVals);
title('Estimated Power Spectral density');
%FIXME Plot: Use 'Hz' instead of 'Hertz'
xlabel('Frequency (Hertz)');
ylabel('Power spectral density');

%% Generate White Gaussian noise realization
%FIXME Doc: You are not generating a realization, whitening an existing one: Change the section title
inNoise = data(:,2);
% Design FIR filter with T(f)= 1/square root of estimated Power Spectral
% Density
% Estimate Power Spectral Density
%FIXME VarName: 'sqrtPSD' is not an appropriate name for the reciprocal of sqrt(psdVals)
sqrtPSD = 1./sqrt(psdVals);
fltrOrdr = 500;
b = fir2(fltrOrdr,freqVec/(sampFreq/2),sqrtPSD);
outNoise = sqrt(sampFreq)*fftfilt(b,inNoise);

% Plot the Colored Gaussian Noise Realization
figure;
plot(timeVec, inNoise);
%FIXME Plot: Title is not indicative of plot (use 'Data' instead)
title('Colored Noise');
xlabel('sampling time(sec)');
ylabel('data value');

% Plot the White Gaussian noise realization
figure;
plot(timeVec, outNoise);
%FIXME Plot: Title is not indicative of plot (use 'Whitened Data' instead)
title('White Noise');
xlabel('sampling time(sec)');
ylabel('data value');

%% Plot the spectrograms
% Spectrogram of colored noise
% Specify window length and overlap
winLen = 0.3;
ovrlp = 0.1;
% Convert to integer number of samples
winLenSamples = floor(winLen*sampFreq);
ovrlpSamples = floor(ovrlp*sampFreq);
% Generate the spectrogram
[S,F,T] = spectrogram(inNoise, winLenSamples, ovrlpSamples, [], sampFreq);
% Plot the spectrogram of Colored Noise
figure;
imagesc(T, F, abs(S)); 
axis xy;
title('Spectrogram of Colored Noise');
xlabel('Time(sec)');
ylabel('Frequency(Hz)');

%% Spectrogram of white noise
% Specify window length and overlap
winLen = 0.3;
ovrlp = 0.1;
% Convert to integer number of samples
winLenSamples = floor(winLen*sampFreq);
ovrlpSamples = floor(ovrlp*sampFreq);
% Generate the spectrogram
[S,F,T] = spectrogram(outNoise, winLenSamples, ovrlpSamples, [], sampFreq);
% Plot the spectrogram of White Gaussian Noise
figure;
imagesc(T, F, abs(S)); 
axis xy;
title('Spectrogram of White Noise');
xlabel('Time(sec)');
ylabel('Frequency(Hz)');
