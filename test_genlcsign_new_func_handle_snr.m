%% Plot the linear chirp signal
% Signal parameters
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
% Function input parameters in structure 
P = struct('freq0', f0, 'freq1', f1, 'I', I);
% Create the function handle
%FIXME Var: Give the function handle a better name (e.g., 'lcsgHndl')
H = @(snr) genlcsign_new(timeVec, snr, P);

% SNR values
snr = [10, 12, 15];

% Plot the signal for different SNRs
for i = 1:length(snr)
    figure;
    %plot(timeVec, H(snr(i)), 'Marker', '.', 'Markersize', 24);
    plot(timeVec, H(snr(i)));
    title(['Signal for SNR = ', num2str(snr(i))]);
    xlabel('Time (sec)');
    ylabel('Signal Amplitude');
end