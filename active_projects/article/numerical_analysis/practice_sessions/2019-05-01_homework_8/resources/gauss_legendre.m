function n = gauss_legendre(f, I0, eps)
    n = 1; R = 1;
    while abs(R) >= eps
        [x, w] = pre_gauss_legendre(n);
        I = dot(f(x), w);
        R = I - I0;
        n = n + 1;
    end
    n = n - 1;
end

function [x, w] = pre_gauss_legendre(n)
    a = zeros(n, 1);
    b = a; b(1) = 2;
    k = 2 : n;
    b(k) = 1./(4-1./(k-1).^2);
    
    A = diag(a) + diag(sqrt(b(2 : n)), 1) + diag(sqrt(b(2 : n)), -1);
    [w, x] = eig(A);
    scal = 2;
    w = w(1, :)'.^2*scal;
    x = diag(x);
end
