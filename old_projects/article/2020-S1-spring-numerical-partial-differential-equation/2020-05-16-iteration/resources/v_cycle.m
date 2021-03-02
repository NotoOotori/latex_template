%% Solve Poisson's equation $-\nabla^2 \phi(x, y) = f$ in the unit square 
% with homogenous boundary condition by Gauss-Seidel iteration.
% Parameters:
%   n: grid size (n*n blocks in total).
%   F: (n-1)*(n-1) matrix -- right hand side of the equation.
%   w: the parameter of relaxion where 0 <= w <= 1.
%   Phi0: initial value of solution matrix Phi, with size (n-1, n-1).
%   routine: 3*1 vector -- routine for the multigrid (fine, coarse, fine).
%   error: iteration will terminate if ||u^{i+1}-u^i|| < error.
% Returns:
%   Phi: solution matrix.
function [Phi, iter] = v_cycle(n, F, w, Phi0, routine, layer_max, error)
    %% Deal with input parameters.
    
    %% Pre.
    Phi = Phi0;
    iter = 0;
    
    %% Iterate.
    while true
        iter = iter + 1;
        PhiPrev = Phi;
        Phi = single_v_cycle(F, PhiPrev, w, routine, n, 1, layer_max);
        if norm(Phi - PhiPrev, 'fro') < error
            break;
        end
    end
end

%% Recursive function for solving Ax = y with initial guess on n*n grid.
function X = single_v_cycle(Y, X0, w, routine, n, layer, layer_max)
    %% Pre
    d = 1/n;
    X = X0;
    
    %% Relax using under-relaxed Jacobi method.
    for k = 1 : routine(1)
        X = single_jacobi_iteration(X, Y, n, d, w);
    end
    
    %% Correct on a coarser grid.
    if layer < layer_max
        for k = 1 : routine(2)
            %% Restrict.
            n_coarse = n/2;
            if abs(n_coarse - round(n_coarse)) > 1e-6
                error(['n = ', num2str(n), 'should be an even integer.']);
            end
            R = zeros(n - 1, n - 1);
            XEdge = edge_zeros(X);
            for i = 1 : n - 1
                for j = 1 : n - 1
                    R(i, j) = Y(i, j) - 1/d^2*( ...
                        4*XEdge(i+1, j+1) ...
                        - XEdge(i, j+1) - XEdge(i+1, j) ...
                        - XEdge(i+2, j+1) - XEdge(i+1, j+2));
                end
            end
            RCoarse = zeros(n_coarse - 1, n_coarse - 1);
            for u = 1 : n_coarse - 1
                for v = 1 : n_coarse - 1
                    i = 2*u; j = 2*v;
                    RCoarse(u, v) = (R(i-1, j-1) + R(i-1, j+1) ...
                        + R(i+1, j-1) + R(i+1, j+1) + 2*(R(i, j-1) ...
                        + R(i, j+1) + R(i-1, j) + R(i+1, j)) ...
                        + 4*R(i, j))/16;
                end
            end

            %% Solve on a coarser grid.
            ECoarse0 = zeros(n_coarse - 1, n_coarse - 1);
            ECoarse = single_v_cycle(RCoarse, ECoarse0, w, ...
                routine, n_coarse, layer + 1, layer_max);

            %% Prolongate and Correct.
            E = zeros(n - 1, n - 1);
            ECoarseEdge = edge_zeros(ECoarse);
            for i = 1 : n - 1
                for j = 1 : n - 1
                    u = floor(i/2) + 1; v = floor(j/2) + 1;
                    if mod(i, 2) == 0 && mod(j, 2) == 0
                        E(i, j) = ECoarseEdge(u, v);
                    elseif mod(i, 2) == 0 && mod(j, 2) == 1
                        E(i, j) = (ECoarseEdge(u, v) ...
                            + ECoarseEdge(u, v+1))/2;
                    elseif mod(i, 2) == 1 && mod(j, 2) == 0
                        E(i, j) = (ECoarseEdge(u, v) ...
                            + ECoarseEdge(u+1, v))/2;
                    else
                        E(i, j) = (ECoarseEdge(u, v) ...
                            + ECoarseEdge(u+1, v) ...
                            + ECoarseEdge(u, v+1) ...
                            + ECoarseEdge(u+1, v+1))/4;
                    end
                end
            end
            X = X + E;
        end
    end
    
    %% Relax using under-relaxed Jacobi method.
    for k = 1 : routine(3)
        X = single_jacobi_iteration(X, Y, n, d, w);
    end
end
