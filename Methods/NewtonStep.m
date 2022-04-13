% IOE 511/MATH 562, University of Michigan
% Code written by: Batman

% Function that: (1) computes the GD step; (2) updates the iterate; and,
%                (3) computes the function and gradient at the new iterate
%
%           Inputs: x, f, g, problem, method, options
%           Outputs: x_new, f_new, g_new, d, alpha
%
function [x_new,f_new,g_new,H_new,d,alpha] = NewtonStep(x,f,g,H,problem,method,options, k)

% Algorithm to compute modified search direction using H + eta.I
beta = options.beta;                        % Beta
R = CholeskySubroutine(H, beta);               % Returning the result of factorizing H + eta.I
% Search direction d = -(R'R)\g;
d = -R\(R'\g);

% determine step size
switch method.options.step_type
    case 'Backtracking'
        alpha_bar = options.alpha_bar;
        rho = options.rho;
        c1 = options.c1;
        alpha = alpha_bar;

        while (problem.compute_f(x + alpha * d)) > f + c1*alpha*g'*d       % Condition to continue backtracking
            alpha = alpha*rho;                        % Backtracking update
        end
        
    case 'Wolfe'
%         abar = 1; c1 = 1e-4; c2 = 0.9; alow = 0; ahi = 1000; c = 0.5; eps = 1e-6;       % Parameters for the weak Wolfe line search
        alpha_bar = options.alpha_bar;
        c1 = options.c1;
        c2 = options.c2;
        alow = options.alow;
        ahi = options.ahi;
        c = options.c;
        
        alpha = alpha_bar;
        while true
            if (problem.compute_f(x + alpha*d)) <= f + c1*alpha*g'*d)
                if (problem.compute_g(x + alpha*d)'*d >= c2*g'*d)
                    break
                end
            end
            if (problem.compute_f(x + alpha*d)) <= (f + c1*alpha*g'*d)
                alow = alpha;
            else
                ahi = alpha;
            end
            alpha = c*alow + (1-c)*ahi;
        end
end

    x_new = x + alpha*d;                        % Iterate update
    f_new = problem.compute_f(x_new);           % New function value
    g_new = problem.compute_g(x_new);           % New gradient value
    H_new = problem.compute_H(x_new);           % New Hessian value

end
