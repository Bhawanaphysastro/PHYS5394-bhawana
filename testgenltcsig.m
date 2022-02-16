%% Plot the linear transient chirp signal
% Signal parameters

A=5;
ta=1;
L=10;
f0=1;
f1=3;
I=5;

% Instantaneous frequency after 1 sec is 
%FIXME Use your own sampling interval as instructed
% maxFreq = 5;
% samplFreq = 5*maxFreq;
% samplIntrvl = 1/samplFreq;
samplIntrvl = 0.005;

% Time samples
timeVec = 0:samplIntrvl:50;
% Number of samples
%FIXME nSamples is not used anywhere, so why compute it?
nSamples = length(timeVec);

% Generate the signal
%FIXME Output is not correct: Signal should be zero until t= ta.
sigVec = genltcsig(timeVec,A,ta,L,f0,f1,I);
%SDM This is the corrected version
sigVec_correct = genltcsig_correct(timeVec,A,ta,L,f0,f1,I);

%Plot the signal 
figure;
plot(timeVec,sigVec,'Marker','.','MarkerSize',24);

title('linear transient chirp signal');
xlabel('time in second');
ylabel('amplitude in arbitrary units');

figure;
plot(timeVec,sigVec_correct,'Marker','.','MarkerSize',24);

title('(Corrected) linear transient chirp signal');
xlabel('time in second');
ylabel('amplitude in arbitrary units');
