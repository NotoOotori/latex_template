%% Draw contour lines of quadratic model of Rosenbrock function
% Parameters:
%   x0: The point
%   delta: Radius of trust region
function rosenbrock_quadratic_contour(x0, delta)
    f0 = f(x0); g0 = df(x0); B0 = ddf(x0);
    m = @(x1, x2) (f0 + g0(1)*x1 + g0(2)*x2...
        + 0.5*x1.^2*B0(1, 1) + 0.5*x2.^2*B0(2, 2) + x1*x2*B0(1, 2));
    x = linspace(x0(1) - delta, x0(1) + delta, 401);
    y = linspace(x0(2) - delta, x0(2) + delta, 401);
    [X, Y] = meshgrid(x, y);
    Z = m(X, Y);
    contour(X, Y, Z, 10);
    contourcmap('jet', 'Colorbar', 'on');
end
