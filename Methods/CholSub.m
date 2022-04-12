function R = CholSub(n, H, beta)

flag = 1;                           % Initializing flag to check if Cholesky is completed successfully
% If-else-endif statements to initialize eta
if min(diag(H)) > 0
    eta = 0;
else
    eta = -min(diag(H)) + beta;
end
% Computing eta that ensures H + eta.I is p.d.
while flag ~= 0
    [R, flag] = chol(H + eta*eye(n));
    eta = max(2*eta, beta);
    %     disp(eta)
end
% if eta ~= 0
%     disp("Hessian modified in iteration " + k + ". Eta = " + eta)
% end

end