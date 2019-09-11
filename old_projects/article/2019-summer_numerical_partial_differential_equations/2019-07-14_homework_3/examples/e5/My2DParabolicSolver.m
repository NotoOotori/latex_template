function [U,p,e,t,tlist] = My2DParabolicSolver(geom)
[p,e,t] = initmesh(geom,'hmax',0.1);
x = p(1,:)';
y = p(2,:)';

func = @(x,y) ones(size(x));
c =  pdeintrp(p,t,func(x,y));
funa = @(x,y) zeros(size(x));
a =  pdeintrp(p,t,funa(x,y));
funf = @(x,y) 2*pi^2*sin(pi*x).*sin(pi*y);
f = pdeintrp(p,t,funf(x,y));
fund = @(x,y) ones(size(x));
d = pdeintrp(p,t,fund(x,y));

u0 = zeros(size(x));
tlist = 0:0.05:0.5;

U = parabolic(u0,tlist,@pdebound,p,e,t,c,a,f,d);

