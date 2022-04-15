% Function that runs one step of BFGS on the chosen problem.
% Inputs: x, f, g, Hest, problem, method, options, k
% Outputs: x_new, f_new, g_new, Hest_new, d, alpha
% Code written by Northwood Team.

function [x_new, f_new, g_new, Hest_new, d, alpha] = BFGSStep(x, f, g, Hest, problem, method, options, k)

d = -Hest*g;            % Search direction based on the Hessian estimate

% General parameters for a line search.
abar = 1;
c1 = options.c1_ls;
c2 = options.c2_ls;

eps = options.eps;      % Tolerance to determine whether Hessian estimate must be updated.

% Determining step size, depending on the type of line search.
switch method.options.step_type
    case 'Backtracking'
        tau = 0.5;      % Backtracking parameter
        while (problem.compute_f(x + abar*d)) > (problem.compute_f(x) + c1*abar*g'*d)       % Condition to continue backtracking
            abar = tau*abar;                        % Backtracking update
        end
        alpha = abar;                               % Set step size when the Armijo condition has been satisfied
        x_new = x + alpha*d;                        % Iterate update
        f_new = problem.compute_f(x_new);           % New function value
        g_new = problem.compute_g(x_new);           % New gradient value

        s = x_new - x; y = g_new - g;               % Curvature Pairs
        % Condition to check if Hessian must be updated
        if s'*y < eps*norm(s)*norm(y)
            Hest_new = Hest;
            %             disp("Skipped at iteration " + k)
        else
            I = eye(problem.n);
            % Hessian update
            Hest_new = (I - (s*y')/(s'*y))*Hest*(I - (y*s')/(s'*y)) + (s*s')/(s'*y);
        end
    case 'Wolfe'
        alow = 0; ahi = 1000; c = 0.5;      % Parameters for the weak Wolfe line search.
        while true
            if (problem.compute_f(x + abar*d)) <= (problem.compute_f(x) + c1*abar*g'*d)     % First Wolfe condition
                if (problem.compute_g(x + abar*d)'*d >= c2*problem.compute_g(x)'*d)         % Second Wolfe condition
                    % Step size set if both conditions are satisfied, and break.
                    alpha = abar;
                    break
                end
            end
            % Set low and high thresholds for abar, depending on whether the first condition is satisfied.
            if (problem.compute_f(x + abar*d)) <= (problem.compute_f(x) + c1*abar*g'*d)
                alow = abar;
            else
                ahi = abar;
            end
            abar = c*alow + (1-c)*ahi;              % A combination of the low and high thresholds.
        end
        x_new = x + alpha*d;                        % Iterate update
        f_new = problem.compute_f(x_new);           % New function value
        g_new = problem.compute_g(x_new);           % New gradient value

        s = x_new - x; y = g_new - g;               % Curvature pairs
        % Condition to check if Hessian must be updated
        if s'*y < eps*norm(s)*norm(y)
            Hest_new = Hest;
            %             disp("Skipped at iteration " + k)
        else
            I = eye(problem.n);
            % Hessian update
            Hest_new = (I - (s*y')/(s'*y))*Hest*(I - (y*s')/(s'*y)) + (s*s')/(s'*y);
        end
end
end