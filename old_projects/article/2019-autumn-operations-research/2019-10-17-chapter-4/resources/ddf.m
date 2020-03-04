function y = ddf(x)
    x1 = x(1); x2 = x(2);
    y = [120*x1^2 - 40*x2 + 2, -40*x1; -40*x1, 20];
end
