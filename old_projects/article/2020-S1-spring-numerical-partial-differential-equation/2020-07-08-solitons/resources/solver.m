% xmax is not contained
function [t, u] = solver(u0, xmin, xmax, xdelta, tmin, tmax, tdelta)
    f = @(t, x) rhs(t, x, xdelta);
    [t, u] = RungeKutta44(f, tmin:tdelta:tmax, u0);
end
