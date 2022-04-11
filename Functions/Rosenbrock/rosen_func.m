% IOE 511/MATH 562, University of Michigan
% Code written by: Batman

% Function that computes the function value for the Rosenbrock function
%
%           Input: x
%           Output: f(x)
%
function [f] = rosen_func(x)

f = (1 - x(1))^2 + 100*(x(2) - x(1)^2)^2;

end