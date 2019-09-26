function y = df(x)
    x1 = x(1); x2 = x(2);
    y = [400*x1^3 + 2*x1 - 400*x1*x2 - 2; -200*x1^2 + 200*x2];
end
