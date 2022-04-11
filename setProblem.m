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
if ~isfield(problem,'name')
    error('Problem name not defined!!!')
end

% set function handles according the the selected problem
switch problem.name
        
    case 'Rosenbrock'
        
        problem.compute_f = @rosen_func;
        problem.compute_g = @rosen_grad;
        problem.compute_H = @rosen_Hess;

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
    
    case 'Function2'
        
        problem.compute_f = @func2_func;
        problem.compute_g = @func2_grad;
        problem.compute_H = @func2_Hess;

    case 'Function3'
        
        problem.compute_f = @func3_func;
        problem.compute_g = @func3_grad;
        problem.compute_H = @func3_Hess;
        
    otherwise
        
        error('Problem not defined!!!')
end