% Function to produce a final plot of f(x_k) - f* vs iterations k

function optPlot(fplot, fstar, k)
    figure(1)
    set(gcf, 'DefaultLineLineWidth', 2)
    % The actual plot command
    semilogy(1:k, (fplot(1:k)-fstar))
    % Axis Labels
    xlabel('Iterations $k$', 'Interpreter', 'latex')
    ylabel('$f(x_k) - f^*$', 'Interpreter', 'latex')
    grid on
    hold on
    set(gca, 'FontName', 'Times New Roman', 'FontSize', 16)
end