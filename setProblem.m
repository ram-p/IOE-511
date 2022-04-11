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
if ~isfield(problem,'name')
    error('Problem name not defined!!!')
end

% set function handles and optimal f* according the the selected problem
switch problem.name
        
    case 'Rosenbrock'
        
        problem.compute_f = @rosen_func;
        problem.compute_g = @rosen_grad;
        problem.compute_H = @rosen_Hess;
        problem.fstar = 0;

    case 'Quadratic2'

        problem.compute_f = @quad2_func;
        problem.compute_g = @quad2_grad;
        problem.compute_H = @quad2_Hess;
        load('quadratic2.mat');
        xs = x_star; 
        problem.fstar = 0.5*xs'*A*xs + b'*xs + c;

    case 'Quadratic10'

        problem.compute_f = @quad10_func;
        problem.compute_g = @quad10_grad;
        problem.compute_H = @quad10_Hess;
        load('quadratic10.mat');
        xs = x_star; 
        problem.fstar = 0.5*xs'*A*xs + b'*xs + c;
    
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