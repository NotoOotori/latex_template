% Discretization of right hand side of the problem.
function f = rhs(~, u, xdelta)
    if size(u, 2) ~= 1
        error('Parameter u should be a column vector.');
    end
    ufat = [u(end-1); u(end); u; u(1); u(2)];
    ux = (ufat(4:end-1)-ufat(2:end-3))/(2*xdelta);
    uxxx = (ufat(5:end)-2*ufat(4:end-1)+2*ufat(2:end-3)-ufat(1:end-4))...
        /(2*xdelta^3);
    f = 6*u.*ux-uxxx;
end
