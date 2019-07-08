functions = cell(1, 4);
functions{1} = @(x) x^5 - 3*x - 10;
functions{2} = @(x) sin(10*x) + 2*cos(x) - x - 3;
functions{3} = @(x) x + atan(x) - 3;
functions{4} = @(x) (x + 2)*(log(x^2 + x + 1)) + 1;

x0 = 0; x1 = 1; MAX_ITER = 1000; eps = 1e-6;
newton_iters = zeros(1, 4);
secant_iters = zeros(1, 4);
single_secant_iters = zeros(1, 4);

for i = 1 : 4
    [~, newton_iters(i)] = newton_iteration(...
        functions{i}, x0, MAX_ITER, eps);
    [~, secant_iters(i)] = secant_method(...
        functions{i}, x0, x1, MAX_ITER, eps);
    [~, single_secant_iters(i)] = single_point_secant_method(...
        functions{i}, x0, x1, MAX_ITER, eps);
end

