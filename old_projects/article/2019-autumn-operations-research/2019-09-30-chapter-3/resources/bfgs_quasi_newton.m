%% Quasi Newton Method With BFGS Formula
% Make sure that every vector should be displayed in column!
% Parameters: f, df, x0, B0, a0, r, c1, c2, eps, fileID
function [x, iter] = bfgs_quasi_newton(...
    f, df, x0, B0, a0, r, c1, c2, eps, fileID)
    % Initialization
    iter = 0; x = x0; xprev = x; dfx = df(x); dfxprev = dfx; B = B0;
    fprintf(fileID, 'iter alpha f normdf\n');
    
    % Termination
    while norm(dfx)>=eps
        iter = iter + 1;
        
        % Descent direction
        s = x - xprev; y = dfx - dfxprev;
        if iter == 2
            B = y'*s/(y'*y)*B;
        end
        if iter ~= 1
            B = B - B*(s*s')*B/(s'*B*s) + y*y'/(y'*s);
        end
        d = -B\dfx;
        
        % Step length
        a = a0; xtest = x + a*d;
        while f(xtest) > f(x) + c1*a*(df(x)'*d) || abs(df(xtest)'*d) > c2*abs(dfx'*d)
            a = r*a;
            xtest = x + a*d;
        end
        xprev = x; dfxprev = dfx; x = x + a*d; dfx = df(x);
        fprintf(fileID, '%d %f %.8f %.5f\n', iter, a, f(x), norm(df(x)));
    end
end
