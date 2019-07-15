clear;
close all;

Ns = 10 : 5 : 30;
Ncount = length(Ns);
error = zeros(Ncount, 1);

figure(1); hold on; legend(); xlabel('x'); ylabel('y');
for i = 1 : Ncount
   [x, y] = fdm(Ns(i));
   plot(x, y, 'DisplayName', ['N = ',num2str(Ns(i))]);
end
hold off;

function [t, x] = fdm(N)
    t0 = 0; tN = 10; x0 = 300; xN = 400;
    h = (tN - t0)/N;
    t = linspace(t0, tN, N + 1);
    
    alpha = 0.05; beta = 2.7e-9; Tinf = 200;
    
    A = zeros(N + 1);
    A(1, 1) = 1; A(end, end) = 1;
    for i = 2 : N
        A(i, i) = -2*h^(-2) - alpha - 4*beta*Tinf^3;
        A(i, i - 1) = h^(-2); A(i, i + 1) = h^(-2);
    end
    
    b = -(alpha + 4*beta*Tinf^4)*ones(N + 1, 1); b(1) = x0; b(end) = xN;
    
    x = mychase(A, b);
end
