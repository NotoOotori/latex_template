function [x, iter] = modified_newton_iteration(f, x0, MAX_ITER, eps)
    syms u;
    fderi = matlabFunction(diff(f(u))); x = x0;
    for iter = 1 : MAX_ITER
        delta = -f(x)/fderi(x);
        lambda = 1;
        while lambda > eps
            xtemp = x + lambda*delta;
            if abs(f(xtemp)) < abs(f(x))
                x = xtemp;
                break;
            end
            lambda = lambda/2;
        end
        x = x - f(x)/fderi(x);
        if abs(f(x)) < eps
            break;
        end
    end
end
