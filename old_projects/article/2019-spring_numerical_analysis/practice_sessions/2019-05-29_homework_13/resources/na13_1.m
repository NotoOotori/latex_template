f = @(x) x - 4 + 2.^x;
xs = linspace(-4, 4, 1001); ys = f(xs); plot(xs, ys);
iter_func = @(x) log(4 - x)/log(2);
[x, iter] = fix_point_iteration(iter_func, 1.5, 1000, 1e-6);
disp(x); disp(iter);