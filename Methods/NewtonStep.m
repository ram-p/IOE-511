% Function that runs one step of Newton's method on the chosen problem.
% Inputs: x, f, g, H, problem, method, options, k
% Outputs: x_new, f_new, g_new, H_new, d, alpha
% Code written by Northwood Team.

function [x_new,f_new,g_new,H_new,d,alpha,num_grad_evals,num_func_evals, eigval] = NewtonStep(x,f,g,H,problem,method,options, k)

% Algorithm to compute modified search direction using the modified Hessian H + eta.I
R = CholeskySubroutine(problem.n, H, options.beta);  % Returning the result of factorizing H + eta.I
H = R'*R;
eigval = max(diag(R));
H = H + options.lambda * eye(size(H));
d = -(H\g);                                  % Search direction d based on the modified Hessian

% General parameters for a line search.
abar = 1;
c1 = options.c1_ls;
c2 = options.c2_ls;
num_func_evals = 0;
num_grad_evals = 0;

% Determining step size, depending on the type of line search.
switch method.options.step_type
    case 'Backtracking'
        tau = 0.5;      % Backtracking parameter
        num_func_evals = num_func_evals + 1;
        while (problem.compute_f(x + abar*d)) > (f + c1*abar*g'*d)       % Condition to continue backtracking
            abar = tau*abar;                        % Backtracking update
            num_func_evals = num_func_evals + 1;
        end
        alpha = abar;                               % Set step size when the Armijo condition has been satisfied
        x_new = x + alpha*d;                        % Iterate update
        f_new = problem.compute_f(x_new);           % New function value
        num_func_evals = num_func_evals + 1;
        g_new = problem.compute_g(x_new);           % New gradient value
        num_grad_evals = num_grad_evals + 1;
        H_new = problem.compute_H(x_new);           % New Hessian value
    case 'Wolfe'
        alow = 0; ahi = 1000; c = 0.5;      % Parameters for the weak Wolfe line search.
        while true
            num_func_evals = num_func_evals + 1;
            if (problem.compute_f(x + abar*d)) <= (f + c1*abar*g'*d)     % First Wolfe condition
                num_grad_evals = num_grad_evals + 1;
                if (problem.compute_g(x + abar*d)'*d >= c2*g'*d)         % Second Wolfe condition
                    % Step size set if both conditions are satisfied, and break.
                    alpha = abar;
                    break
                end
            end
            % Set low and high thresholds for abar, depending on whether the first condition is satisfied.
            num_func_evals = num_func_evals + 1;
            if (problem.compute_f(x + abar*d)) <= (f + c1*abar*g'*d)
                alow = abar;
            else
                ahi = abar;
            end
            abar = c*alow + (1-c)*ahi;              % A combination of the low and high thresholds.
        end
        x_new = x + alpha*d;                        % Iterate update
        f_new = problem.compute_f(x_new);           % New function value
        num_func_evals = num_func_evals + 1;
        g_new = problem.compute_g(x_new);           % New gradient value
        num_grad_evals = num_grad_evals + 1;
        H_new = problem.compute_H(x_new);           % New Hessian value
    otherwise
        error('Please check step type')

end

end