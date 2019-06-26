function [x, iter] = conjugate_gradient(A, b, MAX_ITER, eps)
    p = b; r = b; x = zeros(size(b));
    for iter = 1 : MAX_ITER
        rnorm2 = r'* r;
        a = rnorm2/(p'*(A*p));
        x = x + a*p;
        r = r - a*A*p;
        if norm(r) < eps
            break;
        end
        b = (r'*r)/rnorm2;
        p = r + b*p;
    end
end
