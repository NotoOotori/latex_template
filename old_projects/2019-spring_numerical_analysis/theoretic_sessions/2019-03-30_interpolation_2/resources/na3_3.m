x = linspace(-5, 5, 21);
y = 1./(x.^2 + 1);
p = newton_interpolation(x, y);

x0 = linspace(-5, 5, 2001);
y0 = 1./(x0.^2 + 1);
x1 = linspace(-5, 5, 2001);
y1 = polyval(p, x1);

hold on;
plot(x0, y0);
plot(x1, y1);
