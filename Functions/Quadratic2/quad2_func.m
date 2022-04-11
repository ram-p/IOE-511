% IOE 511/MATH 562, University of Michigan
% Code written by: Batman

% Function that computes the function value for the second-order quadratic
%
%           Input: x
%           Output: f(x)
%
function [f] = quad2_func(x)

load('quadratic2.mat');

f = 0.5*x'*A*x + b'*x + c;

end