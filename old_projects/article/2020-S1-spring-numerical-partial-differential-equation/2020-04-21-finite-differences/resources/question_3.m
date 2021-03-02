%% Script for Question 3.
clear; clc; close all;

N = 21; l = 3.0; b = 0.5; h = 1.0;
[AC, AD, BC, ~, Delta] = get_constants(N, l, b, h);
[U, A, f] = solve_problem(N, l, b, h);
plot_grid(N, l, b, h);
title('Grid')
plot_contour(U, N, l, b, h);
title('Contour lines')
Q = compute_flowrate(U, N, l, b, h);
fprintf('The flowrate is approximately %.6f.\n', Q);
