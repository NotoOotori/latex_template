function [x,u]=example22A(n)
h=1/n;
x=0:h:1;

H=zeros(n+1,n+1);
for i=2:n
    H(i,i)=2/h+pi^2*h;    
end
for i=2:n
    H(i,i+1)=-1/h;    
    H(i+1,i)=-1/h;    
end
H(1,1) = 1;
H(n+1,n+1) = 1/h+1+0.5*h*pi^2;


g=(2*pi^2*sin(pi*x(2:n)))'*h;
g= [ 0;g;-pi];
% disp(H);
% disp(g);

u=H\g;
% disp(y');
% disp(sin(pi*x));
u = u';