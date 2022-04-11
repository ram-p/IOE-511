% Code that computes Hessian for the data-fit function

function H = datafit_Hess(x)
    y = [1.5; 2.25; 2.625];
    H = [0 0; 0 0];
    for i = 1:length(y)
        H(1, 1) = H(1, 1) + 2*(1 - (x(2))^i)^2;
        H(1, 2) = H(1, 2) + 2*(i*y(i)*(x(2))^(i-1) + 2*x(1)*(1 - (x(2))^i)*i*(x(2))^(i-1));
        H(2, 1) = H(1, 2);
        H(2, 2) = H(2, 2) + 2*(i*y(i)*(x(2))^(i-1) - 2*x(1)*i*(x(2))^(i-1)*(1 - (x(2))^i)); 
    end
end