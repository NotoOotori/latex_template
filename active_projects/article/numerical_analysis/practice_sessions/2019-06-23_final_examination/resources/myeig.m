function LAMBDA = myeig(A)
    dim = length(A);
    v0 = (1:dim)'; MAX_ITER = 1000; eps = 1e-6; LAMBDA = zeros(dim, 1);
    for i = 1 : dim
        [lambda, u] = eig_power(A, v0, MAX_ITER, eps);
        LAMBDA(i) = lambda;
        A = A - lambda * (u * u');
    end
end

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
            u = u / norm(u);
            break;
        end
    end
end
