%% Iteration Method of Trust Region Subproblem
function [d, lambda, iter] = trs_iteration(g, B, delta, lambda0, eps)
    % Initialization
    lambda0 = max(max(sum(B, 2)-2*diag(B)) + 1, lambda0);
    iter = 0; lambda = lambda0; lambdaprev = lambda - 1000*eps;
    dim = length(B); I = eye(dim);
    
    while abs(lambda - lambdaprev) > eps
        L = chol(B+lambda*I);
        d = L\(L'\(-g)); phi1 = norm(d);
        phi2 = norm(L\d);
        lambdaprev = lambda;
        lambda = lambda + (phi1/phi2)^2*(phi1 - delta)/delta;
        % SLIGHT ENHANCEMENT
        if lambda < 0
            lambda = 0; L = chol(B); d = L\(L'\(-g));
            break;
        end
    end
end
