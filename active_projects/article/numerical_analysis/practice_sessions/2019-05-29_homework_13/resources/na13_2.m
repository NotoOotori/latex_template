fs = {
    @(x) (x - (x.^2 - 2)/(4*x));
    @(x) (x - (x.^2 - 2)/(2*x));
    @(x) (x - (x*(x.^2 - 2))/(x.^2 + 2))
};
x0 = 1.5; MAX_ITER = 1000; eps = 1e-10; iters = zeros(1, 3);
for i = 1 : 3
    f = fs{i};
    [~, iters(i)] = fix_point_iteration(f, x0, MAX_ITER, eps);
end
disp(iters);
