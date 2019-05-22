function na12_1()
    eps = 1e-6; ks = 100 : 100 : 1000; iters = zeros(size(ks));
    MAX_ITER = 500;
    for i = 1 : length(ks)
        k = ks(i);
    	Nx = k; Ny = k;
        [~, iter] = na12_1_1(Nx, Ny, MAX_ITER, eps);
        iters(i) = iter;
    end
    plot(ks, iters);
end

function [x, iter] = na12_1_1(Nx, Ny, MAX_ITER, eps)
    A = get_A(Nx, Ny); b = ones(length(A), 1);
    [x, iter] = conjugate_gradient(A, b, MAX_ITER, eps);
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
