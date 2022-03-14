%% Histograms for uniform and normal probability distribution functions

% Generate the uniform pdf
u = customrand(-2, 1, 10000);
% Generate theoretical uniform pdf
a = 1/(1-(-2));
uther = ones(1,10000)*a;

% Generate normal pdf
n = customrandn(2.0,1.5,10000);
% Generate theoretical normal pdf
x = -6:0.2:6; % create bins
nther = normpdf(x, 2.0, 1.5);


% Plot the histograms
% Histogram(uniform pdf)
figure  ;
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
ylabel('Number of trial values, each bin');
legend('Theoretical pdf','Real pdf');
hold off;