%% Trust Region Method
% Parameters: f, df, ddf, x0, delta0, eps, fileID
function [x, iter] = trust_region(f, df, ddf, x0, delta0, eps, fileID)
    % Initialization
    iter = 0; x = x0; delta = delta0;
    fprintf(fileID, 'iter alpha f normdf\n');
    
    % Termination
    while norm(df(x))>=eps
        m = @(d) (f(x) + df(x)*d + d'*ddf(x)*d/2);
        % Descent direction (Trust region subproblem)
        
        
        % Trail point
        xtrail = x + d;
        rho = (f(x)-f(xtrail))/(m(0)-m(d));
        if rho >= 0.75
            delta = 2*delta;
        end
        if rho > 0
            x = x + d;
        end
        
        iter = iter + 1;
        fprintf(fileID, '%d %f %.8f %.5f\n', iter, a, f(x), norm(df(x)));
    end
end
