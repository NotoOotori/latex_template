function n = composite_trapezoid(f, a, b, I0, eps)
    n = 1; R = 1;
    while abs(R) >= eps
        h = (b - a) / n;
        x = linspace(a, b, n + 1);
        y = f(x);
        I = (h / 2) * (y(1) + 2 * sum(y(2: n)) + y(n + 1));
        R = I - I0;
        n = n + 1;
    end
    n = n - 1;
end
