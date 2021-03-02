% Solve Poisson's equation $-\nabla^2 \phi(x, y) = f$ in the unit square 
% with homogenous boundary condition by Jacobi iteration.
% Parameters:
%   n: grid size (n*n blocks in total).
%   F: (n-1)*(n-1) matrix -- right hand side of the equation.
%   w: the parameter of relaxion where 0 <= w <= 1.
%   Phi0: initial value of solution matrix Phi, with size (n-1, n-1).
%   eps: iteration will terminate if ||u^{i+1}-u^i|| < error.
% Returns:
%   Phi: solution matrix.
function [Phi, iter] = jacobi_iteration_matrix(n, F, w, Phi0, eps)
    %% Deal with input parameters.
    
    %% Pre.
    d = 1/n; % Delta: size length of each small square.
    Phi = Phi0;
    iter = 0;
    
    %% Iterate.
    while true
        iter = iter + 1;
        PhiPrev = Phi;
        Phi = w*(([Phi(2:end, :); zeros(1, n-1)] ...
            + [zeros(1, n-1); Phi(1:end-1, :)] ...
            + [Phi(:, 2:end), zeros(n-1, 1)] ...
            + [zeros(n-1, 1), Phi(:, 1:end-1)])/4 ...
            + d^2/4*F) ...
            + (1-w)*Phi;
        if norm(Phi - PhiPrev, 'fro') < eps
            break;
        end
    end
end
