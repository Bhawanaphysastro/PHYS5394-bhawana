%% Function to generate trial values with uniform probability distributions
function y = customrandn(a,b,c)
%FIXME Need to put in help comments
    x = randn(1, c);
    y = a*x + b;
end