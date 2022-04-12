% TRSubSolver: Approximately solves the Trust Region Subproblem via
% conjugate gradients
%   inputs: gradient at step k
%           Hessian approximation at step k
%           Trust region radius at step k
%           termination tolerance

function [d_k] = CGSubSolver(g_k, B_k, delta_k, term_tol)

z = zeros(size(g_k));
r = g_k;
p = -r;

if norm(r) < term_tol
    d_k = z;
    return;
end

while true
    if p.'*B_k*p <= 0
        prod1 = p.' * z;
        prod2 = p.'*p;
        prod3 = z.'*z;
        tau = (sqrt(prod1^2 + prod2*(delta_k^2 - prod3)) - 2*prod1)/2*prod2;
        d_k = z+tau*p;
        return;
    end
    alpha = (r.'*r)/(p.'*B_k*p);
    z_new = z + alpha * p;
    if norm(z_new) >= delta_k
        prod1 = p.' * z;
        prod2 = p.'*p;
        prod3 = z.'*z;
        tau = (sqrt(prod1^2 + prod2*(delta_k^2 - prod3)) - prod1)/prod2;
        d_k = z+tau*p;
        return;
    end
    r_new = r + alpha*B_k*p;
    if norm(r_new) <= term_tol
        d_k = z_new;
        return;
    end
    beta = (r_new.'*r_new)/(r.'*r);
    p_new = -r_new + beta * p;
    
    p = p_new;
    z = z_new;
    r = r_new;

end
end

