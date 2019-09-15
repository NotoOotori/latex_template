function na15_3()
    MAX_ITER = 200; eps = 1e-5;
    for n = 100 : 100 : 1000
        A = get_A(n); v0 = ones(n, 1);
        lammax = eig_power(A, v0, MAX_ITER, eps);
        lammin = eig_inverse_power(A, v0, MAX_ITER, eps);
        disp([lammax/lammin cond(A)]);
    end
end

function A = get_A(n)
    A = 2*diag(ones(1, n))-diag(ones(1, n-1), 1)-diag(ones(1, n-1), -1);
end
