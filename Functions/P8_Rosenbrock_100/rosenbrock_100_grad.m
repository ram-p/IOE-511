% Function that computes the gradient of the Rosenbrock function
%
%           Input: x
%           Output: f(x)
% Code written by Northwood Team

function [g] = rosenbrock_100_grad(x)

g = zeros(length(x), 1);

g(1) = 2*x(1) - 2 - 400*x(1)*(x(2) - x(1)^2);

for i = 2:99
    g(i) = 2*x(i) - 2 - 400*x(i)*(x(i+1)-x(i)^2) + 200*(x(i) - x(i-1)^2);
end

g(100) = 200*(x(100) - x(99)^2);

end