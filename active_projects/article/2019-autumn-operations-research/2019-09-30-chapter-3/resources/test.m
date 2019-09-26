clear; close all;

x0 = [1.2, 1.2]'; a0 = 1; r = 0.9; c = 0.5; eps = 1e-3;
fileeasy = fopen('sd_easy.log', 'w');
steepest_descent(@f, @df, x0, a0, r, c, eps, fileeasy);
x0 = [-1.2, 1]'; a0 = 1; r = 0.9; c = 0.5; eps = 1e-3;
filehard = fopen('sd_hard.log', 'w');
steepest_descent(@f, @df, x0, a0, r, c, eps, filehard);

clear; close all;

x0 = [1.2, 1.2]'; a0 = 1; r = 0.9; c = 0.5; eps = 1e-3;
fileeasy = fopen('nt_easy.log', 'w');
newton(@f, @df, @ddf, x0, a0, r, c, eps, fileeasy);
x0 = [-1.2, 1]'; a0 = 1; r = 0.9; c = 0.5; eps = 1e-3;
filehard = fopen('nt_hard.log', 'w');
newton(@f, @df, @ddf, x0, a0, r, c, eps, filehard);

clear; close all;

x0 = [1.2, 1.2]'; B0 = eye(2); a0 = 1; r = 0.9;
c1 = 1e-4; c2 = 0.9; eps = 1e-8;
fileeasy = fopen('bfgs_easy.log', 'w');
bfgs_quasi_newton(@f, @df, x0, B0, a0, r, c1, c2, eps, fileeasy);
x0 = [-1.2, 1]'; B0 = eye(2); a0 = 1; r = 0.9;
c1 = 1e-4; c2 = 0.9; eps = 1e-3;
filehard = fopen('bfgs_hard.log', 'w');
bfgs_quasi_newton(@f, @df, x0, B0, a0, r, c1, c2, eps, filehard);
