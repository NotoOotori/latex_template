%% Script for Question 5.
clear; clc; close all;

% Deal with constants.
N = 21; l = 3; bs = 0.0: 0.1: 1.0; hs = 0.1: 0.1: 1.0; t = 0.05;
bcount = length(bs); hcount = length(hs);
[B, H] = meshgrid(bs, hs);
B = B'; H = H';
D = (l - B)/2;
Y = H.*D./(2*D + B);
I = Y.*2.*B*t + 2*D*t.*(H.^2 - 3*H.*Y + 3*Y.^2)/3;

% Compute Q for each point.
Q = zeros(bcount, hcount);
for i = 1 : bcount
    for j = 1 : hcount
        b = bs(i); h = hs(j);
        U = solve_problem(N, l, b, h);
        Q(i, j) = compute_flowrate(U, N, l, b, h);
    end
end

figure(); hold on; axis('square');
k = convhull(I(:), Q(:));
plot(I(:), Q(:), '.k', I(k), Q(k), '-k');
xlabel('$I$', 'interpreter', 'latex');
ylabel('$Q$', 'interpreter', 'latex');
title('The Pareto optimal frontier for $I$ and $Q$', 'interpreter', 'latex');
