function [lambda, u] = eig_power(A, v0, MAX_ITER, eps)
    vprev = v0;
    [~, itemp] = max(abs(vprev));
    lamprev = vprev(itemp);
    u = vprev/lamprev;
    for k = 1 : MAX_ITER
        v = A*u;
        [~, itemp] = max(abs(v));
        lambda = v(itemp);
        u = v/lambda;
        error = abs(lambda - lamprev);
        lamprev = lambda;
        if (error <= eps)
            break;
        end
    end
end
