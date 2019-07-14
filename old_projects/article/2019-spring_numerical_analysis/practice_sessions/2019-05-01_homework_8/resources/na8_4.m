year = 1900 : 10 : 1990; N = length(year);
population = [76.0 92.0 106.5 123.2 131.7 150.7 179.3 204.0 226.5 251.4];
derivation2 = zeros(1, N - 1);
derivation3 = zeros(1, N - 2);
for i = 1 : N - 1
    derivation2(i) = (population(i + 1) - population(i)) ...
        / (year(i + 1) - year(i));
end

for i = 1 : N - 2
    derivation3(i) = (population(i + 2) - population(i)) ...
        / (year(i + 2) - year(i));
end

disp(mean(derivation2));
disp(mean(derivation3));
