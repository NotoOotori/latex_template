function [u]=example27(t,h,Nx,Ny,Nt,u0,boundary,ub)
%init
NN=Nx*Ny;
u=zeros(NN,Nt);

% initial condition
u(:,1) = u0;
% boundary condition
u(boundary==1,:)=ub;

%
A=sparse(NN,NN);
for ix=2:Nx-1
    for iy=2:Ny-1
        i=(iy-1)*Ny+ix;
        iu=i+Nx;
        id=i-Nx;
        il=i-1;
        ir=i+1;
        A(i,[il ir i iu id])=[1 1 -4 1 1];
    end
end
A(boundary==1,:)=0;
A(:,boundary==1)=0;

%iteration
for n=1:Nt-1
    r=(t(n+1)-t(n))/h^2;
    u(:,n+1)=u(:,n)+r*A*u(:,n);
end
