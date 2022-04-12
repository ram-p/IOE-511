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
        
    case 'Wolfe'
        abar = 1; c1 = 1e-4; c2 = 0.9; alow = 0; ahi = 1000; c = 0.5;       % Parameters for the weak Wolfe line search
        while true
            if (problem.compute_f(x + abar*d)) <= (problem.compute_f(x) + c1*abar*g'*d)
                if (problem.compute_g(x + abar*d)'*d >= c2*problem.compute_g(x)'*d)
                    alpha = abar;
                    break
                end
            end
            if (problem.compute_f(x + abar*d)) <= (problem.compute_f(x) + c1*abar*g'*d)
                alow = abar;
            else
                ahi = abar;
            end
            abar = c*alow + (1-c)*ahi;
        end
end

% Get the new values
x_new = x+alpha*d;
f_new = problem.compute_f(x_new);
g_new = problem.compute_g(x_new);

end

