clear
close all
clc
tic;



N =[10,15,20,25,30];
NN = size(N,2);
str = cell(NN,1);
error = zeros(NN,1);

figure(1);
hold on;

x1=0:0.0001:1;
plot(x1,sin(pi*x1));
pause

for i=1:NN
[x,y] = example21A(N(i));
error(i) =  norm(y-sin(pi*x),'inf');
str(i+1) = {['N = ',num2str(N(i))]};
plot(x,y);
pause
end
% 
% str(1) = {'true solution '};
% legend(str,'Location','northeast');
% hold off;

figure(2);
plot(log(N'),log(error),'r-+');
disp(polyfit(log(N'),log(error),1));


