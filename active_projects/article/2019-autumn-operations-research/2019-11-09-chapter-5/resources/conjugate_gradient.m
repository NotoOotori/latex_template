%% Newton Method
% Make sure that every vector should be displayed in column!
% Parameters: A, b, x0, eps, fileID
function [x, iter] = conjugate_gradient(A, b, x0, eps, fileID)
    % Initialization
    iter = 0; x = x0;
    fprintf(fileID, 'iter alpha normr\n');
    
    % Termination
    while norm(A*x - b)>=eps
        % Descent direction
        if iter == 0
            r = A*x - b; d = -r;
        else
            rprev = r; r = A*x - b; beta = r'*r/(rprev'*rprev);
            d = -r + beta*d;
        end
        
        % Step length
        a = (-d'*r)/(d'*A*d);

        x = x + a*d;
        iter = iter + 1;
        fprintf(fileID, '%d %f %.5f\n', iter, a, norm(r));
    end
end
