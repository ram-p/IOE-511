function [L, modified] = CholeskySubroutine(A,beta)
%CholeskySubroutine : Tries to apply Cholesky factorization until it is
%possible. Returns the factorized matrix
% 
    modified = false;
    if min(diag(A)) > 0
        eta = 0;
    else
        eta = -min(diag(A)) + beta;
    end
    
    [L, flag] = chol(A);
    while flag ~= 0
        modified = true;
        A = A + eta .* eye(size(A));
        [L, flag] = chol(A);
        eta = max(2*eta, beta);
    end

end

