%% Script for question 3 (and question 5).
clear;
n = 24;
blocks = [1 7 14 16];
F = get_F(n, blocks);

% Jacobi
fprintf('Jacobi: ');
tic
for i = 1 : 100
    [Phi, iter] = jacobi_iteration(n, F, 1, zeros(n-1, n-1), 1e-6);
end
toc

% GS-1.75
fprintf('GS-1.75: ');
tic
for i = 1 : 100
    [Phi, iter] = gs_iteration(n, F, 1.75, zeros(n-1, n-1), 1e-6);
end
toc

% VCycle-0.5-2-121
fprintf('VCycle-0.5-2-121: ');
tic
for i = 1 : 100
    [Phi, iter] = v_cycle(n, F, 0.5, zeros(n-1, n-1), [1 2 1], 2, 1e-6);
end
toc

% VCycle-0.8-2-121
fprintf('VCycle-0.5-2-121: ');
tic
for i = 1 : 100
    [Phi, iter] = v_cycle(n, F, 0.8, zeros(n-1, n-1), [1 2 1], 2, 1e-6);
end
toc

% VCycle-0.5-2-242
fprintf('VCycle-0.5-2-242: ');
tic
for i = 1 : 100
    [Phi, iter] = v_cycle(n, F, 0.5, zeros(n-1, n-1), [2 4 2], 2, 1e-6);
end
toc

% VCycle-0.8-2-242
fprintf('VCycle-0.8-2-242: ');
tic
for i = 1 : 100
    [Phi, iter] = v_cycle(n, F, 0.8, zeros(n-1, n-1), [2 4 2], 2, 1e-6);
end
toc

% VCycle-0.8-4-121
fprintf('VCycle-0.8-4-121: ');
tic
for i = 1 : 100
    [Phi, iter] = v_cycle(n, F, 0.5, zeros(n-1, n-1), [1 2 1], 4, 1e-6);
end
toc

% VCycle-0.8-4-111
fprintf('VCycle-0.8-4-111: ');
tic
for i = 1 : 100
    [Phi, iter] = v_cycle(n, F, 0.8, zeros(n-1, n-1), [1 1 1], 4, 1e-6);
end
toc
