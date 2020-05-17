%% Add zeros to the boundary of the matrix A.
function B = edge_zeros(A)
    [m, n] = size(A);
    B = [zeros(1, n + 2); zeros(m, 1), A, zeros(m, 1); zeros(1, n + 2)];
end
