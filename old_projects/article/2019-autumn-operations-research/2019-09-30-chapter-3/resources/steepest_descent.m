%% Steepest Descent Method
% Make sure that every vector should be displayed in column!
% Parameters: f, df, x0, a0, r, c, eps, fileID
function [x, iter] = steepest_descent(f, df, x0, a0, r, c, eps, fileID)
    % Initialization
    iter = 0; x = x0;
    fprintf(fileID, 'iter alpha f normdf\n');
    
    % Termination
    while norm(df(x))>=eps
        iter = iter + 1;
        
        % Descent direction
        d = -df(x);
        
        % Step length
        a = a0; xtest = x + a*d;
        while f(xtest)>f(x) + c*a*(df(x)'*d)
            a = r*a; xtest = x + a*d;
        end
        x = x + a*d;
        fprintf(fileID, '%d %f %.8f %.5f\n', iter, a, f(x), norm(df(x)));
    end
end
