% IOE 511/MATH 562, University of Michigan
% Code written by: Batman

% Function that: (1) computes the GD step; (2) updates the iterate; and, 
%                (3) computes the function and gradient at the new iterate
% 
%           Inputs: x, f, g, problem, method, options
%           Outputs: x_new, f_new, g_new, d, alpha
%
function [x_new,f_new,g_new,H_new,d,alpha] = NewtonStep(x,f,g,H,problem,method,options, k)

% Algorithm to compute modified search direction: H + eta.I
beta = 1e-6;                        % Beta
flag = 1;                           % Initializing flag to check if Cholesky is completed successfully
% If-else-endif statements to initialize eta
if min(diag(H)) > 0     
    eta = 0;
else
    eta = -min(diag(H)) + beta;
end
% Computing eta that ensures H + eta.I is p.d.
while flag ~= 0
    [R, flag] = chol(H + eta*eye(problem.n));
    eta = max(2*eta, beta);
%     disp(eta)
end
% if eta ~= 0
%     disp("Hessian modified in iteration " + k + ". Eta = " + eta)
% end
% Search direction d = -(R'R)\g;
d = -(R'*R)\g;

% determine step size
switch method.options.step_type
    case 'Constant'
        alpha = method.options.constant_step_size;  % Constant step size specified
        x_new = x + alpha*d;                        % Iterate update
        f_new = problem.compute_f(x_new);           % New function value
        g_new = problem.compute_g(x_new);           % New gradient value
        H_new = problem.compute_H(x_new);           % New Hessian value
    case 'Backtracking'
        abar = 1; tau = 0.5; c1 = 1e-4;             % Parameter initialization for backtracking line search
        while (problem.compute_f(x + abar*d)) > (problem.compute_f(x) + c1*abar*g'*d)       % Condition to continue backtracking
            abar = tau*abar;                        % Backtracking update
        end
        alpha = abar;                               % Set step size when the Armijo condition has been satisfied
        x_new = x + alpha*d;                        % Iterate update    
        f_new = problem.compute_f(x_new);           % New function value
        g_new = problem.compute_g(x_new);           % New gradient value
        H_new = problem.compute_H(x_new);           % New Hessian value

end
end