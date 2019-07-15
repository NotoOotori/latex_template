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
h=0.1;
x=a:h:b;
y=a:h:b;
Nx=size(x,2);
Ny=size(y,2);
r=0.6;
dt=r*h^2;
t = t0:dt:T;
if( t(end)<T)
    t = [t T];
end
Nt=size(t,2);
NN=Nx*Ny;

%generate grid
[X,Y]=meshgrid(x,y);
xx=reshape(X,NN,1);
yy=reshape(Y,NN,1);



%initial condition
u0=sin(pi*xx).*sin(pi*yy);
%boundary condition
%deal with boundary condition
boundary=zeros(NN,1);
for ix=1:Nx
    iy=1;
    i=(iy-1)*Ny+ix;
    boundary(i)=1;
end
for ix=1:Nx
    iy=Ny;
    i=(iy-1)*Ny+ix;
    boundary(i)=1;
end
for iy=1:Ny
    ix=1;
    i=(iy-1)*Ny+ix;
    boundary(i)=1;
end
for iy=1:Ny
    ix=Nx;
    i=(iy-1)*Ny+ix;
    boundary(i)=1;
end
ub=repmat(sin(pi*xx(boundary==1)).*sin(pi*yy(boundary==1)),1,Nt);


% 用隐格式求解
u_EM =example28(t,h,Nx,Ny,Nt,u0,boundary,ub);
disp(Nt);
toc;
%plot
for n=1:Nt
    U=reshape(u_EM(:,n),Nx,Ny);
    surf(X,Y,U);
    axis([0,1,0,1,0,1,0,1]);
    title(['Time = ',num2str(t(n))]);
    shading interp;
    disp([t(n),norm(U,'inf')]);
    pause(0.1);
end



