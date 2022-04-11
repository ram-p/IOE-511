% IOE 511/MATH 562, University of Michigan
% Code written by: Shreyas Bhat

% Function that: (1) computes the Newton step; (2) updates the iterate; and, 
%                (3) computes the function and gradient at the new iterate
% 
%           Inputs: x, f, g, H, problem, method, options
%           Outputs: x_new, f_new, g_new, H_new, d, alpha
%
function [x_new,f_new,g_new, H_new,d,alpha, modified] = ModifiedNewtonStep(x,f,g,H,problem,method,options)

[L, modified] = CholeskySubroutine(H, options.beta);

d = -(L\(L'\g));

% determine step size
switch method.options.step_type
    case 'Backtracking'
        alpha_bar = options.alpha_bar;
        rho = options.rho;
        c1 = options.c1;
        alpha = alpha_bar;
        while problem.compute_f(x+alpha*d) > f + c1*alpha*g'*d
           alpha = alpha*rho;
        end
        x_new = x+alpha*d;
        f_new = problem.compute_f(x_new);
        g_new = problem.compute_g(x_new);
        H_new = problem.compute_H(x_new);
end
end

