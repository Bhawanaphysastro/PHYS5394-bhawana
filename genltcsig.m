function sigVec = genltcsig(dataX,A,ta,L,f0,f1,I)
% Generate a linear transient chirp signal
% S = GENLTCSIG(X,SNR,Ta,L,F0,F1,I)
% Generates a linear transient chirp signal S. X is the vector of
% time stamps at which the samples of the signal are to be computed. A is
% the matched filtering signal-to-noise ratio of S 
%FIXME Improve documentation for L: its meaning is unclear
%Ta is the initial time and L is the certain increment in time
%F0 and F1 are the frequency parameters
% and I is the initial phase


% Bhawana Sedhai, Feb-11, 2022

%FIXME Incorrect: Should be (dataX-ta).^2 in the second term
phaseVec = (f0*(dataX-ta))+f1*(dataX-ta.^2);
%FIXME Incorrect: Signal not normalized to have the specified SNR
s = A*sin(2*pi*(phaseVec)+I);
range=(ta:ta+L);

if ismember(dataX,range)==1
    %FIXME Incorrect: this condition will not be satisfied in general
    %because you used a sampling interval of 1 for 'range' but a different
    %sampling interval for dataX
    sigVec=0;
else
    sigVec=s;
end