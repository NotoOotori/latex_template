% x = (0, -1) or x = (0, 0.5)
clear; close all;
X = [0 -1; 0 0.5]'; lambda0 = 0; eps = 1e-3;
for col = 1 : size(X, 2)
    figure(col); hold on;
    x0 = X(:, col); f0 = f(x0); g0 = df(x0); B0 = ddf(x0);
    rosenbrock_quadratic_contour(x0, 2);
    for delta = 0.2 : 0.2 : 2
        d = trs_iteration(g0, B0, delta, lambda0, eps);
        d = d + x0;
        scatter(d(1), d(2), 100*delta);
    end
end
