% IOE 511/MATH 562, University of Michigan
% Code written by: Batman

% Function that computes the Hessian of the Rosenbrock function
%
%           Input: x
%           Output: H = nabla^2 f(x)
%
function [H] = rosenbrock_100_Hess(x)

H = zeros(length(x));
Hstep = zeros(length(x));

H(1, 1) = 1200*x(1)^2 - 400*x(2) + 2;
H(1, 2) = -400*x(1); H(2, 1) = -400*x(1);
for i = 2:length(x)-1
    H(i, i) = 1200*x(i)^2 - 400*x(i+1) + 2 + 200;
    H(i, i+1) = -400*x(i);
    H(i+1, i) = -400*x(i);
end
H(100, 100) = 200;

end