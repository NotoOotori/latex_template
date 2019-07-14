%% 三角形网格与分片线性插值
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
% [p,e,t] = initmesh(geom,'hmax',0.25);
[p,e,t] = initmesh(geom,'hmax',0.1);
subplot(1,3,1); pdemesh(p,e,t);


x = p(1,:);
y = p(2,:);
uh = sin(pi*x).*sin(pi*y);
subplot(1,3,2); pdeplot(p,e,t,'zdata',uh);


subplot(1,3,3); pdeplot(p,e,t,'xydata',uh','zdata',uh');
colorbar('off');
view(3);