% Computes the Trust Region Symmetric Rank-1 step with CG Steihaug 
% algorithm for trust region subproblem
%   Inputs: current input point
%           current function value
%           current gradient
%           current Hessian estimate
%           problem, method, options
%   Outputs: the inputs computed at the new point after Newton TR CG step


function [x_new, f_new, g_new, H_new, delta] = TRSR1CGStep(x,f,g,H,delta,problem,method,options)

d_k = CGSubSolver(g, H, delta, options.term_tol_CG);
model = @(d) f + g.'*d + 0.5 * d.' * H * d;
rho = (f - problem.compute_f(x + d_k)) / (f - model(d_k));

if rho > options.c_1_tr
    x_new = x + d_k;
    f_new = problem.compute_f(x_new);
    g_new = problem.compute_g(x_new);
    s = d_k;
    y = g_new - g;
    H_new = H + (y - H*s)*(y - H*s).' / ((y - H*s).' * s);

    if rho > options.c_2_tr
        delta = 2 * delta;
    end
else
    x_new = x;
    f_new = f;
    g_new = g;
    H_new = H;
    delta = delta/2;

end

end

