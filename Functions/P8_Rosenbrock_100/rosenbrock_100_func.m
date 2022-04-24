% Function that computes the function value for the Rosenbrock function
%
%           Input: x
%           Output: f(x)
% Code written by Northwood Team

function [f] = rosenbrock_100_func(x)

f = 0;

for i = 1:99
    f = f + (1 - x(i))^2 + 100*(x(i+1) - x(i)^2)^2;
end

end