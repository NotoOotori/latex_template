function [x,u]=example20A(n)
% Problem:
% -u'' +\pi^2 u = f  in (0,1)
% u(0) = u(1) = 0
% f = 2\pi^2*\sin(pi*x)
% with exact solution u = \sin(\pi x)

h=1/n;
x=0:h:1;
g=(2*pi^2*sin(pi*x(2:n)))';
H=zeros(n-1,n-1);

for i=1:n-1
    H(i,i)=2/h^2+pi^2;    
end
for i=2:n-1
    H(i,i-1)=-1/h^2;    
    H(i-1,i)=-1/h^2;    
end

% disp(H);
% disp(g);



u=H\g;
% disp(y');
% disp(sin(pi*x));
u = [0 u' 0];