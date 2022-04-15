% Computes the Trust Region Newton Step with CG Steihaug algorithm for
% trust region subproblem
%   Inputs: current input point
%           current function value
%           current gradient
%           current Hessian
%           problem, method, options
%   Outputs: the inputs computed at the new point after Newton TR CG step


function [x_new, f_new, g_new, H_new, delta] = TRNewtonCGStep(x,f,g,H,problem,method,options,k)

delta = options.delta;
d_k = CGSubSolver(g, H, delta, options.term_tol_CG);
model = @(d) f + g.'*d + 0.5*d.'*H*d;
rho = (f - problem.compute_f(x + d_k))/(f - model(d_k));

if rho > options.c1_tr
    x_new = x + d_k;
    f_new = problem.compute_f(x_new);
    g_new = problem.compute_g(x_new);
    H_new = problem.compute_H(x_new);
    if rho > options.c2_tr
        delta = 2*delta;
    end
else
%     disp("Skipped at iteration " + k)
    x_new = x;
    f_new = f;
    g_new = g;
    H_new = H;
    delta = delta/2;
end
end