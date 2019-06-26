function omega = myoption(A, b)
    MAX_ITER = 100; eps = 1e-6; omega = 0; iter = MAX_ITER;
    for omega_temp = 0.01: 0.01: 1.99
        [~, iter_temp] = sor_iteration(A, b, omega_temp, MAX_ITER, eps);
        if iter_temp < iter
            omega = omega_temp; iter = iter_temp;
        end
    end
end

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
