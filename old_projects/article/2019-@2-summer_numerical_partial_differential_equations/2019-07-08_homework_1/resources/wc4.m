mu = 1000;
odefun = @(t, x) [x(2); mu*(1-x(1)^2)*x(2)-x(1)];
tspan = [0 20]; x0 = [1; 1]; steplen = 0.0001;
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
