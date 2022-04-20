% Function that returns the Cholesky factorization of the modified Hessian, once it is positive definite.
% Inputs: n, H, beta
% Outputs: R
% Code written by Northwood Team.

function R = CholeskySubroutine(n, H, options)

beta = options.beta;
nu = options.nu;

[R, flag] = chol(H);        % Checking if H is positive definite using flag

% If-else-endif statements to initialize eta
if min(diag(H)) > 0
    eta = 0;
else
    eta = -min(diag(H)) + beta;
end

% Computing eta that ensures H + eta.I is p.d.
while flag ~= 0
    [R, flag] = chol(H + eta*eye(n));
    
    % Changed to have a variable multiplication factor
    eta = max(nu*eta, beta);
    disp(eta)
end

% if eta ~= 0
%     disp("Hessian modified in iteration " + k + ". Eta = " + eta)
% end

end