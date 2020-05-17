%% Compute normal flux with given solution.
function [G, err] = compute_flux(Phi, n, G0)
    d = 1/n;
    G = zeros(n - 1, 4);
    G(:, 1) = Phi(:, 1)*2/d - Phi(:, 2)/(2*d);
    G(:, 2) = Phi(:, end)*2/d - Phi(:, end-1)/(2*d);
    G(:, 3) = Phi(1, :)*2/d - Phi(2, :)/(2*d);
    G(:, 4) = Phi(end, :)*2/d - Phi(end-1, :)/(2*d);
    err = norm(G - G0, 'fro');
end
