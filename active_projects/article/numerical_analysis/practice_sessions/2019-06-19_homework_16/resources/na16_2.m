odefun = @(t, x) (5*exp(5*t)*(x-t)^2 + 1);
tspan = [0, 1]; x0 = -1;
hold on;
for steplen = [0.2 0.25]
    [t, x] = ode_runge_kutta_44(odefun, tspan, x0, steplen);
    plot(t, x);
    [t, x] = ode_trapezoid(odefun, tspan, x0, steplen);
    plot(t, x);
end
legend('Runge Kutta (h=0.2)', 'Trapezoid (h=0.2)', ...
    'Runge Kutta (h=0.25)', 'Trapezoid (h=0.25)');
