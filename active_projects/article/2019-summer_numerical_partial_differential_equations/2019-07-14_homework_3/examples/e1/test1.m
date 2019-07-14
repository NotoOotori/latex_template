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



circle1 = [1   %指标：1表示圆
    0.5    %圆心x
    0.5    %圆心y
    0.2];  %半径

circle1 = [circle1;zeros(size(rect1,1)-size(circle1,1),1)];
gd = [rect1,circle1];
ns = char('R1','C1');
ns = ns';

sf = 'R1+C1';
geom = decsg(gd,sf,ns);
[p,e,t] = initmesh(geom,'hmax',0.1);

xc = (p(1,t(1,:))+p(1,t(2,:))+p(1,t(3,:)))/3;
yc = (p(2,t(1,:))+p(2,t(2,:))+p(2,t(3,:)))/3;
innerelem = find( (xc-0.5).^2+(yc-0.5).^2 <= 0.2^2);
figure(1);
pdemesh(p,e,t);
figure(2);
pdemesh(p,e,t(:,innerelem));