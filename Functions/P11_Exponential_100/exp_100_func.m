% Code that computes function value for the exponential function

function f = exp_100_func(x)
    f1 = tanh(x(1)/2) + 0.1*exp(-x(1));
    f2 = 0;
    for i = 2:length(x)
        f2 = f2 + (x(i) - 1)^4;
    end
    f = f1 + f2;
end