function [x, iter] = single_point_secant_method(f, x0, x1, MAX_ITER, eps)
    x = x1;
    for iter = 1 : MAX_ITER
        x = x - f(x)*(x - x0)/(f(x) - f(x0));
        if abs(f(x)) < eps
            break;
        end
    end
end
