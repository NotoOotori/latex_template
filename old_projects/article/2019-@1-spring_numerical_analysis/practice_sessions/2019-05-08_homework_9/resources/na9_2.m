hold on;
N = [4 8 16 32];
for i = 1 : length(N)
    n = N(i); X = get_X(n); A = get_A(X); Y = get_Y(X);
    U = A\Y;
    disp(cond(A));
    subplot(2, 2, i); plot(X, U); title(sprintf('n=%d', n));
end

function X = get_X(n)
    X = linspace(0, 1, n + 1)';
end

function A = get_A(X)
    n = length(X) - 1;
    ZERO = zeros(n + 1, 1);
    A = sqrt(X.^2 + X'.^2);
    A = (A + [ZERO A(:, 2: end-1) ZERO])./(2*n);
end

function Y = get_Y(X)
    Y = ((X.^2 + 1).^(3/2) - X.^3)./3;
end
