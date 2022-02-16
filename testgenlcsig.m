%% Plot the linear chirp signal
% Signal parameters
A=2;
f0=2;
f1=3;
I=4;


% Instantaneous frequency after 1 sec is 
%FIXME Use your own sampling interval as instructed
% maxFreq = 5;
% samplFreq = 5*maxFreq;
% samplIntrvl = 1/samplFreq;
samplIntrvl = 0.005;

% Time samples
timeVec = 0:samplIntrvl:5;
% Number of samples
%FIXME nSamples is not used anywhere, so why compute it?
nSamples = length(timeVec);

% Generate the signal
sigVec = genlcsig(timeVec,A,f0,f1,I);


%Plot the signal 
figure;
plot(timeVec,sigVec,'Marker','.','MarkerSize',24);

title('linear chirp signal');
xlabel('time in second');
ylabel('amplitude in arbitrary units');

