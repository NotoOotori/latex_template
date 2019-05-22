function [x, iter] = fix_point_iteration(iter_func, x0, MAX_ITER, eps)
    x = x0;
    for iter = 1 : MAX_ITER
        xprev = x;
        x = iter_func(x);
        if abs(xprev - x) < eps
            break;
        end
    end
end
