%% Calculate the solution with a given grid size N and given parameters l, b, and h.
function [U, A, f] = solve_problem(N, l, b, h)
    %#ok<*AGROW>
    
    % Pre.
    [AC, AD, BC, ~, Delta] = get_constants(N, l, b, h);

    % Transform the index from 2D to 1D.
    % Example: k_(0, 0) -> 1; k_(1, 1) -> N + 2
    function k = k_(i, j)
        k = i*N + (j + 1);
        if k > N*N || k < 0
            error('Output k out of range! N = %d, k = %d, (i, j) = (%d, %d).', N, k, i, j);
        end
    end

    % Transform the index from 1D to 2D.
    % Example: ij_(N + 3) -> [1, 2, 1/Delta, 2/Delta]
    function [i, j, xi, eta] = ij_(k)
        i = floor((k - 1)/N);
        j = mod(k - 1, N);
        xi = i*Delta;
        eta = j*Delta;
        if i >= N || i < 0 || j >= N || j < 0
            error('Output (i, j) out of range! N = %d, k = %d, (i, j) = (%d, %d).', N, k, i, j);
        end
    end

    % Insert new entry to the coefficient sparse matrix.
    function insert_entry(i, j, v)
        I(end + 1) = i;
        J(end + 1) = j;
        V(end + 1) = v;
    end

    % Jacobian.
    xi_x = @(xi, eta) 1/AC;
    xi_y = @(xi, eta) 0;
    eta_x = @(xi, eta) -(BC - AD)*eta/ (AC*(BC*xi + AD*(1 - xi)));
    eta_y = @(xi, eta) 1/(BC*xi + AD*(1 - xi));
    eta_xx = @(xi, eta) 2*(BC - AD)^2*eta/(AC^2*(BC*xi + AD*(1 - xi)));
    eta_yy = @(xi, eta) 0;
    
    % Coeffcients of the transformed PDE.
    aa = @(xi, eta) xi_x(xi, eta)^2 + xi_y(xi, eta)^2;
    bb = @(xi, eta) 2*(xi_x(xi, eta)*eta_x(xi, eta) + xi_y(xi, eta)*eta_y(xi, eta));
    cc = @(xi, eta) eta_x(xi, eta)^2 + eta_y(xi, eta)^2;
    ee = @(xi, eta) eta_xx(xi, eta) + eta_yy(xi, eta);
    
    % Discretization.
    I = []; J = []; V = []; % Entries for sparse matrix A.
    f = zeros(N*N, 1);
    for k = 1 : N*N
        [i, j, xi, eta] = ij_(k);
        if i == 0 && j == 0 % At point A'.
            insert_entry(k, k_(i, j), -3*(cc(xi, eta)^(-1/2)*xi_x(xi, eta)*eta_x(xi, eta) + cc(xi, eta)^(1/2))/(2*Delta));
            insert_entry(k, k_(i + 1, j), 2*cc(xi, eta)^(-1/2)*xi_x(xi, eta)*eta_x(xi, eta)/Delta);
            insert_entry(k, k_(i + 2, j), -cc(xi, eta)^(-1/2)*xi_x(xi, eta)*eta_x(xi, eta)/(2*Delta));
            insert_entry(k,  k_(i, j + 1), 2*cc(xi, eta)^(1/2)/Delta);
            insert_entry(k,  k_(i, j + 2), -cc(xi, eta)^(1/2)/(2*Delta));
            f(k) = 0;
        elseif i ~= N - 1 && j == 0 % In line A'C'.
            insert_entry(k, k_(i + 1, j), cc(xi, eta)^(-1/2)*xi_x(xi, eta)*eta_x(xi, eta)/(2*Delta));
            insert_entry(k, k_(i - 1, j), -cc(xi, eta)^(-1/2)*xi_x(xi, eta)*eta_x(xi, eta)/(2*Delta));
            insert_entry(k, k_(i, j), -3*cc(xi, eta)^(1/2)/(2*Delta));
            insert_entry(k, k_(i, j + 1), 2*cc(xi, eta)^(1/2)/Delta);
            insert_entry(k, k_(i, j + 2), -cc(xi, eta)^(1/2)/(2*Delta));
            f(k) = 0;
        elseif i == 0 && j ~= N - 1 % In line A'D'.
            insert_entry(k, k_(i, j), -3*xi_x(xi, eta)/(2*Delta));
            insert_entry(k, k_(i + 1, j), 2*xi_x(xi, eta)/Delta);
            insert_entry(k, k_(i + 2, j), -xi_x(xi, eta)/(2*Delta));
            insert_entry(k, k_(i, j + 1), eta_x(xi, eta)/(2*Delta));
            insert_entry(k, k_(i, j - 1), -eta_x(xi, eta)/(2*Delta));
            f(k) = 0;
        elseif i == 0 || i == N - 1 || j == 0 || j == N - 1 % In line B'C' or B'D' or at point B', C' or D'.
            insert_entry(k, k_(i, j), 1);
            f(k) = 0;
        elseif i ~= 0 && i ~= N - 1 && j ~= 0 && j ~= N - 1 % In \hat{\Omega}.
            insert_entry(k, k_(i - 1, j - 1), -bb(xi, eta)/(4*Delta^2));
            insert_entry(k, k_(i - 1, j + 1), bb(xi, eta)/(4*Delta^2));
            insert_entry(k, k_(i + 1, j - 1), bb(xi, eta)/(4*Delta^2));
            insert_entry(k, k_(i + 1, j + 1), -bb(xi, eta)/(4*Delta^2));
            insert_entry(k, k_(i - 1, j), -aa(xi, eta)/Delta^2);
            insert_entry(k, k_(i + 1, j), -aa(xi, eta)/Delta^2);
            insert_entry(k, k_(i, j - 1), -cc(xi, eta)/Delta^2 + ee(xi, eta)/(2*Delta));
            insert_entry(k, k_(i, j + 1), -cc(xi, eta)/Delta^2 - ee(xi, eta)/(2*Delta));
            insert_entry(k, k_(i, j), 2*(aa(xi, eta) + cc(xi, eta))/Delta^2);
            f(k) = 1;
        else
            error('Error occurred! N = %d, (i, j) = (%d, %d).', N, i, j);
        end
    end
    if length(f) ~= N*N
        error('Error occurred! The array f should have %d elements, but it had %d.', N*N, length(f));
    end
    A = sparse(I, J, V);
    if ~isequal(size(A), [N*N, N*N])
        size_A = size(A);
        error('Error occurred! The size of sparse matrix A should be %d*%d, but it was %d*%d.', N, N, size_A(1), size_A(2));
    end
    u = A\f;
    U = reshape(u, N, N)';
end
