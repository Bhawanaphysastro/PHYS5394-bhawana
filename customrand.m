%% Function to generate trial values with uniform probability distributions
function y = customrand(a,b,c)
%FIXME Need to put in help comments
    x = rand(1,c);
    y = x*(b-a) + a;
end