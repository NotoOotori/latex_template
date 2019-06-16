function A = eig_qr(A, MAX_ITER, eps)
    Aprev = A;
    for k = 1 : MAX_ITER
        [Q, R] = qr(A);
        A = R*Q;
        A(A <= eps) = 0;
        error = norm(diag(A - Aprev));
        Aprev = A;
        if (error <= eps)
            break;
        end
    end
end
