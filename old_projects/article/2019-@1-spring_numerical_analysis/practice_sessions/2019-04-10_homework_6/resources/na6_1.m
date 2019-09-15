x = linspace(-3, 3, 1001);
y1 = (2-x.^2).*(abs(x)<=1) + (x-2).^2.*(x>1&x<=2)...
    + (x+2).^2.*(x>=-2&x<-1);
y2 = sin(x)./(exp(x)+1);
hold on;
p1 = plot(x, y1);
p2 = plot(x, y2);
