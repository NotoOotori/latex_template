x = linspace(-5, 5, 41);
y = 1./(x.^2 + 1);

x0 = linspace(-5, 5, 2001);
y0 = 1./(x0.^2 + 1);
x1 = linspace(-5, 5, 2001);
y1 = spline(x, y, x1);

hold on;
plot(x0, y0);
plot(x1, y1);
