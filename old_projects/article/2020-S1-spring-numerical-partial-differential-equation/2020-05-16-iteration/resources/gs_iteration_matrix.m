%% Solve Poisson's equation $-\nabla^2 \phi(x, y) = f$ in the unit square 
% with homogenous boundary condition by Gauss-Seidel iteration.
% Parameters:
%   n: grid size (n*n blocks in total).
%   F: (n-1)*(n-1) matrix -- right hand side of the equation.
%   w: the parameter of relaxion where 0 <= w <= 1.
%   Phi0: initial value of solution matrix Phi, with size (n-1, n-1).
%   eps: iteration will terminate if ||u^{i+1}-u^i|| < eps.
% Returns:
%   Phi: solution matrix.
function [Phi, iter] = gs_iteration_matrix(n, F, w, Phi0, eps)
    %% Deal with input parameters.
    
    %% Pre.
    d = 1/n; % Delta: size length of each small square.
    Phi = Phi0;
    iter = 0;

    nodes = (n-1)^2;
    A = sparse(compute_A(n));
    L = -tril(A, -1);
    U = -triu(A, 1);
    D = A + L + U;
    f = reshape(F, [nodes, 1]); % vector
    fstar = (D-L)\f;
    
    %% Iterate.
    while true
        iter = iter + 1;
        PhiPrev = Phi;
        
        % Compute U*Phi.
        PhiU = w*([Phi(2:end, :); zeros(1, n-1)] ...
            + [Phi(:, 2:end), zeros(n-1, 1)])/d^2;
        
        % Transform to vectors.
        phi = reshape(Phi, [nodes, 1]);
        phiu = reshape(PhiU, [nodes, 1]);
        
        % Phi+ = w*inv(D-L)*U*Phi+(1-w)*Phi + (D-L)\F,
        %   where Phi and F are in their vector form
        phi = (D-L)\phiu + (1-w)*phi + w*fstar;
        
        % Transform to matrixs.
        Phi = reshape(phi, [n-1, n-1]);
        
        if norm(Phi - PhiPrev, 'fro') < eps
            break;
        end
        
        if iter >= 1e4
            warning('Algorithm has not converged in 1e4 iterations.');
            break;
        end
    end
end

%% Compute the sparse coefficients matrix. 
function A = compute_A(n)
    d = 1/n; nodes = (n-1)^2;
    A = zeros(nodes, nodes);
    A = A + ...
        + diag(ones(1, nodes))*4/d^2 ...
        - diag(ones(1, nodes - 1), 1)/d^2 ...
        - diag(ones(1, nodes - 1), -1)/d^2 ...
        - diag(ones(1, nodes - n + 1), n - 1)/d^2 ...
        - diag(ones(1, nodes - n + 1), -n + 1)/d^2;
    for i = 1 : n - 2
        A(i*(n-1), i*(n-1)+1)=0;
        A(i*(n-1)+1, i*(n-1))=0;
    end
    A = sparse(A);
end
