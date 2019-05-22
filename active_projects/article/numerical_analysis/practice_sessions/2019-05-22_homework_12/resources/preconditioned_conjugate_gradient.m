function [x, iter] = preconditioned_conjugate_gradient(A, b, M, MAX_ITER, eps)
    p = M\b; r = p; x = zeros(size(b));
    for iter = 1 : MAX_ITER
        rnorm2 = r'* r;
        a = rnorm2/(p'*(M\(A*p)));
        x = x + a*p;
        r = r - a*(M\(A*p));
        if norm(r) < eps
            break;
        end
        b = (r'*r)/rnorm2;
        p = r + b*p;
    end
end
