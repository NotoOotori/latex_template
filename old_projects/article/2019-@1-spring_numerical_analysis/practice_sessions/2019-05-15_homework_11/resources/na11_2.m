function [x, iter] = na11_2(N, MAX_ITER, eps)
    A = get_A(N); b = (1 : N)';
    [x, iter] = gauss_seidel_iteration(A, b, MAX_ITER, eps);
end

function A = get_A(N)
    A = zeros(N); DIAG = diag((1 : N).^2);
    for i = 1 : N
        for j = i + 1 : N
            A(i, j) = 1/(i + j + 1);
        end
    end
    A = A + A' + DIAG;
end
