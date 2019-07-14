function [x, iter] = secant_method(f, x0, x1, MAX_ITER, eps)
    x = x1; xprev = x0;
    for iter = 1 : MAX_ITER
        xtemp = x;
        x = x - f(x)*(x - xprev)/(f(x) - f(xprev));
        xprev = xtemp;
        if abs(f(x)) < eps
            break;
        end
    end
end
