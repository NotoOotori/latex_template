%% Script for Question 4.
clear; clc; close all;

N = 41; l = 3.0; h = 1.0;
for b = [0.0, 0.5, 1.0]
    [AC, AD, BC, ~, Delta] = get_constants(N, l, b, h);
    [U, A, f] = solve_problem(N, l, b, h);
    plot_contour(U, N, l, b, h);
    Q = compute_flowrate(U, N, l, b, h);
    fprintf('The flowrate is approximately %.6f for b = %.1f.\n', Q, b);
end
