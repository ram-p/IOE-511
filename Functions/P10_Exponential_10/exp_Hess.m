% Code that computes Hessian for the exponential function

function H = exp_Hess(x)
    H = zeros(length(x));
    H(1, 1) = -0.5*(sech(x(1)/2))^2*tanh(x(1)/2) + 0.1*exp(-x(1));
    for i = 2:length(x)
        H(i, i) = 12*(x(i) - 1)^2;
    end
end