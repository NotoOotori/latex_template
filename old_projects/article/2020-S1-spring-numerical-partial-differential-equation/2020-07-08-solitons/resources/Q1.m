% Script for question 1.
syms t x x0 real;
syms v positive;
u = -v./(2*cosh(sqrt(v).*(x-v.*t-x0)/2).^2);
dudt = diff(u, t);
dudx = diff(u, x);
d3udx3 = diff(u, x, 3);
if simplify(dudt - 6*u*dudx + d3udx3) == 0
    fprintf('The one-soliton solution solves the KdV equation!\n')
end
