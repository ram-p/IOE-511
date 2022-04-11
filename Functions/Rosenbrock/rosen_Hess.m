% IOE 511/MATH 562, University of Michigan
% Code written by: Batman

% Function that computes the Hessian of the Rosenbrock function
%
%           Input: x
%           Output: H = nabla^2 f(x)
%
function [H] = rosen_Hess(x)

H = [1200*x(1)^2 - 400*x(2) + 2    -400*x(1);  
    -400*x(1)                       200];

end