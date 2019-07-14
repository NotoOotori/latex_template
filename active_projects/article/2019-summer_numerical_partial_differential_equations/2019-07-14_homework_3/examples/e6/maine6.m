clear
close all
clc


% 矩形
figure(1);
rect1 = [3   % 指标：3表示矩形
    4    % 边数
    0    % 四个顶点的x坐标
    1
    1
    0
    0    % 四个顶点的y坐标
    0
    1
    1 ];
gd = rect1;
ns = char('R1');
ns = ns';
sf = 'R1';
geom = decsg(gd,sf,ns);


[U,p,e,t] = My2DEllipticSolver(geom);
pdeplot(p,e,t,'xydata',U,'zdata',U);colorbar('off');
