% IOE 511/MATH 562, University of Michigan
% Code written by: Shreyas Bhat

% Function that runs a chosen algorithm on a chosen problem
%           Inputs: problem, method, options (structs)
%           Outputs: final iterate (x) and final function value (f)
function [x,f, fvals, norm_gs,modification_counter,modified_iter,skipped_counter,skipped_iters] = optSolver_Bhat_Shreyas(problem,method,options)

% set problem, method and options
[problem] = setProblem(problem);
[method] = setMethod(method);
[options] = setOptions(options);

% Initialize fvals and norm_grads
fvals = [];
norm_gs = [];

trackvals = false;

if isfield(options, 'track')
    trackvals = options.track;
end

% compute initial function/gradient/Hessian
x = problem.x0;
f = problem.compute_f(x);
g = problem.compute_g(x);
H = problem.compute_H(x);

norm_g = norm(g,inf);
term_constant = max(norm_g, 1);

if trackvals
    fvals = [fvals, f];
    norm_gs = [norm_gs, norm_g];
end

% set initial iteration counter
k = 0;
modification_counter = 0;
modified_iter = [];

skipped_counter = 0;
skipped_iters = [];

while k < options.max_iterations && norm_g >= options.term_tol * term_constant
    
    % take step according to a chosen method
    switch method.name
        case 'GradientDescent'
            [x_new,f_new,g_new,d,alpha] = GDStep(x,f,g,problem,method,options);
        case 'Newton'
            [x_new,f_new,g_new,H_new,d,alpha] = NewtonStep(x,f,g,H,problem,method,options);
            H_old = H;
            H = H_new;
        case 'ModifiedNewton'
            [x_new,f_new,g_new,H_new,d,alpha,modified] = ModifiedNewtonStep(x,f,g,H,problem,method,options);
            H_old = H;
            H = H_new;
            if modified
                modification_counter = modification_counter+1;
                modified_iter = [modified_iter, k];
            end
        case 'BFGS'
            if k == 0
                H = eye(problem.n);
            end
            [x_new,f_new,g_new,H_new,d,alpha, skipped] = BFGSStep(x,f,g,H,problem,method,options);
            H_old = H;
            H = H_new;
            if skipped
                skipped_counter = skipped_counter + 1;
                skipped_iters = [skipped_iters, k];
            end
            
        case 'LBFGS'
            if k == 0
                r = g;
                sks = [];
                yks = [];
            end
            [x_new, f_new, g_new, r_new, sks_new, yks_new, alpha] = LBFGSStep(x, f, g, r, sks, yks, problem, method, options);
            sks_old = sks;
            yks_old = yks;
            yks = yks_new;
            sks = sks_new;
            r_old = r;
            r = r_new;
        otherwise
            error('Method not implemented yet!')            
    end
    
    % update old and new function values
    x_old = x; f_old = f; g_old = g; norm_g_old = norm_g;
    x = x_new; f = f_new; g = g_new; norm_g = norm(g,inf);

    if trackvals
        fvals = [fvals, f];
        norm_gs = [norm_gs, norm_g];
    end

    % increment iteration counter
    k = k + 1;
    
end

end