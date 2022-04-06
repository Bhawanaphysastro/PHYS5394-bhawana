%% Simulation of LIGO Noise
% Signal parameters
sampFreq = 1024;
nSamples = 16384;

% Load data from the file
data = load('iLIGOSensitivity.txt');

% Target Power Spectral Density
psdVals = y(:,2);
freqVec = y(:,1);
% Plot the target Power Spectral Density
figure;
loglog(freqVec, psdVals);
title('Target Power Spectral density');
xlabel('Frequencies(Hertz)');
ylabel('Target Power Spectral Density');

%% Generate noise realization
inNoise = randn(1, nSamples);
% Design filter with Transfer function T(f) = sqrt(targetPSD)
% Filter parameters
fltrOrdr = 500;
freq = y(:,1)*512/max(y(:,1));
b = fir2(fltrOrdr, freq/(sampFreq/2), y(:,2));

% Filter the input noise
outNoise = sqrt(sampFreq)*fftfilt(b, inNoise);

% Estimate the PSD of output noise
[pxx, f] = pwelch(outNoise, 256, 128, [], sampFreq);
v = [f pxx];

% Specify psd values for certain frequencies
indx_1 = find(v(:,1) < 50);
indx_2 = find(v(:,1) > 700);
v(indx_1, 2) = v(v(:,1) == 48, 2);
v(indx_2, 2) = v(v(:,1) == 700, 2);
sqrt_v = sqrt(v(:,2));

% Plot the estimated psd
figure;
loglog(v(:, 1), sqrt_v);
title('Estimated Power Spectral Density');
xlabel('Frequencies(Hertz)');
ylabel('Estimated Power Spectral density values');