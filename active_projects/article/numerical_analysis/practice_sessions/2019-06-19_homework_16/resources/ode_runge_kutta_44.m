function [t, x] = ode_runge_kutta_44(odefun, tspan, x0, steplen)
    num = (tspan(2) - tspan(1))/steplen + 1;
    t = zeros(num, 1); x = zeros(num, 1);
    t(1) = tspan(1); x(1) = x0;
    for i = 2 : num
        k1 = steplen * odefun(t(i - 1), x(i - 1));
        k2 = steplen * odefun(t(i - 1) + steplen/2, x(i - 1) + k1/2);
        k3 = steplen * odefun(t(i - 1) + steplen/2, x(i - 1) + k2/2);
        k4 = steplen * odefun(t(i - 1) + steplen, x(i - 1) + k3);
        t(i) = t(i - 1) + steplen;
        x(i) = x(i - 1) + ([1 2 2 1] * [k1 k2 k3 k4]')/6;
    end
end
