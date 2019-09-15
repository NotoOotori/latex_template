clear
close all
clc


% 椭圆
figure(1);
elli1 = [4   % 指标：4表示椭圆
    0    % 中心x坐标
    0    % 中心y坐标 
    1    % 半轴径1
    2    % 半轴径2
    pi/4    % 旋转角度(弧度制)
    ];
gd = elli1;
ns = char('P1');
ns = ns';
sf = 'P1';
geom = decsg(gd,sf,ns);


[U,p,e,t,tlist] = My2DParabolicSolver(geom);

for i=1:length(tlist)
pdeplot(p,e,t,'xydata',U(:,i),'zdata',U(:,i)); colorbar('off');
axis([-2,2,-2,2,-2,2]);
title(['time = ', num2str(tlist(i))]);
pause(1);
end