% Function to produce a plot of optimality gap f(x_k) - f* vs iterations k, if f* is known.
% Inputs: Function value vector (fplot), optimal function value (fstar), final iteration number (k).
% Code written by Northwood Team.

function optPlot(fplot, fstar, k, figindex)
    figure(figindex);
    semilogy(1:k, (fplot(1:k)-fstar), 'LineWidth', 2)
    % Various plot options: Axis labels, grid, font size and typeface.
    xlabel('Iterations $k$', 'Interpreter', 'latex')
    ylabel('$f(x_k) - f^*$', 'Interpreter', 'latex')
    grid on
    hold on
    set(gca, 'FontName', 'Times New Roman', 'FontSize', 16)
end