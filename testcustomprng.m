%% Histograms for uniform and normal probability distribution functions

% Generate the uniform pdf
%FIXME Write clearer comments: "Generate trial values from uniform pdf" is better
u = customrand(-2, 1, 10000);
% Generate theoretical uniform pdf
%FIXME Write clearer comments: "Generate uniform pdf" is better
a = 1/(1-(-2));
uther = ones(1,10000)*a;

% Generate normal pdf
%FIXME Write clearer comments: "Generate trial values from normal pdf" is better
%FIXME CUSTOMRANDN had the opposite meanings for the first and second arguments compared to normpdf
%n = customrandn(2.0,1.5,10000);
n = customrandn(1.5,2.0,10000);
% Generate theoretical normal pdf
%FIXME Write clearer comments: "Generate normal pdf" is better
x = -6:0.2:6; % create bins
nther = normpdf(x, 2.0, 1.5);


% Plot the histograms
% Histogram(uniform pdf)
figure  ;
%FIXME The pdf is just a function, don't use histogram to plot it. Figure
%out how to plot it using 'plot': Generate (x,y) pairs.
histogram(uther, 'normalization', 'pdf', 'BinLimits', [-2, 1]);
hold on;
histogram(u, 'normalization', 'pdf');
title('Histogram of trial values from a uniform pdf');
xlabel('Trial values');
ylabel('Number of trial values, each bin');
legend('Theoretical pdf','Real pdf');
hold off;

% Histogram(normal pdf)
figure ;
plot(x, nther);                      
hold on;
histogram(n, 'normalization', 'pdf');
title('Histogram of trial values from a normal pdf');
xlabel('Trial values');
%FIXME The Y-axis is the estimated pdf, that's why the 'normalization=pdf' option is used in the histogram function
ylabel('Number of trial values, each bin');
legend('Theoretical pdf','Real pdf');
hold off;