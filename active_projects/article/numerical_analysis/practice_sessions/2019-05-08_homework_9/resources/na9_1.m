h = @(x, y) 1./(1 + x.^2+  y.^2);
for n = [100 1000 10000]
    x = randn(1, n); y = randn(1, n);
    disp(mean(h(x, y)));
end
