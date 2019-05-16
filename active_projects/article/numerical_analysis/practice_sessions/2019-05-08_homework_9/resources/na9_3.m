N = 10000; count = 0;
for n = 1 : N
    point = rand(1, 3) * 2 - [1 1 0];
    if is_inside(point)
        count = count + 1;
    end
end
disp(count / N);

function boolean = is_inside(point)
    f = @(x, y, z) z.^2 - x.^2 - y.^2;
    g = @(x, y, z) 1 - x.^2 - y.^2 - (z - 1).^2;
    boolean = 0;
    x = point(1); y = point(2); z = point(3);
    if z > 2 || z < 0
        return;
    elseif z >= 1
        if f(x, y, z) >= 0
            boolean = 1;
        end
    else
        if g(x, y, z) >= 0
            boolean = 1;
        end
    end
end
