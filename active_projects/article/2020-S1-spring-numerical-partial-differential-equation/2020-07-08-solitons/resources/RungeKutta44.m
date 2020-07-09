% Y0 must be a column vector
function [TOUT, YOUT] = RungeKutta44(ODEFUN, TSPAN, Y0)
    TOUT = TSPAN;
    YOUT = zeros(length(TSPAN), length(Y0));
    YOUT(1, :) = Y0';
    u = Y0;
    for i = 2 : length(TSPAN)
        t = TSPAN(i);
        tdelta = TSPAN(i) - TSPAN(i-1);
        alpha1 = tdelta*ODEFUN(t, u);
        alpha2 = tdelta*ODEFUN(t, u+alpha1/2);
        alpha3 = tdelta*ODEFUN(t, u+alpha2/2);
        alpha4 = tdelta*ODEFUN(t, u+alpha3);
        u = u + alpha1/6 + alpha2/3 + alpha3/3 + alpha4/6;
        YOUT(i, :) = u';
    end
end
