clear; close all; format long;

ARRANK = 2; MARANK = 2; NUM = 300;
ARCOEF = [1/2; -1/3]; MACOEF = [1/3; -1/4];

[ys, yprev] = generate(ARCOEF, MACOEF, ARRANK, MARANK, NUM);
save_with_index(ys, 'ys');
save_with_index(yprev, 'yprev');

ymean = mean(ys);
save_with_index(ymean, 'ymean');

ygammas = calculate_autocovariances(ys, ymean, NUM);
save_with_index(ygammas, 'ygammas');

yrhos = calculate_autocorrelations(ys, ygammas, ymean, NUM);
save_with_index(yrhos, 'yrhos');

yalphas = calculate_partial_autocorrelations(yrhos);
save_with_index(yalphas, 'yalphas');

residual_variances = zeros(4, 4); ecoef = cell(4, 4, 2);
for p = 1 : 4
    for q = 1 : p
        yprevtemp = [zeros(p, 1); yprev];
        yprevtemp = yprevtemp(end+1-p:end);
        [ecoef{p, q, 1}, ecoef{p, q, 2}] = estimate_coef(ys, yprevtemp, p, q, NUM);
        residual_variances(p, q) = calculate_residual_variance(...
            ys, yprevtemp, ecoef{p, q, 1}, p, q, NUM);
    end
end
save_with_index(residual_variances, 'residual_variances');

Q0 = residual_variances(2, 2)*(NUM - 2 - 2);
Q1 = residual_variances(1, 1)*(NUM - 1 - 1);
prob = fcdf(((Q1 - Q0)/2)/(Q0/(NUM - 2)), 2, NUM - 2 - 2);
save_with_index(prob, 'prob');

yforcasts = forcast(ys, ecoef{2, 2, 1}, 3, ARRANK, NUM);
save_with_index(yforcasts, 'yforcasts');

function save_with_index(cvector, name)
    cvectortemp = [(1:length(cvector))' cvector];
    save(['arma_' name '.txt'], 'cvectortemp', '-ascii');
end

function [ys, yprev] = generate(ARCOEF, MACOEF, ARRANK, MARANK, NUM)
    yprev = normrnd(0, 1, ARRANK, 1); % y_{-1}, y_{0}.
    eprev = normrnd(0, 0.01, MARANK, 1);
    es = normrnd(0, 0.01, NUM, 1);
    ys = [yprev; zeros(NUM, 1)];
    es = [eprev; es];
    for j = 1 : NUM
        ys(ARRANK + j) = ARCOEF' * ys(ARRANK + j - 1 : -1 : j) + ...
            MACOEF' * es(MARANK + j - 1 : -1 : j);
    end
    ys = ys(ARRANK+1:end);
end

function ys = generate_with_yprev(yprev, ARCOEF, ARRANK, NUM)
    ys = [yprev; zeros(NUM, 1)];
    for j = 1 : NUM
        ys(ARRANK + j) = ARCOEF' * ys(ARRANK + j - 1 : -1 : j);
    end
    ys = ys(ARRANK+1:end);
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

function [earcoef, emacoef] = estimate_coef(ys, yprev, ARRANK, MARANK, NUM)
    % Estimate epsilons first.
    ys = [yprev; ys];
    Ytemp = ys(ARRANK+1:end);
    Xtemp = zeros(NUM, ARRANK);
    for j = ARRANK : -1 : 1
        Xtemp(:, ARRANK + 1 - j) = ys(j : j + NUM - 1);
    end
    ecoeftemp = Xtemp\Ytemp;
    ees = Ytemp - Xtemp*ecoeftemp; % Index from 1 to 300
    % Then estimate coefficients.
    Y = Ytemp(ARRANK+1:end);
    X = zeros(NUM-ARRANK, ARRANK+MARANK);
    for j = ARRANK : -1 : 1
        X(:, ARRANK + 1 - j) = ys(j + ARRANK : j + NUM - 1);
    end
    for j = MARANK : -1 : 1
        X(:, ARRANK + MARANK + 1 - j) = ees(j : j + NUM - ARRANK - 1);
    end
    ecoef = X\Y;
    earcoef = ecoef(1:ARRANK); emacoef = ecoef(end-MARANK+1:end);
end

function residual_variance = calculate_residual_variance(ys, yprev, earcoef, ARRANK, MARANK, NUM)
    eys = generate_with_yprev(yprev, earcoef, ARRANK, NUM);
    residual_variance = sum((ys - eys).^2)/(NUM - ARRANK - MARANK);
end

function yforcasts = forcast(ys, earcoef, p, ARRANK, NUM)
    yforcasts = generate_with_yprev(ys(NUM+1-ARRANK:NUM), earcoef, ARRANK, p);
end

