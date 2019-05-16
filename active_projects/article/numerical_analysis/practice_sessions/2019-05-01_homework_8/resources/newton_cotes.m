f = @(x) (1./(1+x.^2));
I0 = 2*atan(5);
I = zeros(1, 50);
R = zeros(1, 50);
for n = 1 : 50
    x = linspace(-5, 5, n + 1);
    y = f(x);
    p = newton_interpolation(x, y);
    I(n) = diff(polyval(polyint(p), [-5, 5]));
    R(n) = I(n) - I0;
end
plot(R);
