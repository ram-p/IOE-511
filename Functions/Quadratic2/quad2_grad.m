% IOE 511/MATH 562, University of Michigan
% Code written by: Batman

% Function that computes the gradient of the second-order quadratic
%
%           Input: x
%           Output: g = nabla f(x)
%
function [g] = quad2_grad(x)

load('quadratic2.mat')

g = A*x + b;

end