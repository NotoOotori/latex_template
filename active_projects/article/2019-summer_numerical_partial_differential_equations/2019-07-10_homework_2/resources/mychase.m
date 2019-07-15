function x = mychase(A, d)
    dim = size(A); dim = dim(1);
    a = [0; diag(A, -1)];
    b = diag(A);
    c = [diag(A, 1); 0];
    
    l = zeros(1, dim);
    u = zeros(1, dim);
    y = zeros(1, dim);
    x = zeros(1, dim);
    
    for i = 1 : dim - 1
        if i == 1
            l(i) = b(i) - 0;
            y(i) = d(i)/l(i);
            u(i) = c(i)/l(i);
            continue;
        end
        l(i) = b(i) - a(i)*u(i-1);
        y(i) = (d(i)-y(i-1)*a(i))/l(i);
        u(i) = c(i)/l(i);
    end
    
    l(dim) = b(dim) - a(dim)*u(dim-1);
    y(dim) = (d(dim)-y(dim-1)*a(dim))/l(dim);
    x(dim) = y(dim);
    
    for i = dim - 1 : -1 : 1
        x(i) = y(i) - u(i)*x(i+1);
    end
end