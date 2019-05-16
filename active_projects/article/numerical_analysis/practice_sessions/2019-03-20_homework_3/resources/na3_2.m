for n = [2 5 8]
    A = get_parameters(n);
    disp(cond(A));
end

n = 5; [A, B] = get_parameters(n); Z = A\B; disp(Z);
B1 = B; B1(end) = B1(end) + 1e-4; Z1 = A\B1; disp(Z1);

function [A, B] = get_parameters(n)
    K = 0 : n; X = 1 + 0.1 * K; A = vander(X); B = sum(A, 2);
end
