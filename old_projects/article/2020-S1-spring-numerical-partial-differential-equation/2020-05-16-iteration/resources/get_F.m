% Get the matrix of f with specified distribution of source blocks.
function F = get_F(n, blocks)
    %% Deal with input parameters.
    m = n/6;
    
    %% Construct the matrix
    F = zeros(n - 1, n - 1);
    for k = 1 : 4
        b = blocks(k); % block id.
        j = floor((b - 1)/4) + 1;
        i = mod(b - 1, 4) + 1;
        for u = m*i : m*i + m
            for v = m*j : m*j + m
                F(u, v) = 1;
            end
        end
    end
end
