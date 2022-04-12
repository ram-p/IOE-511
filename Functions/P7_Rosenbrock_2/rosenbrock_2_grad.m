% IOE 511/MATH 562, University of Michigan
% Code written by: Batman

% Function that computes the gradient of the Rosenbrock function
%
%           Input: x
%           Output: g = nabla f(x)
%
function g = rosenbrock_2_grad(x)

g = [(2*x(1) - 2 - 400*x(1)*(x(2) - x(1)^2)); 
    200*(x(2) - x(1)^2)];

end