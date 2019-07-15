function [u]=example25(r,Nx,Nt,u0,ub)
%init
u=zeros(Nx,Nt);

u(:,1) = u0';
%boundary condition
u(1,:)=ub(1,:);
u(Nx,:)=ub(2,:);

%iteration
for n=1:Nt-1
    u(2:Nx-1,n+1)=u(2:Nx-1,n)+r*(u(1:Nx-2,n)-2*u(2:Nx-1,n)+u(3:Nx,n));
end