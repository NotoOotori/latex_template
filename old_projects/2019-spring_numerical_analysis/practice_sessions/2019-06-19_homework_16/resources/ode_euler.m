function [t, x] = ode_euler(odefun, tspan, x0, steplen)
    num = (tspan(2) - tspan(1))/steplen + 1;
    t = zeros(num, 1); x = zeros(num, 1);
    t(1) = tspan(1); x(1) = x0;
    for i = 2 : num
        t(i) = t(i - 1) + steplen;
        x(i) = x(i - 1) + steplen * odefun(t(i - 1), x(i - 1));
    end
end
