function val = horner_method(P, x)
    power = length(P) - 1;
    val = P(1);
    for j = 1 : power
        val = val * x + P(j+1);
    end
end
