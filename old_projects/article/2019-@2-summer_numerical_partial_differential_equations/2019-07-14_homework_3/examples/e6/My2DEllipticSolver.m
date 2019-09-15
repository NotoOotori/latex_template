function [U,p,e,t] = My2DEllipticSolver(geom)
[p,e,t] = initmesh(geom,'hmax',0.1);
x = p(1,:)';
y = p(2,:)';

func = @(x,y) ones(size(x));
c =  pdeintrp(p,t,func(x,y));
funa = @(x,y) zeros(size(x));
a =  pdeintrp(p,t,funa(x,y));
funf = @(x,y,u) u.^2+x;


flag = false;
U0 = zeros(size(x));
f = pdeintrp(p,t,funf(x,y,U0));
while (~flag)
    U = assempde(@pdebound,p,e,t,c,a,f);
    error = norm(U-U0,'inf')/norm(U,'inf');
    if(error < 1e-6)
        flag = true;
    else
        U0 = U;
        f = pdeintrp(p,t,funf(x,y,U0));
    end
end

