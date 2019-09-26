clear; close all;
x = linspace(-2, 2, 401);
y = linspace(-2, 2, 401);
[X, Y] = meshgrid(x, y);
Z = f_cdn(X, Y);
contour(X, Y, Z, 2.^(-10:10));
contourcmap('jet', 'Colorbar', 'on');
