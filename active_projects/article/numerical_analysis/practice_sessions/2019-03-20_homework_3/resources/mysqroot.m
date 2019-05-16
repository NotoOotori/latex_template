function x = mysqroot(A, b)
    format long;
    dim = size(A); dim = dim(1);
    
    % G
    G = zeros(dim);
    for i = 1 : dim
        G(i, i) = sqrt(A(i, i)-G(i, 1:(i-1))*(G(i, 1:(i-1)))');
        G((i+1):dim, i) = (A((i+1):dim, i) ...
            - G((i+1):dim, 1:(i-1))*(G(i, 1:(i-1)))')/G(i, i);
    end
    
    % y, x
    y = zeros(dim, 1);
    x = zeros(dim, 1);
    for i = 1 : dim
        y(i) = (b(i)-G(i, 1:(i-1))*y(1:(i-1)))/G(i, i);
    end
    for i = dim : -1 : 1
        x(i) = (y(i) - (G((i+1):dim, i))'*x((i+1):dim))/G(i, i);
    end
end
