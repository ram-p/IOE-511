% Code to update the iterate using the BFGS algorithm

function [x_new, f_new, g_new, Hest_new, d, alpha] = BFGSStep(x, f, g, Hest, problem, method, options, k)

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
            I = eye(problem.n);
            Hest_new = (I - (s*y')/(s'*y))*Hest*(I - (y*s')/(s'*y)) + (s*s')/(s'*y);
        end
end
end