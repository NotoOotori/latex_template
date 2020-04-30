%% Compute the flowrate using nested trapezoid integral formula.
function Q = compute_flowrate(U, N, l, b, h)
    [~, AD, BC, ~, Delta] = get_constants(N, l, b, h);
    
    yy = @(xi, eta) eta*(BC*xi + AD*(1 - xi));
    
    A = Delta*ones(N, N);
    A(1, :) = Delta/2; A(N, :) = Delta/2;
    
    B = yy((0:N-1)'*Delta, 1)*ones(1, N).*A';
    
    temp = A.*B.*U;
    Q = sum(temp(:));
end
