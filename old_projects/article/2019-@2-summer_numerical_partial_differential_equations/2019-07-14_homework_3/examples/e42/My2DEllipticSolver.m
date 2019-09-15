function [U,p,e,t] = My2DEllipticSolver(geom)
[p,e,t] = initmesh(geom,'hmax',0.1);
x = p(1,:)';
y = p(2,:)';

func = @(x,y) ones(size(x));
c =  pdeintrp(p,t,func(x,y));
funa = @(x,y) zeros(size(x));
a =  pdeintrp(p,t,funa(x,y));
funf = @(x,y) 2*pi^2*sin(pi*x).*sin(pi*y);
f = pdeintrp(p,t,funf(x,y));



U = assempde(@pdebound,p,e,t,c,a,f);

