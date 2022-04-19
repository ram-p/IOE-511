% Code that computes gradient for the data-fit function

function g = datafit_2_grad(x)
    y = [1.5; 2.25; 2.625];
    g = [0; 0];
    for i = 1:length(y)
        g(1) = g(1) - 2*(y(i) - x(1)*(1 - x(2)^i))*(1 - x(2)^i);
        g(2) = g(2) + 2*(y(i) - x(1)*(1 - x(2)^i))*x(1)*i*(x(2)^(i-1));
    end
end