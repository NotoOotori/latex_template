a = 0; b = 1; eps = 1e-6;
n1 = zeros(1, 5); n2 = zeros(1, 5);
for alpha = 0 : 4
    f = @(x) (x.^(alpha + 0.6));
    n1(alpha + 1) = composite_trapezoid(f, a, b, integral(f, a, b), eps);
    n2(alpha + 1) = composite_simpson(f, a, b, integral(f, a, b), eps);
end
