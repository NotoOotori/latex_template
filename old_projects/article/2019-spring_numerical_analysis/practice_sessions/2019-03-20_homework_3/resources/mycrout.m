function x = mycrout(A, b)
    format long;
    % LU分解
    dim = size(A); dim=dim(1);
    for col = 1 : dim
        % L
        A(col:end, col) = A(col:end, col)-...
            A(col:end, 1:(col-1))*A(1:(col-1), col);
        % U
        row = col;
        A(row, (row+1):end) = (A(row, (row+1):end)-...
            A(row, 1:(row-1))*A(1:(row-1), (row+1):end))./A(row, row);
    end
    % L = tril(B);
    % U = triu(B)-diag(diag(B)-1);
    
    % 求解Ly=b
    y=zeros(dim, 1);
    for row = 1:dim
        y(row) = (b(row) - A(row, 1:(row-1))*y(1:(row-1)))./A(row, row);
    end
    
    % 求解Ux=y
    x=zeros(dim, 1);
    for row = dim:-1:1
        x(row) = y(row) - A(row, (row+1):end)*x((row+1):end);
    end
    
end
