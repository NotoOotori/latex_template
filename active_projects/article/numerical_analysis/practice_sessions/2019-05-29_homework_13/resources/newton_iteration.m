function [x, iter] = newton_iteration(f, x0, MAX_ITER, eps)
    syms u;
    fderi = matlabFunction(diff(f(u))); x = x0;
    for iter = 1 : MAX_ITER
        x = x - f(x)/fderi(x);
        if abs(f(x)) < eps
            break;
        end
    end
end
