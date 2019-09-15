clear;
close all;

C = [-(7*exp((20-40*sqrt(2))/7)+10)/(exp((20+40*sqrt(2))/7)-exp((20-40*sqrt(2))/7)) ...
    (7*exp((20+40*sqrt(2))/7)+10)/(exp((20+40*sqrt(2))/7)-exp((20-40*sqrt(2))/7))];
sol = @(x) (C(1)*exp((1+2*sqrt(2))/7*x) + C(2)*exp((1-2*sqrt(2))/7*x)+x-2);

Ns = 10 : 5 : 30;
Ncount = length(Ns);
error = zeros(Ncount, 1);

figure(1); hold on; legend(); xlabel('x'); ylabel('y');
for i = 1 : Ncount
   [x, y] = fdm(Ns(i));
   error(i) = norm(y - sol(x), 'inf');
   plot(x, y, 'DisplayName', ['N = ',num2str(Ns(i))]);
end
plot(x, sol(x), 'DisplayName', 'True Solution');
hold off;

figure(2); hold on; legend(); xlabel('N'); ylabel('log(error)');
poly = polyfit(log(Ns'),log(error),1);
plot(log(Ns'), log(error), 'r-+', 'DisplayName', ...
    ['log(error) = ' num2str(poly(1)) 'N + ' num2str(poly(2))]);
hold off;

function [t, x] = fdm(N)
    t0 = 0; tN = 20; x0 = 5; xN = 8;
    h = (tN - t0)/N;
    t = linspace(t0, tN, N + 1);
    
    A = zeros(N + 1);
    A(1, 1) = 1; A(end, end) = 1;
    for i = 2 : N
        A(i, i) = -14*h^(-2) - 1;
        A(i, i - 1) = 7*h^(-2) + h^(-1);
        A(i, i + 1) = 7*h^(-2) - h^(-1);
    end
    
    b = -t; b(1) = x0; b(end) = xN;
    
    x = mychase(A, b);
end
