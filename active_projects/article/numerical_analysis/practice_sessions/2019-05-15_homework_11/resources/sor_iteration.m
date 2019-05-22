function [x, iter] = sor_iteration(A, b, omega, MAX_ITER, eps)
    D = diag(diag(A)); L = D - tril(A); U = D - triu(A);
    x = zeros(size(b));
    for iter = 1 : MAX_ITER
        x = (D - omega*L)\(omega*b + (1 - omega)*D*x + omega*U*x);
        error = norm(b - A*x) / norm(b);
        if (error < eps)
            break;
        end
    end
end
