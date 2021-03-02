% Script for question b.
clear; close all;
xmin = -8; xmax = 8; xdelta = 0.1; tmin = 0; tmax = 2; tdelta = 1e-5;
xs = (xmin:xdelta:(xmax-xdelta))';

one_soliton = @(t, x, v, x0) (-v./(2*cosh(sqrt(v).*(x-v.*t-x0)/2).^2));
u0s = -8*exp(-xs.^2);
[ts, us] = solver(u0s, xmin, xmax, xdelta, tmin, tmax, tdelta);

figure;
for t = linspace(tmin, tmax, 101)
    tindex = find(ts==t);
    plot3(t*ones(size(xs)), xs, us(tindex, :)', '-k');
    hold on;
end
axis([tmin, tmax, xmin, xmax, -9, 1]);
title('$u(x, t)$', 'interpreter', 'latex');
xlabel('t', 'interpreter', 'latex');
ylabel('x', 'interpreter', 'latex');
zlabel('u', 'interpreter', 'latex');
