function [err,U,X,Y]=example24(Nx,Ny,flagdraw,sub)
%generate grid
x=linspace(0,1,Nx+1);
y=linspace(0,1,Ny+1);
hx=1/Nx;
hy=1/Ny;
[X,Y]=meshgrid(x,y);
NN=(Nx+1)*(Ny+1);
%generate coefficient matrix and right vector
tmp=[-1 -1 4 -1 -1];
A=sparse(NN,NN);
for ix=2:Nx
    for iy=2:Ny
        i=(iy-1)*(Ny+1)+ix;
        iu=i+Nx+1;
        id=i-Nx-1;
        il=i-1;
        ir=i+1;
        A(i,[il ir i iu id])=tmp;
    end
end
f=zeros(NN,1);
for ix=2:Nx
    for iy=2:Ny
        i=(iy-1)*(Ny+1)+ix;
        f(i)=2*pi*pi*sin(pi*x(ix))*sin(pi*y(iy))*hx*hy;
    end
end
%deal with boundary condition
% left
for iy=2:Ny
    ix=1;
    i=(iy-1)*(Ny+1)+ix;
    iu=i+Nx+1;
    id=i-Nx-1;
    ir=i+1;    
    A(i,i)=hx/2/hy+hy/hx+hx/2/hy+hy;
    A(i,[ir iu id])=[-hy/hx,-hx/2/hy,-hx/2/hy];
    gamma= -pi*sin(pi*y(iy));
    f(i)=2*pi*pi*sin(pi*x(ix))*sin(pi*y(iy))*hx*hy+hy*gamma;
%     A(i,i)=1;
%     f(i)=0;
end

%bottom
for ix=1:Nx+1
    iy=1;
    i=(iy-1)*(Ny+1)+ix;
    A(:,i) = 0;
    A(i,i)=1;
    f(i)=0;
end
%top
for ix=1:Nx+1
    iy=Ny+1;
    i=(iy-1)*(Ny+1)+ix;
    A(:,i) = 0;    
    A(i,i)=1;
    f(i)=0;
end
% right
for iy=1:Ny+1
    ix=Nx+1;
    i=(iy-1)*(Ny+1)+ix;
    A(:,i) = 0;    
    A(i,i)=1;
    f(i)=0;
end
if (sub==1)
    err=A;
    U=f;
    return;
end

%solve the linear systems
u=A\f;
% u0=zeros(size(f));
% u=linsolver_gs(A,f,u0,1e-10,1e5);
%estimate the error
U=reshape(u,Nx+1,Ny+1);
ut=sin(pi*X).*sin(pi*Y);
err=norm(reshape(U-ut,NN,1),'inf');

%plot
if (flagdraw==1)
    subplot(1,2,1);
    surf(X,Y,U);
    axis([0,1,0,1,0,1,0,1]);
    title('numerical solution');
    shading interp
    
    subplot(1,2,2);
    surf(X,Y,ut);
    axis([0,1,0,1,0,1,0,1]);
    title('true solution');
    shading interp
end

