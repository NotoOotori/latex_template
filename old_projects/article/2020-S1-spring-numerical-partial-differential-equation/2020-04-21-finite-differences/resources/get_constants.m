%% Get some useful constants from the given grid size N and given parameters l, b, and h
function [AC, AD, BC, BD, Delta] = get_constants(N, l, b, h)
    AC = h;
    AD = b/2 + sqrt((l-b)^2/4-h^2);
    BC = b/2;
    BD = (l-b)/2;
    Delta = 1/(N - 1);
end
