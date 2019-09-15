%% 计算区域与三角网格剖分
clear
clc

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
[p,e,t] = initmesh(geom,'hmax',0.1);
pdemesh(p,e,t);
view(2);


% 矩形
figure(2);
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
[p,e,t] = initmesh(geom,'hmax',0.1);
pdemesh(p,e,t);
view(2);


% 多边形
figure(3);
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
[p,e,t] = initmesh(geom,'hmax',0.1);
pdemesh(p,e,t);
view(2);


% 椭圆
figure(4);
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
[p,e,t] = initmesh(geom,'hmax',0.1);
pdemesh(p,e,t);
view(2);


% 复杂几何体
figure(5);
circle2 = [1
    1.5
    1.5
    1];
circle1 = [circle1;zeros(size(rect1,1)-size(circle1,1),1)];
circle2 = [circle2;zeros(size(rect1,1)-size(circle2,1),1)];
gd = [rect1,circle1,circle2];
ns = char('R1','C1','C2');
ns = ns';
sf = '(R1+C2)-C1';
geom = decsg(gd,sf,ns);
[p,e,t] = initmesh(geom,'hmax',0.25);
pdemesh(p,e,t);
pause;
[p,e,t] = refinemesh(geom,p,e,t); 
pdemesh(p,e,t);
view(2);

