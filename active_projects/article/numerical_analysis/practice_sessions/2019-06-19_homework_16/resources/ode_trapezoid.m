function [t, x] = ode_trapezoid(odefun, tspan, x0, steplen)
    num = (tspan(2) - tspan(1))/steplen + 1;
    t = zeros(num, 1); x = zeros(num, 1);
    t(1) = tspan(1); x(1) = x0;
    for i = 2 : num
        t(i) = t(i - 1) + steplen;
        x(i) = fsolve(@(xnew) (x(i - 1) + steplen / 2 ... 
                * (odefun(t(i - 1), x(i - 1)) + odefun(t(i), xnew)) - xnew), ...
            x(i - 1));
    end
end
