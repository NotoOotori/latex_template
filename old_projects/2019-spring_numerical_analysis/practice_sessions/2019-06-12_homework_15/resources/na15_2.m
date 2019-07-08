A = [5 2 2 1; 2 -3 1 1; 2 1 3 1; 1 1 1 2];
MAX_ITER = 100; eps = 1e-5;
B = eig_qr(A, MAX_ITER, eps);
disp(diag(B));
disp(eig(A));
