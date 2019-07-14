function f = newton_interpolation(x, y)
    deg = length(x - 1);
    f = zeros(1, deg + 1);
    f(deg + 1) = y(1);
    for j = 1 : deg
        base = 1;
        for k = 1 : j - 1
            base = conv(base, [1, -x(k)]);
        end
        base = extend(base, deg);
        f = f + ((y(j) - polyval(f, x(j)))/polyval(base, x(j))) * base;
    end
end

function g = extend(f, deg)
    g = [zeros(1, deg - length(f) + 1) f];
end
