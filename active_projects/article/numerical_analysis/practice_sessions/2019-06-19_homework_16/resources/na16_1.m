odefun = @(t, x) (-1/t^2 - x/t - t^2);
tspan = [1 2]; x0 = -1; steplen = 0.01;
hold on;
[t, x] = ode_euler(odefun, tspan, x0, steplen);
plot(t, x);
[t, x] = ode_trapezoid(odefun, tspan, x0, steplen);
plot(t, x);
[t, x] = ode_improved_euler(odefun, tspan, x0, steplen);
plot(t, x);
[t, x] = ode_runge_kutta_44(odefun, tspan, x0, steplen);
plot(t, x);
legend('Euler', 'Trapezoid', 'Improved Euler', 'Runge Kutta');