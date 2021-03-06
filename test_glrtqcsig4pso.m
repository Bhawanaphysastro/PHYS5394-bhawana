%% Test glrtqcsig4pso.m and plot fitness values vs qc parameters
addpath ..\DATASCIENCE_COURSE\DETEST
% define all testing parameters
% qc true parameters
x = [2,0.3,10];
% set the [min,max] values for parameter ranges
a1 = [1,10];
a2 = [-2,1];
a3 = [-20,20];
% step size
da = 0.05;
% set snr
snr = 4;

%% Create data realization of colored Gaussian noise and qc
% set up time
samplFreq = 1024; %Hz
nSamples = 2048;
dataLen = nSamples/samplFreq;
% time samples vector
dataX = (0:(nSamples-1))/samplFreq;

% psd function handle
tPSD = @(f) (f>=0 & f<=200).*(200-f).*((sin(f/6)*0.3+1))/10000 + 1;
% set up frequency
kNyq = floor(nSamples/2)+1;
posFreq = (0:(kNyq-1))*(1/dataLen); % vector of positive frequencies
% psd vector
psdVec = tPSD(posFreq);
% plot(posFreq,psdVec);

% generate colored noise
filtOrdr = 100;
% rng('default');
noiseVec = statgaussnoisegen(nSamples,[posFreq(:),psdVec(:)],filtOrdr,samplFreq);

% generate qc and normalize to snr
sigVec = crcbgenqcsig(dataX,snr,x);
% norm of the signal squared is inner product of signal with itself
normSigSqrd = innerprodpsd(sigVec,sigVec,samplFreq,psdVec);
sigVec = snr*sigVec/sqrt(normSigSqrd);

% data vector
dataVec = noiseVec + sigVec;

% figure;
% plot(dataVec);
% hold on;
% plot(sigVec);

%% Generate matrices
% range of x(1) parameter
A = a1(1):da:a1(2);
nRows = length(A);

% Column of x1 values
x1 = (A-a1(1))./(a1(2)-a1(1));
x1Col = x1';
% Columns of same x2 and x3 value respectively
x2 = (x(2)-a2(1))/(a2(2)-a2(1));
x2Col = zeros(length(x1),1) + x2;
x3 = (x(3)-a3(1))/(a3(2)-a3(1));
x3Col = zeros(length(x1),1) + x3;

% master matrix
mm = [x1Col,x2Col,x3Col];

%% Compute fitness values of mm
% parameter structrue for glrtqc4pso
params = struct('dataX',dataX,...
                'dataXSq',dataX.^2,...
                'dataXCb',dataX.^3,...
                'dataY',dataVec,...
                'samplFreq',samplFreq,...
                'psdVec',psdVec,...
                'snr',snr,...
                'rmin',[a1(1),a2(1),a3(1)],...
                'rmax',[a1(2),a2(2),a3(2)]);
% data allocation for fitness values
% glrts = ones(1,nRows);
% 
% for n = 1:nRows
%     % compute fitness
%     glrts(n) = glrtqcsig4pso(mm(n,:),params);
% end
glrts = glrtqcsig4pso(mm,params);

idmin = find(glrts == min(glrts));

figure;
plot(A,glrts,'-p','MarkerIndices',(idmin),'MarkerFaceColor','red','MarkerSize',10);
title('Fitness Values vs QC Parameter Range');
xlabel('Parameter Value a1');
ylabel('Fitness Values');
