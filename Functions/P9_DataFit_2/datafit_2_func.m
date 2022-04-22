% Code that computes function value for the data-fit function

function f = datafit_2_func(x)
    y = [1.5; 2.25; 2.625];
    f = 0;
    for i = 1:length(y)
        f = f + (y(i) - x(1)*(1 - x(2)^i))^2;
    end
end