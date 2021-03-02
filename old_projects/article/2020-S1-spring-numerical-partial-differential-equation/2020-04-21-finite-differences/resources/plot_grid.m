%% Plot the grid of the discretization method.
function plot_grid(N, l, b, h)
    [AC, AD, BC, ~, ~] = get_constants(N, l, b, h);

    xi = linspace(0, 1, N);
    eta = linspace(0, 1, N);
    [Xi, Eta] = meshgrid(xi, eta);
    Xi = Xi'; Eta = Eta'; % Important!

    X = AC*Xi;
    Y = Eta.*(BC*Xi + AD*(1 - Xi));
    XX = Y;
    YY = AC - X;

    figure; hold on; axis('square');
    plot(XX, YY, '-k');
    plot(XX', YY', '-k');
    xlabel('$y$', 'interpreter', 'latex');
    ylabel('$1-x$', 'interpreter', 'latex');
end
