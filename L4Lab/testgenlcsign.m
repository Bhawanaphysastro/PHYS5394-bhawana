%% Plot the linear chirp signal
% Signal parameters
A=2;
f0=2;
f1=3;
I=4;


% Instantaneous frequency after 1 sec is 
maxFreq = f0+2*f1;
% sampling frequency 5 times the maximum frequency
samplFreq1 = 5*maxFreq;
samplIntrvl1 = 1/samplFreq1;
%sampling frequency 0.5 times the maximum frequency
samplFreq2 = 0.5*maxFreq;
samplIntrvl2 = 1/samplFreq2;


% Time samples
timeVec1 = 0:samplIntrvl1:1;
timeVec2 = 0:samplIntrvl2:1;


% Generate the signal
sigVec1 = genlcsign(timeVec1,A,f0,f1,I);
sigVec2 = genlcsign(timeVec2,A,f0,f1,I);

%Plot the signal 
figure;
plot(timeVec1,sigVec1,'Marker','.','MarkerSize',24);
title('linear chirp signal when sampling frequency is 5 times the nyquist sampling frequency'); 
xlabel('time in second');
ylabel('amplitude in arbitrary units');

figure;
plot(timeVec2,sigVec2,'Marker','.','MarkerSize',24);
title('linear chirp signal when sampling frequency is 0.5 times the nyquist sampling frequency'); 
xlabel('time in second');
ylabel('amplitude in arbitrary units');




