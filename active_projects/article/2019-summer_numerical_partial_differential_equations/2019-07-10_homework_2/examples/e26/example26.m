function [u]=example26(r,Nx,Nt,u0,ub)
%init
u=zeros(Nx,Nt);

u(:,1) = u0';
%boundary condition
u(1,:)=ub(1,:);
u(Nx,:)=ub(2,:);

%iteration
C=diag(ones(Nx-3,1),1)+diag(ones(Nx-3,1),-1);
A=diag((1+2*r)*ones(Nx-2,1))-r*C;
H = A\eye(Nx-2);
for n=1:Nt-1
   u(2:Nx-1,n+1)=H*u(2:Nx-1,n);
end