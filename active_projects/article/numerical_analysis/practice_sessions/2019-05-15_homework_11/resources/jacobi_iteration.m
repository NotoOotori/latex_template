function [x, iter] = jacobi_iteration(A, b, MAX_ITER, eps)
    D = diag(diag(A)); L = D - tril(A); U = D - triu(A);
    x = zeros(size(b));
    for iter = 1 : MAX_ITER
        x = D\(b + L*x + U*x);
        error = norm(b-A*x)/norm(b);
        if (error < eps)
            break;
        end
    end
end
