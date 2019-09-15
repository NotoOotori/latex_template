clear
close all
clc


% 矩形
figure(1);
% 圆
figure(1);
circle1 = [1   %指标：1表示圆
    0    %圆心x
    0    %圆心y
    1];  %半径

gd = circle1;
ns = char('C1');
ns = ns';
sf = 'C1';
geom = decsg(gd,sf,ns);


[U,p,e,t] = My2DEllipticSolver(geom);
pdeplot(p,e,t,'xydata',U,'zdata',U);
colorbar('off');