f = @(x) (x.^2 - 0.2)*exp(-0.5*x); MAX_ITER = 1000; eps = 1e-6;
[x, iter] = newton_iteration(f, -0.01, MAX_ITER, eps);
fprintf('%f %d\n', x, iter);
[x, iter] = newton_iteration(f, -0.03, MAX_ITER, eps);
fprintf('%f %d\n', x, iter);
[x, iter] = modified_newton_iteration(f, -0.01, MAX_ITER, eps);
fprintf('%f %d\n', x, iter);
[x, iter] = modified_newton_iteration(f, -0.03, MAX_ITER, eps);
fprintf('%f %d\n', x, iter);
