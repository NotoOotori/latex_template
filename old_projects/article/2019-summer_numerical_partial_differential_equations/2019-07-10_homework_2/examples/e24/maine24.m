clear;

%convergence rate
clc;
clf;
flagdraw=0;
N=[6 10 20 40 80];
% N=4;
Err=zeros(size(N));

for k=1:length(N)
    Nx=N(k);
    Ny=N(k);
    Err(k)=example24(Nx,Ny,flagdraw,0);
end
plot(log(N),log(Err),'r-+');
p=polyfit(log(N),log(Err),1);
disp(p(1));

%show numerical solution
figure(2);
example24(100,100,1,0);


