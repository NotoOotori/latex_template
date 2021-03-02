%% Script for Question 5.
clear; clc; close all;

l = 3.0; h = 1.0;
for b = 0.0: 0.5: 1.0
    Ns = [11 21 41 81]';
    Ncount = length(Ns);
    U = cell(Ncount, 1);
    Q = zeros(Ncount, 1);
    grids = cell(Ncount, 2);
    for index = 1 : Ncount
        N = Ns(index);
        U{index} = solve_problem(N, l, b, h);
        Q(index) = compute_flowrate(U{index}, N, l, b, h);
        
        xi = linspace(0, 1, N);
        eta = linspace(0, 1, N);
        [Xi, Eta] = meshgrid(xi, eta);
        Xi = Xi'; Eta = Eta'; % Important!
        grids{index, 1} = Xi;
        grids{index, 2} = Eta;
    end
    
    % Q.
    plot_linear_fitting(log(Ns(1: end - 1)), log(abs(Q(1: end - 1) - Q(end))));
    xlabel('$\log(N)$', 'interpreter', 'latex');
    ylabel('$\log(Q)$', 'interpreter', 'latex');
    title(['The error of the flowrate $Q$ for $b = ', num2str(b), '$.'], 'interpreter', 'latex');
    
    % norm.
    UU = cell(Ncount, 1);
    UU{4} = U{4};
    for index = 1 : Ncount - 1 % interpolant.
        F = griddedInterpolant(grids{index, 1}, grids{index, 2}, U{index});
        UU{index} = F(grids{end, 1}, grids{end, 2});
    end
    
    % L_inf norm.
    norm_inf = zeros(Ncount - 1, 1);
    for index = 1 : Ncount - 1
        norm_inf(index) = max(abs(UU{index}(:) - UU{4}(:)));
    end
    plot_linear_fitting(log(Ns(1: end - 1)), log(norm_inf));
    xlabel('$\log(N)$', 'interpreter', 'latex');
    ylabel('$\log(|\cdot|_\infty)$', 'interpreter', 'latex');
    title(['The $L_\infty$ norm of the error of the solution $U$, for $b = ', num2str(b), '$.'], 'interpreter', 'latex');
    
    % L_2 norm.
    norm_2 = zeros(Ncount - 1, 1);
    for index = 1 : Ncount - 1
        norm_2(index) = sqrt(compute_flowrate((UU{index} - UU{4}).^2, Ns(end), l, b, h));
    end
    plot_linear_fitting(log(Ns(1: end - 1)), log(norm_2));
    xlabel('$\log(N)$', 'interpreter', 'latex');
    ylabel('$\log(|\cdot|_2)$', 'interpreter', 'latex');
    title(['The $L_2$ norm of the error of the solution $U$, for $b = ', num2str(b), '$.'], 'interpreter', 'latex');
end


function plot_linear_fitting(X, Y) % X and Y should be column vectors.
    figure; hold on; axis('square');
    Xcount = length(X);
    parameters = [ones(Xcount, 1), X]\Y; % Parameters of the linear fitting curve.
    intercept = parameters(1); slope = parameters(2);
    plot(X, Y, 'ok', 'DisplayName', 'data points');
    plot(X, slope*X + intercept, '-k', 'DisplayName', ['$y = ', num2str(slope), ' x + ', num2str(intercept), '$']);
    legend('show', 'interpreter', 'latex');
end
