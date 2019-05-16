A = diag(4*ones(1,200)) + diag(-1*ones(1,199),1) + diag(-1*ones(1,199),-1);
b=200*ones(200, 1);
b(1)=100;
b(end)=100;
x=mysqroot(A,b);
disp(x);
