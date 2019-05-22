function omega = na11_3(Nx, Ny, MAX_ITER, eps)
    omegas = 0 : 0.1 : 2; L = length(omegas);
    iters = zeros(1, length(omegas));
    for i = 1 : L
        [~, iter] = na11_3_1(Nx, Ny, omegas(i), MAX_ITER, eps);
        iters(i) = iter;
    end
    [~, min_index] = min(iters);
    omega = omegas(min_index);
end

function [x, iter] = na11_3_1(Nx, Ny, omega, MAX_ITER, eps)
    A = get_A(Nx, Ny); b = ones(length(A), 1);
    [x, iter] = sor_iteration(A, b, omega, MAX_ITER, eps);
end

function A = get_A(Nx, Ny)
    dim = (Nx + 1)*(Ny + 1);
    A = zeros(dim); ONES = ones(1, dim);
    A = A + 4*diag(ONES);
    for k = [-1, 1, Nx + 1, -Nx - 1]
        temp_diag = diag(ONES, k);
        A = A - temp_diag(1 : dim, 1 : dim);
    end
end
