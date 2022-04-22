% Computes the Trust Region Symmetric Rank-1 step with CG Steihaug 
% algorithm for trust region subproblem
%   Inputs: current input point
%           current function value
%           current gradient
%           current Hessian estimate
%           problem, method, options
%   Outputs: the inputs computed at the new point after Newton TR CG step


function [x_new, f_new, g_new, H_new, delta, num_func_evals, num_grad_evals] = TRSR1CGStep(x,f,g,H,delta,problem,method,options)

% Get the descent direction using the CG Steihaug algorithm
d_k = CGSubSolver(g, H, delta, options.term_tol_CG);

% The quadratic model around the current iterate
model = @(d) f + g.'*d + 0.5*d.'*H*d;

% Initialize number of function and gradient evaluations
num_func_evals = 0;
num_grad_evals = 0;

% Compute the rho ratio of the function decrease compared to the model
% decrease
num_func_evals = num_func_evals + 1;
rho = (f - problem.compute_f(x + d_k)) / (f - model(d_k));

if rho > options.c1_tr
    % If the model accuracy is good enough and the function decrement is
    % also good enough, update the iterate
    x_new = x + d_k;
    
    % Compute function and gradient values at the new iterate
    f_new = problem.compute_f(x_new);
    num_func_evals = num_func_evals + 1;
    g_new = problem.compute_g(x_new);
    num_grad_evals = num_grad_evals + 1;
    
    % Compute the new Hessian estimate
    s = d_k;
    y = g_new - g;
    % The SR1 Hessian update rule
    H_new = H + (y - H*s)*(y - H*s).'/((y - H*s).'*s);
    if rho > options.c2_tr
        % If the model accuracy is really good, increase the trust region
        % radius
        delta = 2*delta;
    end
else
    % The model is not accurate enough
    % Skip the update and decrease the trust region readius
    x_new = x;
    f_new = f;
    g_new = g;
    H_new = H;
    delta = delta/2;
end
end