clear;
close all;

C = [(150-240*exp(-sqrt(15)))/(exp(sqrt(15))-exp(-sqrt(15))), ...
    (240*exp(sqrt(15))-150)/(exp(sqrt(15))-exp(-sqrt(15)))];
sol = @(x) (C(1)*exp(sqrt(0.15)*x) + C(2)*exp(-sqrt(0.15)*x));

Ns = 10 : 5 : 30;
Ncount = length(Ns);
error = zeros(Ncount, 1);

figure(1); hold on; legend(); xlabel('x'); ylabel('T');
for i = 1 : Ncount
   [x, T] = fdm(Ns(i));
   error(i) = norm(T - sol(x), 'inf');
   plot(x, T, 'DisplayName', ['N = ',num2str(Ns(i))]);
end
plot(x, sol(x), 'DisplayName', 'True Solution');
hold off;

figure(2); hold on; legend(); xlabel('N'); ylabel('log(error)');
poly = polyfit(log(Ns'),log(error),1);
plot(log(Ns'), log(error), 'r-+', 'DisplayName', ...
    ['log(error) = ' num2str(poly(1)) 'N + ' num2str(poly(2))]);
hold off;

function [t, x] = fdm(N)
    t0 = 0; tN = 10; x0 = 240; xN = 150;
    h = (tN - t0)/N;
    t = linspace(t0, tN, N + 1);
    
    A = zeros(N + 1);
    A(1, 1) = 1; A(end, end) = 1;
    for i = 2 : N
        A(i, i) = -2*h^(-2) - 0.15;
        A(i, i - 1) = h^(-2); A(i, i + 1) = h^(-2);
    end
    
    b = zeros(N + 1, 1); b(1) = x0; b(end) = xN;
    
    x = mychase(A, b);
end
