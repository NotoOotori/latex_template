function [Q, R] = myqr(A)
    format long;
    n = length(A); Q_inv = eye(n); R = A;
    for i = 1 : n - 1
        x = R(i : end, i);
        P = householder_transformation(x);
        P = [eye(i - 1) zeros(i - 1, n - i + 1); zeros(n - i + 1, i - 1) P];
        R = P * R; R(abs(R) < 1e-10) = 0; Q_inv = P * Q_inv;
        Q = Q_inv';
    end
end

function P = householder_transformation(x)
    % x is a column vector.
    dim = length(x);
    x(1) = x(1) + sign(x(1)) * norm(x);
    beta = 2 / (norm(x)^2);
    P = eye(dim) - beta * (x * x');
end
