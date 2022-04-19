% Code that computes Hessian for the exponential function

function H = exp_10_Hess(x)
%     H = zeros(length(x));
%     H(1, 1) = -0.5*(sech(x(1)/2))^2*tanh(x(1)/2) + 0.1*exp(-x(1));
%     for i = 2:length(x)
%         H(i, i) = 12*(x(i) - 1)^2;
%     end
    
    % "Vectorized". No idea if this makes it faster in MATLAB. (It does in
    % python)
    
    H = zeros(length(x), length(x));
    H(1,1) = -2*exp(x(1))*(exp(x(1))-1)/(exp(x(1)) + 1)^3 + 0.1*exp(-x(1));
    H(2:end, 2:end) = diag(12.*(x(2:end) - 1).^2);


end