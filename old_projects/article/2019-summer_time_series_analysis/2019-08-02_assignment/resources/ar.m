clear; close all; format long;

RANK = 3; NUM = 300; COEF = [1/2; -1/3; -1/4];

[ys, yprev] = generate(COEF, NUM);
save_with_index(ys, 'ys');
save_with_index(yprev, 'yprev');

ymean = mean(ys(RANK:end));
save_with_index(ymean, 'ymean');

ygammas = calculate_autocovariances(ys, ymean, NUM);
save_with_index(ygammas, 'ygammas');

yrhos = calculate_autocorrelations(ys, ygammas, ymean, NUM);
save_with_index(yrhos, 'yrhos');

yalphas = calculate_partial_autocorrelations(yrhos);
save_with_index(yalphas, 'yalphas');

residual_variances = zeros(4, 1); ecoef = cell(4, 1);
for p = 1 : 4
    yprevtemp = [zeros(p, 1); yprev]; yprevtemp = yprevtemp(end+1-p:end);
    ecoef{p} = estimate_coef(ys, yprevtemp, p, NUM);
    residual_variances(p) = calculate_residual_variance(ys, yprevtemp, ecoef{p}, p, NUM);
end
save_with_index(residual_variances, 'residual_variances');

Q0 = residual_variances(3)*(NUM - 3);
Q1 = residual_variances(2)*(NUM - 2);
prob = fcdf(((Q1 - Q0)/2)/(Q0/(NUM - 3)), 2, NUM - 3);
save_with_index(prob, 'prob');

yforcasts = forcast(ys, ecoef{3}, 3, RANK, NUM);
save_with_index(yforcasts, 'yforcasts');

function save_with_index(cvector, name)
    cvectortemp = [(1:length(cvector))' cvector];
    save(['ar_' name '.txt'], 'cvectortemp', '-ascii');
end

function [ys, yprev] = generate(COEF, NUM)
    RANK = length(COEF);
    yprev = normrnd(0, 1, RANK, 1); % y_{-2}, y_{-1}, y_{0}.
    es = normrnd(0, 0.01, NUM, 1);
    ys = [yprev; zeros(NUM, 1)];
    for j = 1 : NUM
        ys(RANK + j) = COEF' * ys(RANK + j - 1 : -1 : j) + es(j);
    end
    ys = ys(RANK+1:end);
end

function ys = generate_with_yprev(yprev, COEF, RANK, NUM)
    ys = [yprev; zeros(NUM, 1)];
    for j = 1 : NUM
        ys(RANK + j) = COEF' * ys(RANK + j - 1 : -1 : j);
    end
    ys = ys(RANK+1:end);
end

function ygammap = calculate_autoconvariance(ys, ymean, p, NUM)
    ygammap = (ys(1 : NUM-p) - ymean)'*(ys(1+p : NUM))/(NUM-p);
end

function ygammas = calculate_autocovariances(ys, ymean, NUM)
    LEN = NUM - 1; ygammas = zeros(LEN, 1);
    for p = 1 : LEN
        ygammas(p) = calculate_autoconvariance(ys, ymean, p, NUM);
    end
end

function yrhos = calculate_autocorrelations(ys, ygammas, ymean, NUM)
    ygamma0 = calculate_autoconvariance(ys, ymean, 0, NUM);
    yrhos = ygammas / ygamma0;
end

function yalphas = calculate_partial_autocorrelations(yrhos)
    LEN = length(yrhos); yalphametric = zeros(LEN, LEN);
    yalphametric(1, 1) = yrhos(1);
    for k = 2 : LEN
        yalphametric(k, k) = ...
            (yrhos(k)-yalphametric(k-1, 1:k-1)*yrhos(k-1:-1:1))/...
            (1-yalphametric(k-1, 1:k-1)*yrhos(1:k-1));
        for j = 1 : k - 1
            yalphametric(k, j) = yalphametric(k-1, j) - ...
                yalphametric(k, k)*yalphametric(k-1, k-j);
        end
    end
    yalphas = diag(yalphametric);    
end

function ecoef = estimate_coef(ys, yprev, RANK, NUM)
    ys = [yprev; ys];
    Y = ys(RANK+1:end);
    X = zeros(NUM, RANK);
    for j = RANK : -1 : 1
        X(:, RANK + 1 - j) = ys(j : j + NUM - 1);
    end
    ecoef = (X'*X)\(X'*Y);
end

function residual_variance = calculate_residual_variance(ys, yprev, ecoef, RANK, NUM)
    eys = generate_with_yprev(yprev, ecoef, RANK, NUM);
    residual_variance = sum((ys - eys).^2)/(NUM - RANK);
end

function yforcasts = forcast(ys, ecoef, p, RANK, NUM)
    yforcasts = generate_with_yprev(ys(NUM+1-RANK:NUM), ecoef, RANK, p);
end

