% IOE 511/MATH 562, University of Michigan
% Code written by: Batman

% Function that runs a chosen algorithm on a chosen problem
%           Inputs: problem, method, options (structs)
%           Outputs: final iterate (x) and final function value (f)
function [x,f] = optSolver_Padmanabhan_Ram(problem,method,options)

% set problem, method and options
[problem] = setProblem(problem);
[method] = setMethod(method);
[options] = setOptions(options);

% compute initial function/gradient/Hessian/Hessian estimate
x = problem.x0;
fstar = problem.fstar;
f = problem.compute_f(x);
g = problem.compute_g(x);
H = problem.compute_H(x);
Hest = eye(problem.n);
norm_g = norm(g,inf);
norm_g_old = norm_g;

% set initial iteration counter
k = 0;
% Initialize a vector fplot which is simply a series of values f(x_k)
fplot = zeros(1, options.max_iterations);
% Initialize a vector gplot which takes the value of the norm of gradient at each iteration
gplot = zeros(1, options.max_iterations);

while (k < options.max_iterations) && (norm_g > options.term_tol*max(1, norm_g_old))    % Termination condition - theoretical and patience
    
    % take step according to a chosen method
    switch method.name
        case 'GradientDescent'
            [x_new,f_new,g_new,d,alpha] = GDStep(x,f,g,problem,method,options);
        case 'Newton'
            [x_new,f_new,g_new,H_new,d,alpha] = NewtonStep(x, f, g, H, problem, method, options, k);
            % Update Hessian now as it's specific to Newton's method
            H_old = H; H = H_new;
        case 'BFGS'
            [x_new, f_new, g_new, Hest_new, d, alpha] = BFGSStep(x, f, g, Hest, problem, method, options, k);
            % Update Hessian estimate now, as it's specific to BFGS
            Hest_old = Hest; Hest = Hest_new;
        otherwise
            error('Method not implemented yet!')
    end
            % Update old and new function values, gradients and iterates
            x_old = x; f_old = f; g_old = g; norm_g_old = norm_g;
            x = x_new; f = f_new; g = g_new; norm_g = norm(g,inf);
            % Append the function value to the fplot vector
            fplot(k+1) = f_old;
            gplot(k+1) = norm_g_old;
     

    % increment iteration counter
    k = k + 1;
    
end

% Function for plotting gradient norm vs iterations
gradPlot(gplot, k);
% Function for plotting optimality gap vs iterations
% Uncomment only if applicable.
% optPlot(fplot, fstar, k);

end