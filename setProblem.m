% IOE 511/MATH 562, University of Michigan
% Code written by: Albert S. Berahas

% Function that specifies the problem. Specifically, a way to compute: 
%    (1) function values; (2) gradients; and, (3) Hessians (if necessary).
%
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

% set function handles according the the selected problem
switch problem.name
        
    case 'P7_Rosenbrock_2'
        problem.compute_f = @rosenbrock_2_func;
        problem.compute_g = @rosenbrock_2_grad;
        problem.compute_H = @rosenbrock_2_Hess;
        problem.fstar = 0;
        
    case 'Quadratic'
        if ~isfield(problem,'A')
            error('Data matrix A not defined')
        elseif ~isfield(problem, 'b')
            error('Data vector b not defined')
        elseif ~isfield(problem, 'c')
            error('Data constant c not defined')
        end
        
        problem.compute_f = @(x)quad_func(problem.A, problem.b, problem.c, x);
        problem.compute_g = @(x)quad_grad(problem.A, problem.b, x);
        problem.compute_H = @(x)quad_Hess(problem.A, x);

    case 'P8_Rosenbrock_100'
        
        problem.compute_f = @rosenbrock_100_func;
        problem.compute_g = @rosenbrock_100_grad;
        problem.compute_H = @rosenbrock_100_Hess;
        problem.fstar = 0;
            
    otherwise
        
        error('Problem not defined!!!')
end