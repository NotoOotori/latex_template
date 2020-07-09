% Script for question a.
clear; close all;
xmin = -8; xmax = 8; xdelta = 0.1; tmin = 0; tmax = 2; tdelta = 1e-5;
xs = (xmin:xdelta:(xmax-xdelta))';

one_soliton = @(t, x, v, x0) (-v./(2*cosh(sqrt(v).*(x-v.*t-x0)/2).^2));
u0s = one_soliton(0, xs, 16, 0);
[ts, us] = solver(u0s, xmin, xmax, xdelta, tmin, tmax, tdelta);

for t = [0.4, 0.5, 2.0]
    figure; hold on;
    tindex = find(ts==t);
    plot(xs, us(tindex, :), 'DisplayName', 'numerical solution');
    plot(xs, one_soliton(t, xs, 16, 0), ...
        'DisplayName', 'one-soliton solution');
    legend();
    title(['$u(x, t=', num2str(t, '%.2f'), ')$'], 'interpreter', 'latex')
end
