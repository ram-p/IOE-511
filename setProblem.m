% Function that specifies the problem. Specifically, a way to compute:
%    (1) function values, (2) gradients, and, (3) Hessians (if necessary).
% Further, provides the optimal function value f* if known.
% Input: problem (struct).
% Output: problem (struct).
% Errors: (1) if problem name is not specified, or
%         (2) if function handles (for function, gradient, Hessian) not found
% Code written by Northwood Team.

function [problem] = setProblem(problem)

% Check if problem name is available.
if ~isfield(problem,'name') || ~isfield(problem, 'x0')
    error('Provide both problem name and starting point!!!')
end

% Set all function handles and optimal function value, if known.
switch problem.name
    case 'P1_quad_10_10'
        problem.compute_f = @quad_10_10_func;
        problem.compute_g = @quad_10_10_grad;
        problem.compute_H = @quad_10_10_Hess;
    case 'P2_quad_10_1000'
        problem.compute_f = @quad_10_1000_func;
        problem.compute_g = @quad_10_1000_grad;
        problem.compute_H = @quad_10_1000_Hess;
    case 'P3_quad_1000_10'
        rng(0);
        q = randn(1000,1);
        Q = sprandsym(1000,0.5,0.1,1);
        problem.compute_f = @(x) quad_1000_10_func(x, Q, q);
        problem.compute_g = @(x) quad_1000_10_grad(x, Q, q);
        problem.compute_H = @(x) quad_1000_10_Hess(x, Q, q);
    case 'P4_quad_1000_1000'
        rng(0);
        q = randn(1000,1);
        Q = sprandsym(1000,0.5,1e-3,1);
        problem.compute_f = @(x) quad_1000_1000_func(x, Q, q);
        problem.compute_g = @(x) quad_1000_1000_grad(x, Q, q);
        problem.compute_H = @(x) quad_1000_1000_Hess(x, Q, q);
    case 'P5_Quartic_1'
        problem.compute_f = @quartic_1_func;
        problem.compute_g = @quartic_1_grad;
        problem.compute_H = @quartic_1_Hess;
    case 'P6_Quartic_2'
        problem.compute_f = @quartic_2_func;
        problem.compute_g = @quartic_2_grad;
        problem.compute_H = @quartic_2_Hess;
    case 'P7_Rosenbrock_2'
        problem.compute_f = @rosenbrock_2_func;
        problem.compute_g = @rosenbrock_2_grad;
        problem.compute_H = @rosenbrock_2_Hess;
        problem.fstar = 0;
    case 'P8_Rosenbrock_100'
        problem.compute_f = @rosenbrock_100_func;
        problem.compute_g = @rosenbrock_100_grad;
        problem.compute_H = @rosenbrock_100_Hess;
        problem.fstar = 0;
    case 'P9_DataFit_2'
        problem.compute_f = @datafit_2_func;
        problem.compute_g = @datafit_2_grad;
        problem.compute_H = @datafit_2_Hess;
        problem.fstar = 0;
    case 'P10_Exponential_10'
        problem.compute_f = @exp_10_func;
        problem.compute_g = @exp_10_grad;
        problem.compute_H = @exp_10_Hess;
    case 'P11_Exponential_100'
        problem.compute_f = @exp_100_func;
        problem.compute_g = @exp_100_grad;
        problem.compute_H = @exp_100_Hess;
    case 'P12_Genhumps_5'
        problem.compute_f = @genhumps_5_func;
        problem.compute_g = @genhumps_5_grad;
        problem.compute_H = @genhumps_5_Hess;
    otherwise
        error('Problem not defined!!!')
end