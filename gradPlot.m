% Function to produce a plot of gradient norm vs iterations.
% Inputs: Gradient norm vector (gplot), final iteration number (k).
% Code written by Northwood Team.

function gradPlot(gplot, k, figindex)
    figure(figindex);
    semilogy(1:k, gplot(1:k), 'LineWidth', 2)
    % Various plot options: Axis labels, grid, font size and typeface.
    xlabel('Iterations $k$', 'Interpreter', 'latex')
    ylabel('$\|\nabla f(x_k)\|_{\infty}$', 'Interpreter', 'latex')
    grid on
    hold on
    set(gca, 'FontName', 'Times New Roman', 'FontSize', 16)
end