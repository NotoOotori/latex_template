a = 0; b = 1; eps = 1e-8;
f = @(x) (4./(1+x.^2));
g = @(y) (4./(1+((y+1)./2).^2))/2;
I0 = pi;
n1 = composite_simpson(f, a, b, I0, eps);
n2 = gauss_legendre(g, I0, eps);
disp(n1);
disp(n2);
