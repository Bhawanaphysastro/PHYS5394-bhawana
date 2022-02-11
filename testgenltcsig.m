%% Plot the linear transient chirp signal
% Signal parameters

A=5;
ta=1;
L=2;
f0=1;
f1=3;
I=5;

% Instantaneous frequency after 1 sec is 
maxFreq = 5;
samplFreq = 5*maxFreq;
samplIntrvl = 1/samplFreq;

% Time samples
timeVec = 0:samplIntrvl:5;
% Number of samples
nSamples = length(timeVec);

% Generate the signal

sigVec = genltcsig(timeVec,A,ta,L,f0,f1,I);

%Plot the signal 
figure;
plot(timeVec,sigVec,'Marker','.','MarkerSize',24);

title('linear transient chirp signal');
xlabel('time in second');
ylabel('amplitude in arbitrary units');
