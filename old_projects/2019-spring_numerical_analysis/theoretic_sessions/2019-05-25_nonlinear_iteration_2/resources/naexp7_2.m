function naexp7_2()
    f = get_f();
    xs = linspace(-10, 10, 1001);
    ys = f(xs); zs = zeros(size(xs)); zs = zs + 2;
    hold on;
    plot(xs, ys); plot(xs, zs);
end

function f = get_f()
    g = @(x, k) (k*exp(-cos(k*x))*sin(k*x));
    syms x; f = 0;
    for k = 1 : 10
        f = f + g(x, k);
    end
    f = matlabFunction(f - 2);
end
