% IOE 511/MATH 562, University of Michigan
% Code written by: Batman

% Function that specifies the problem. Specifically, a way to compute: 
%    (1) function values; (2) gradients; and, (3) Hessians (if necessary).
% Further, provides the optimal function value f* based on the problem.
%           Input: problem (struct), required (problem.name)
%           Output: problem (struct)
%
% Error(s): 
%       (1) if problem name not specified;
%       (2) function handles (for function, gradient, Hessian) not found
%
function [problem] = setProblem(problem)

% check is problem name available
if ~isfield(problem,'name') || ~isfield(problem, 'x0')
    error('Provide both problem name and starting point!!!')
end

% set function handles and optimal f* according the the selected problem
switch problem.name
        
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
    
    case 'Datafit'

        problem.compute_f = @datafit_func;
        problem.compute_g = @datafit_grad;
        problem.compute_H = @datafit_Hess;
        problem.fstar = 0;

    case 'Exponential'

        problem.compute_f = @exp_func;
        problem.compute_g = @exp_grad;
        problem.compute_H = @exp_Hess;
        problem.fstar = -0.205;
        
    otherwise
        
        error('Problem not defined!!!')
end