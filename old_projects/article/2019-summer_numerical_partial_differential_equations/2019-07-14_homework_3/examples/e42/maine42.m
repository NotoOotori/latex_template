clear
close all
clc


% 矩形
figure(1);
poly1 = [2   % 指标：2表示多边形
    5    % 边数
    0    % 5个顶点的x坐标
    1
    2
    1
    0
    0    % 5个顶点的y坐标
    0
    0.5
    1
    1 ];
gd = poly1;
ns = char('P1');
ns = ns';
sf = 'P1';
geom = decsg(gd,sf,ns);


[U,p,e,t] = My2DEllipticSolver(geom);
pdeplot(p,e,t,'xydata',U,'zdata',U);colorbar('off');
