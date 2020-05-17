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
function [Phi, iter] = jacobi_iteration(n, F, w, Phi0, eps)
    %% Deal with input parameters.
    
    %% Pre.
    d = 1/n; % Delta: size length of each small square.
    Phi = Phi0;
    iter = 0;
    
    %% Iterate.
    while true
        iter = iter + 1;
        PhiPrev = Phi;
        Phi = single_jacobi_iteration(Phi, F, n, d, w);
        if norm(Phi - PhiPrev, 'fro') < eps
            break;
        end
    end
end
