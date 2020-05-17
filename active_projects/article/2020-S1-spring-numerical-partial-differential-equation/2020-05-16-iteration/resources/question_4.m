% Script for question 4.
clear; close all;

n = 24;
Blocks = nchoosek(1:16, 4)';
G0 = load('flux_unknown.txt'); % Normal flux of unknown configuration.

count = size(Blocks, 2);
errs = zeros(count, 1);
tic
for i = 1 : count
    blocks = Blocks(:, i);
    F = get_F(n, blocks);
    [Phi, iter] = v_cycle(n, F, 0.8, zeros(n-1, n-1), [1 1 1], 4, 1e-6);
    [~, err] = compute_flux(Phi, n, G0);
    errs(i) = err;
end
toc

[err, index] = min(errs);
blocks = Blocks(:, index);

figure; hold on;
plot(errs, '.k');
plot(index, err, '.r', 'markersize', 24);
xlabel('Index of Configuration');
ylabel('Frobenius Norm of Error of Normal Flux');
text(index, err, ...
    ['(', num2str(index), ', ', num2str(err, '%.2e'), ')'], ...
    'horizontalalignment', 'center', 'verticalalignment', 'bottom', ...
    'fontsize', 12);
%%
plot_pictorial_explanation(blocks, G0);

function plot_pictorial_explanation(blocks, G)
    figure; hold on;
    axis('equal'); axis('off');
    
    c = linspace(0, 1, 7)'; [C1, C2] = meshgrid(c, c);
    plot(C1, C2, '-k', C1', C2', '-k');
    
    patch_square(0:4, zeros(1, 5), [.8, .8, .8]);
    patch_square(1:5, 5 + zeros(1, 5), [.8, .8, .8]);
    patch_square(zeros(1, 5), 1:5, [.8, .8, .8]);
    patch_square(5 + zeros(1, 5), 0:4, [.8, .8, .8]);
    
    blocks = blocks'; % Convert to row vector;
    patch_square(ceil(blocks/4), mod(blocks - 1, 4) + 1, [.4, .4, .4]);
    
    for block = 1 : 16
        text_block(block);
    end
    
    f = linspace(0, 1, 25)';
    G = [zeros(1, 4); G; zeros(1, 4)];
    plot(-G(:, 1), f, '-k');
    plot(1 + G(:, 2), f, '-k');
    plot(f, -G(:, 3), '-k');
    plot(f, 1 + G(:, 4), '-k');
    
    % scale = 0!
    quiver(zeros(7, 1), c, -G(1:4:25, 1), zeros(7, 1), ...
        0, 'k', 'linewidth', 2);
    quiver(ones(7, 1), c, G(1:4:25, 2), zeros(7, 1), ...
        0, 'k', 'linewidth', 2);
    quiver(c, zeros(7, 1), zeros(7, 1), -G(1:4:25, 3), ...
        0, 'k', 'linewidth', 2);
    quiver(c, ones(7, 1), zeros(7, 1), G(1:4:25, 4), ...
        0, 'k', 'linewidth', 2);
    
    % (mx, my): lower-left corner of the square
    function patch_square(mx, my, facecolor)
        patch([mx/6; (mx+1)/6; (mx+1)/6; mx/6], ...
            [my/6; my/6; (my+1)/6; (my+1)/6], 0, ...
            'facecolor', facecolor);
    end

    function [mx, my] = cdn(block)
        mx = ceil(block/4);
        my = mod(block - 1, 4) + 1;
    end

    function text_block(block)
        [mx, my] = cdn(block);
        text((2*mx + 1)/12, (2*my + 1)/12, num2str(block), ...
            'horizontalalignment', 'center', ...
            'fontsize', 18, 'fontweight', 'bold');
    end
end
