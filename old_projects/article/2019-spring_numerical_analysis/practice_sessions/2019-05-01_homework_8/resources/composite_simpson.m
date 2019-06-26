function n = composite_simpson(f, a, b, I0, eps)
    n = 1; R = 1;
    while abs(R) >= eps
        h = (b - a) / n;
        x = linspace(a, b, 2 * n + 1);
        y = f(x);
        I = (h / 6) * (y(1) + 2 * sum(y(3 : 2 : 2*n-1)) ...
            + 4 * sum(y(2 : 2 : 2 * n)) + y(2 * n + 1));
        R = I - I0;
        n = n + 1;
    end
    n = n - 1;
end
