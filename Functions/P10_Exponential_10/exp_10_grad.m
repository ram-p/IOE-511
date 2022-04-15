% Code that computes the gradient for the exponential function

function g = exp_10_grad(x)
    g = zeros(length(x), 1);
    g(1) = 0.5*(sech(x(1)/2))^2 - 0.1*exp(-x(1));
    for i = 2:length(x)
        g(i) = 4*(x(i) - 1)^3;
    end
end