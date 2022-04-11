% IOE 511/MATH 562, University of Michigan
% Code written by: Batman

% Function that computes the gradient of the tenth-order quadratic
%
%           Input: x
%           Output: g = nabla f(x)
%
function [g] = quad10_grad(x)

load('quadratic10.mat')

g = A*x + b;

end