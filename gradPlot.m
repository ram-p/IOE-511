% Function to produce a final plot of f(x_k) - f* vs iterations k

function gradPlot(gplot, k)
    figure(2)
    set(gcf, 'DefaultLineLineWidth', 2)
    % The actual plot command
    semilogy(1:k, gplot(1:k))
    % Axis Labels
    xlabel('Iterations $k$', 'Interpreter', 'latex')
    ylabel('$\|\nabla f(x_k)\|_{\infty}$', 'Interpreter', 'latex')
    grid on
    hold on
    set(gca, 'FontName', 'Times New Roman', 'FontSize', 16)
end