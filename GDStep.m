% IOE 511/MATH 562, University of Michigan
% Code written by: Shreyas Bhat

% Function that: (1) computes the GD step; (2) updates the iterate; and, 
%                (3) computes the function and gradient at the new iterate
% 
%           Inputs: x, f, g, problem, method, options
%           Outputs: x_new, f_new, g_new, d, alpha
%
function [x_new,f_new,g_new,d,alpha] = GDStep(x,f,g,problem,method,options)

% search direction is -g
d = -g;

% determine step size
switch method.options.step_type
    % Known constant step size
    case 'Constant'
        alpha = method.options.constant_step_size;

   % Armijo Backtracking to get a good step size
    case 'Backtracking'
        alpha_bar = options.alpha_bar;
        rho = options.rho;
        c1 = options.c1;
        alpha = alpha_bar;
        while problem.compute_f(x+alpha*d) > f + c1*alpha*g'*d
           alpha = alpha*rho;
        end
end

% Get the new values
x_new = x+alpha*d;
f_new = problem.compute_f(x_new);
g_new = problem.compute_g(x_new);
end

