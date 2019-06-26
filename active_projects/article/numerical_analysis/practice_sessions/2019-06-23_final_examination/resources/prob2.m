e = 0; i = 0;
while 1
    delta = 1 / factorial(i);
    if delta < 1e-6
        break;
    end
    e = e + delta;
    i = i + 1;
end
fprintf('By our calculation e equals %.6f, ', e);
fprintf('while in MATLAB e equals %.6f.\n', exp(1));
