f = @(x) (11*x.^11 - 1); iters = zeros(1, 3);
x0 = 1; x1 = 1.5; MAX_ITER = 1000; eps = 1e-3;
[~, iters(1)] = newton_iteration(f, x0, MAX_ITER, eps);
[~, iters(2)] = single_point_secant_method(f, x0, x1, MAX_ITER, eps);
[~, iters(3)] = secant_method(f, x0, x1, MAX_ITER, eps);
disp(iters);
