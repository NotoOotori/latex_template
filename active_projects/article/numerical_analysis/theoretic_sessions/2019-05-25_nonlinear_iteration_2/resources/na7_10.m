f = @(x) 3*x^3 - 8*x^2 - 8*x - 11;
[x, iter] = newton_iteration(f, 0, 1000, 1e-4);
disp(x); disp(iter);
