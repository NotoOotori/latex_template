g = 9.81; m = 68.1; cd = 0.25;
gg = sqrt(g); cdmcdm = sqrt(cd/m);
odefun = @(t, x) (g - cd/m*x^2);  tspan = [0 10]; x0 = 0;
sol = @(t) ((gg*(exp(t*2*gg*cdmcdm)-1))./(cdmcdm*(exp(t*2*gg*cdmcdm)+1)));

figure(1); hold on; legend(); xlabel('t'); ylabel('v');
steplen = 0.1;
[t1, x1] = ode_runge_kutta_44(odefun, tspan, x0, steplen);
plot(t1, x1, 'DisplayName', 'runge kutta 44: steplen=0.1');
steplen = 1;
[t2, x2] = ode_runge_kutta_44(odefun, tspan, x0, steplen);
plot(t2, x2, 'DisplayName', 'runge kutta 44: steplen=1');
steplen = 2;
[t3, x3] = ode_runge_kutta_44(odefun, tspan, x0, steplen);
plot(t3, x3, 'DisplayName', 'runge kutta 44: steplen=2');
x1a = sol(t1); x2a = sol(t2); x3a = sol(t3);
plot(t1, x1a, 'DisplayName', 'analytic solution: steplen=0.1');
hold off;

figure(2); hold on; legend(); xlabel('t'); ylabel('v');
plot(t1, x1 - x1a, 'DisplayName', 'diff: steplen=0.1');
plot(t2, x2 - x2a, 'DisplayName', 'diff: steplen=1');
plot(t3, x3 - x3a, 'DisplayName', 'diff: steplen=2');
hold off;
