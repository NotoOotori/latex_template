f = @(x) (sin(2*pi*x));
Bs = cell(1, 98); Ns = 1 : 100; Es = zeros(1, 100);
ps = linspace(-1, 1, 101);
for n = Ns
    if n <= 2
        continue;
    end
    Bs{n} = matlabFunction(bernstein(f, n, t));
    B = Bs{n};
    Es(n) = max(abs(f(ps) - B(ps)));
end
plot(Ns, Es);
