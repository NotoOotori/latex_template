%% Single iteration in Jacobi iteration method
% of Poisson's Equation in unit square.
function Phi = single_jacobi_iteration(Phi, F, n, d, w)
    Phi = edge_zeros(Phi);
    PhiPrev = Phi;
    for i = 2 : n
        for j = 2 : n
            Phi(i, j) = (PhiPrev(i+1, j) + PhiPrev(i-1, j) ...
                + PhiPrev(i, j-1) + PhiPrev(i, j+1))/4 ...
                + d^2/4*F(i-1, j-1);
        end
    end
    Phi = Phi(2:end-1, 2:end-1);
    PhiPrev = PhiPrev(2:end-1, 2:end-1);
    Phi = w*Phi + (1-w)*PhiPrev;
end
