a = 1.2; b = 0.6; c = 0.8; d = 0.3;
odefun = @(t, x) [a*x(1)-b*prod(x); -c*x(2)+d*prod(x)];
tspan = [0 30]; x0 = [2; 1]; steplen = 0.1;
[t1, x1] = ode_runge_kutta_44(odefun, tspan, x0, steplen);
[t2, x2] = ode45(odefun, tspan, x0);

figure(1); hold on; legend(); xlabel('t'); ylabel('u');
plot(t1, x1(:, 1), '-o', 'DisplayName', 'runge kutta 44');
plot(t2, x2(:, 1), 'DisplayName', 'ode45');
hold off;

figure(2); hold on; legend(); xlabel('t'); ylabel('v');
plot(t1, x1(:, 2), 'DisplayName', 'runge kutta 44');
plot(t2, x2(:, 2), '-o', 'DisplayName', 'ode45');
hold off;
