% Script for question 2.
clear; close all;

n = 24;
blocks = [1 7 14 16];
F = get_F(n, blocks);
G0 = load('flux_known.txt'); % sample.

%% Test the solvers.

% Jacobi
[Phi, iter] = jacobi_iteration(n, F, 1, zeros(n-1, n-1), 1e-6);
[~, err] = compute_flux(Phi, n, G0);
fprintf('Jacobi iteration: %d iterations in total; ', iter);
fprintf('Frobenius norm of error is %.4e.\n', err);

% G-S
[Phi, iter] = gs_iteration(n, F, 1, zeros(n-1, n-1), 1e-6);
[~, err] = compute_flux(Phi, n, G0);
fprintf('Gauss-Seidel iteration: %d iterations in total; ', iter);
fprintf('Frobenius norm of error is %.4e.\n', err);

%% Find the optimal relaxation factor for G-S iteration scheme.
ws = (0.05 : 0.05 : 1.95)';
iters = zeros(size(ws));
for i = 1 : length(ws)
    w = ws(i);
    [Phi, iter] = gs_iteration(n, F, w, zeros(n-1, n-1), 1e-6);
    iters(i) = iter;
    [~, err] = compute_flux(Phi, n, G0);
    fprintf('w: %.2f; iter: %d; error: %.2e.\n', w, iter, err);
end
[~, index] = min(iters);
fprintf('The optimal relaxation factor is %.2f.\n', ws(index));

figure; hold on;
index_normal = find(iters ~= 1e4);
index_abnormal = find(iters == 1e4);
plot(ws(index_normal), iters(index_normal), '.k', 'markersize', 24);
plot(ws(index_abnormal), iters(index_abnormal), '.r', 'markersize', 24);
xlabel('Relaxation factor $\omega$', 'interpreter', 'latex');
ylabel('Total number of iterations $r$', 'interpreter', 'latex');
