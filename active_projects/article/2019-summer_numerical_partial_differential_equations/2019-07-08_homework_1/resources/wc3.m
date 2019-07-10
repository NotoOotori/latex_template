a = 10; b = 8/3; r = 28;
odefun = @(t, x) [-a*x(1)-a*x(2); r*x(1)-x(2)+x(1)*x(3); -b*x(3)+x(1)*x(2)];
tspan = [0 20]; x0 = [5; 5; 5]; steplen = 0.1;
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

figure(3); hold on; legend(); xlabel('t'); ylabel('w');
plot(t1, x1(:, 3), 'DisplayName', 'runge kutta 44');
plot(t2, x2(:, 3), 'DisplayName', 'ode45');
hold off;

