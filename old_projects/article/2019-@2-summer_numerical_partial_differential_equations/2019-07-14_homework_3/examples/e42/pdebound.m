function [qmatrix,gmatrix,hmatrix,rmatrix] = pdebound(p,e,u,time)
% Dirichlet boundary condition: h u = r;
% Robin boundary condition: n\cdot (c \nabla u) + qu = g;


ne = size(e,2); % number of edges
qmatrix = zeros(1,ne);
gmatrix = qmatrix;
hmatrix = zeros(1,2*ne);
rmatrix = hmatrix;

for k = 1:ne
    x1 = p(1,e(1,k)); % x at first point in segment
    x2 = p(1,e(2,k)); % x at second point in segment
    xm = (x1 + x2)/2; % x at segment midpoint
    y1 = p(2,e(1,k)); % y at first point in segment
    y2 = p(2,e(2,k)); % y at second point in segment
    ym = (y1 + y2)/2; % y at segment midpoint
    
    if (abs(xm-1) <= eps)
        qmatrix(k) = 0;
        gmatrix(k) = pi*cos(pi*xm).*sin(pi*ym);
    else
        hmatrix(k) = 1;
        hmatrix(k+ne) = 1;
        rmatrix(k) = 0;
        rmatrix(k+ne) = 0;
    end
end