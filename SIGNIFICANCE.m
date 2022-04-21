%% Calculate the significance by Computing GLRT of M data realizations under H0

% number of data realizations to compute
m = 40000;

% path to the folders containing 3 data realizations and functions.
addpath ../DATA
addpath ../SIGNALS


% Read data<n>.txt for n = 1,2,3 
data1 = load('data1.txt','-ascii').';
data2 = load('data2.txt','-ascii').';
data3 = load('data3.txt','-ascii').';


nSamples = length(data1);
% Define sampling frequency 
sampFreq = 1024;
dataLen = nSamples/sampFreq;

%% generate quadratic chirp signal 
% Time vector
timeVec = (0:(nSamples-1))/sampFreq;
% Parameters of the quadratic chirp signals (possibly) in data[1,2,3]
% parVec = [a1,a2,a3]
parVec = [10,3,3];

sigVec = crcbgenqcsig(timeVec,1,parVec);

%% Generate the noise PSD vector 
% Define noise psd function
noisePSD = @(f) (f>=100 & f<=300).*(f-100).*(300-f)/10000 + 1;

% Vector of positive frequencies
kNyq = floor(nSamples/2)+1;
posFreq = (0:(kNyq-1))*(1/dataLen);
psdPosFreq = noisePSD(posFreq);

%% GLRT of M realizations
% glrtH0 vector of the GLRT values for m noise realizations
glrtH0 = zeros(1,m);
sqrtPSD = sqrt(psdPosFreq);
b = fir2(100,posFreq/(sampFreq/2),sqrtPSD);

for r = 1:m % m realizations
    % Generate WGN realization to pass through filter
    inNoise = randn(1,nSamples);
    noiseVec = sqrt(sampFreq)*fftfilt(b,inNoise);
    glrtH0(r) = glrtqcsig(noiseVec,sampFreq,psdPosFreq,parVec);
end

% Observed GLRT value for data[1,2,3]
obsvGamma1 = glrtqcsig(data1, sampFreq, psdPosFreq, parVec);
obsvGamma2 = glrtqcsig(data2, sampFreq, psdPosFreq, parVec);
obsvGamma3 = glrtqcsig(data3, sampFreq, psdPosFreq, parVec);

% Significance: alpha[1,2,3] = (glrt >= glrt(observed) ) / number or realizations
alpha1 = sum(glrtH0>=obsvGamma1)/m;
alpha2 = sum(glrtH0>=obsvGamma2)/m;
alpha3 = sum(glrtH0>=obsvGamma3)/m;

% Display results
disp([num2str(m),' noise realizations compared']);
disp(['data1 significance = ',num2str(alpha1)]);
disp(['data2 significance = ',num2str(alpha2)]);
disp(['data3 significance = ',num2str(alpha3)]);
