%% Solve Poisson's equation $-\nabla^2 \phi(x, y) = f$ in the unit square 
% with homogenous boundary condition by Gauss-Seidel iteration.
% Parameters:
%   n: grid size (n*n blocks in total).
%   F: (n-1)*(n-1) matrix -- right hand side of the equation.
%   w: the parameter of relaxion where 0 <= w <= 1.
%   Phi0: initial value of solution matrix Phi, with size (n-1, n-1).
%   error: iteration will terminate if ||u^{i+1}-u^i|| < error.
% Returns:
%   Phi: solution matrix.
function [Phi, iter] = gs_iteration(n, F, w, Phi0, error)
    %% Deal with input parameters.
    
    %% Pre.
    d = 1/n; % Delta: size length of each small square.
    Phi = Phi0;
    iter = 0;
    
    %% Iterate.
    while true
        iter = iter + 1;
        PhiPrev = Phi;
        Phi = edge_zeros(Phi);
        for i = 2 : n
            for j = 2 : n
                Phi(i, j) = (Phi(i+1, j) + Phi(i-1, j) ...
                    + Phi(i, j-1) + Phi(i, j+1))/4 ...
                    + d^2/4*F(i-1, j-1);
            end
        end
        Phi = Phi(2:end-1, 2:end-1);
        Phi = w*Phi + (1-w)*PhiPrev;
        if norm(Phi - PhiPrev, 'fro') < error
            break;
        end
        
        if iter >= 1e4
            warning('Algorithm has not converged in 1e4 iterations.');
            break;
        end
    end
end

%% Add zeros to the boundary of the matrix A.
function B = edge_zeros(A)
    [m, n] = size(A);
    B = [zeros(1, n + 2); zeros(m, 1), A, zeros(m, 1); zeros(1, n + 2)];
end
