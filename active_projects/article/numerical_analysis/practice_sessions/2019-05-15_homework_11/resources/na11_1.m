function [x, iter] = na11_1(Nx, Ny, MAX_ITER, eps)
    A = get_A(Nx, Ny); b = ones(length(A), 1);
    [x, iter] = jacobi_iteration(A, b, MAX_ITER, eps);
end

function A = get_A(Nx, Ny)
    dim = (Nx + 1)*(Ny + 1);
    A = zeros(dim); ONES = ones(1, dim);
    A = A + 4*diag(ONES);
    for k = [-1, 1, Nx + 1, -Nx - 1]
        A = A - diag(ONES, k);
    end
end
