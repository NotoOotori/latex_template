%% Plot the contour of the solution.
function plot_contour(U, N, l, b, h)
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
    patch([0, BC, AD, 0], [0, 0, AC, AC], -ones(1, 4), 0, 'facecolor', [.8,.8,.8]); % I don't know why there are 4 parametres.
    [C, h] = contour(XX, YY, U, 0:0.02:max(U(:)), '-k');
    clabel(C, h);
    xlabel('$y$', 'interpreter', 'latex');
    ylabel('$1-x$', 'interpreter', 'latex');
end
