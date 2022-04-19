% Solver function that runs the given algorithm on the given problem.
% Inputs: problem, method, options (structs).
% Outputs: Final iteration (x) and final function value (f).
% Code written by Northwood Team.

function [x,f,n_f,n_g] = optSolver_Northwood(problem,method,options)

% Set problem, method and options.
[problem] = setProblem(problem);
[method] = setMethod(method);
[options] = setOptions(options);

% Initial condition, initial function, gradient and Hessian.
x = problem.x0;
f = problem.compute_f(x);
g = problem.compute_g(x);
H = problem.compute_H(x);

if isfield(problem, 'fstar')
    fstar = problem.fstar;          % Optimal function value, if known.
end

Hest = eye(problem.n);              % Initial Hessian estimate
norm_g = norm(g,inf);               % Gradient norm
norm_g_init = norm_g;

k = 0;                                      % Initial iteration counter
fplot = zeros(1, options.max_iterations);   % Initializing a vector to take in function values over iterations
gplot = zeros(1, options.max_iterations);   % Initializing a vector to take in gradient norm values over iterations

n_f = 0;
n_g = 0;
delta = options.delta;

while (k < options.max_iterations) && (norm_g > options.term_tol*max(1, norm_g_init))    % Termination condition
    % Take a step based on the chosen method.
    switch method.name
        case 'GradientDescent'
            [x_new,f_new,g_new,d,alpha,num_func_evals,num_grad_evals] = GDStep(x,f,g,problem,method,options);
        case 'Newton'
            [x_new,f_new,g_new,H_new,d,alpha,num_func_evals,num_grad_evals] = NewtonStep(x, f, g, H, problem, method, options, k);
            % Update Hessian now as it's specific to Newton's method
            H_old = H; H = H_new;
        case 'BFGS'
            [x_new, f_new, g_new, Hest_new, d, alpha,num_func_evals,num_grad_evals] = BFGSStep(x, f, g, Hest, problem, method, options, k);
            % Update Hessian estimate now, as it's specific to BFGS
            Hest_old = Hest; Hest = Hest_new;
        case 'DFP'
            [x_new, f_new, g_new, Hest_new, d, alpha,num_func_evals,num_grad_evals] = DFPStep(x, f, g, Hest, problem, method, options, k);
            % Update Hessian estimate now, as it's specific to DFP
            Hest_old = Hest; Hest = Hest_new;
        case 'TRNewtonCG'
            [x_new, f_new, g_new, H_new, delta,num_func_evals,num_grad_evals] = TRNewtonCGStep(x, f, g, H, delta, problem, method, options);
            % Update Hessian now.
            H_old = H; H = H_new;
        case 'TRSR1CG'
            [x_new, f_new, g_new, Hest_new, delta,num_func_evals,num_grad_evals] = TRSR1CGStep(x, f, g, Hest, delta, problem, method, options);
            % Update Hessian estimate now.
            Hest_old = Hest; Hest = Hest_new;
        otherwise
            error('Method not implemented yet!')
    end
    % Update number of function and gradient evaluations
    n_f = n_f + num_func_evals;
    n_g = n_g + num_grad_evals;
    
    % Update old and new iterates, function values, gradients and gradient norms.
    x_old = x; f_old = f; g_old = g; norm_g_old = norm_g;
    x = x_new; f = f_new; g = g_new; norm_g = norm(g,inf)
    fplot(k+1) = f_old;         % Append the function value to the fplot vector.
    gplot(k+1) = norm_g_old;    % Append the gradient norm to the gplot vector.
    k = k+1                    % Increment iteration counter.
end

gradPlot(gplot, k);             % Function for plotting gradient norm vs iterations
if isfield(problem, 'fstar')
    optPlot(fplot, fstar, k);   % Function for plotting optimality gap vs iterations, if optimal function value is known
end

end