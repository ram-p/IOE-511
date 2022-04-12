% Code to update the iterate using the DFP algorithm

function [x_new, f_new, g_new, Hest_new, d, alpha] = DFPStep(x, f, g, Hest, problem, method, options, k)

% Search Direction
d = -Hest*g;

switch method.options.step_type
    case 'Backtracking'
        abar = 1; tau = 0.5; c1 = 1e-4; eps = 1e-6; % Parameter initialization for backtracking line search and checking BFGS update
        while (problem.compute_f(x + abar*d)) > (problem.compute_f(x) + c1*abar*g'*d)       % Condition to continue backtracking
            abar = tau*abar;                        % Backtracking update
        end
        alpha = abar;                               % Set step size when the Armijo condition has been satisfied
        x_new = x + alpha*d;                        % Iterate update
        f_new = problem.compute_f(x_new);           % New function value
        g_new = problem.compute_g(x_new);           % New gradient value
        s = x_new - x; y = g_new - g;
        if s'*y < eps*norm(s)*norm(y)
            Hest_new = Hest;
            %             disp("Skipped at iteration " + k)
        else
            Hest_new = Hest - (Hest*y*y'*Hest)/(y'*Hest*y) + (s*s')/(s'*y);
        end
    case 'Wolfe'
        abar = 1; c1 = 1e-4; c2 = 0.9; alow = 0; ahi = 1000; c = 0.5; eps = 1e-6;       % Parameters for the weak Wolfe line search
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
        x_new = x + alpha*d;                        % Iterate update
        f_new = problem.compute_f(x_new);           % New function value
        g_new = problem.compute_g(x_new);           % New gradient value
        s = x_new - x; y = g_new - g;
        if s'*y < eps*norm(s)*norm(y)
            Hest_new = Hest;
            %             disp("Skipped at iteration " + k)
        else
            Hest_new = Hest - (Hest*y*y'*Hest)/(y'*Hest*y) + (s*s')/(s'*y);
        end
end
end