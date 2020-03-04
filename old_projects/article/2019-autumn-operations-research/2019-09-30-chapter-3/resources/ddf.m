function y = ddf(x)
    x1 = x(1); x2 = x(2);
    y = [1200*x1^2 - 400*x2 + 2, -400*x1; -400*x1, 200];
end
