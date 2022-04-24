% Function that computes the Hessian of the Rosenbrock function
%
%           Input: x
%           Output: f(x)
% Code written by Northwood Team

function [H] = rosenbrock_2_Hess(x)

H = [1200*x(1)^2 - 400*x(2) + 2    -400*x(1);  
    -400*x(1)                       200];

end