clear
close all
clc
tic;

%problem
t0=0;
T=0.5;
a=0;
b=1;

%parameter
h=0.05;
r=1;
dt=r*h^2;
x=a:h:b;
Nx=size(x,2);
t = t0:dt:T;
if( t(end)<T) 
    t = [t T];
end
Nt=size(t,2);

%initial condition
u0=sin(pi*x);
%boundary condition
ub(1,1:Nt)=sin(pi*a);
ub(2,1:Nt)=sin(pi*b);


% 用最简显格式求解
u_EM =example25(r,Nx,Nt,u0,ub);
disp(Nt);
toc;
%plot

for i=1:Nt
    plot(x,u_EM(:,i));
    axis([0,1,0,1]);
    title(['time = ',num2str(t(i))]);
    pause(0.1);
end
% [X,Y]=meshgrid(x,t);
% surf(X,Y,u_EM');
% xlabel('x');
% ylabel('t');
% shading interp;
% view(2);colorbar;



