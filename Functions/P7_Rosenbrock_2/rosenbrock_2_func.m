% Function that computes the function value for the Rosenbrock function
%
%           Input: x
%           Output: f(x)
% Code written by Northwood Team

function [f] = rosenbrock_2_func(x)

f = (1 - x(1))^2 + 100*(x(2) - x(1)^2)^2;

end