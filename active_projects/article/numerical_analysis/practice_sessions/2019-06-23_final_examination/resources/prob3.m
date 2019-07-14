for n = [8 16 32]
    A = get_A(n); b = get_b(n);
    omega = myoption(A, b);
    fprintf('The best omega equals %.2f when n = %d.\n', omega, n);
end

function A = get_A(n)
    negative_ones = -1 * ones(1, n - 1);
    twos = 2 * ones(1, n);
    A = diag(twos) + diag(negative_ones, 1) + diag(negative_ones, -1);
end

function b = get_b(n)
    b = ones(n, 1);
end
