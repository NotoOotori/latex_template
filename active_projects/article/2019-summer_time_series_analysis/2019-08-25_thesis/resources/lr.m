K = 2;      %高斯模型个数
dim =2;    %数据维度
N = 1000;    %生成的样本个数
step = 4;   %不同高斯模型均值之间的距离

%变量区
Phi = cell(K,1);         %混合系数构成的cellArray
Mu=cell(K,1);           %均值向量构成的cellArray
Sigma = cell(K,1);      %协方差矩阵构成的cellArray
Dat = zeros(N,dim+1);   %数据矩阵，其中最后一个维度为标签
 
for i =1:K
    Phi(i)={1/K};    %默认每个模型的选择系数相同，可自行调整
end
Mu(1) = {ones(dim,1)};
for i =2:K
    t = rand(dim,1);
    t = t/norm(t,2)*step;
    Mu(i)={Mu{i-1}+t};
end
for i =1:K
    t = rand(dim);
    t = orth(t);
    tt = rand(dim,1);
    Sigma(i) = {t'*diag(tt)*t};
end

%这里直接按系数比例生成样本，与直接按照高斯混合分布生成的样本大致是类似的
cnt = 0;
for i = 1:K
    if i == K
        n = N-cnt;
    else
        n = round(N*Phi{i});
    end
    t = mvnrnd(Mu{i}, Sigma{i}, n);
    Dat(cnt+1:cnt+n,:) = [t ones(n, 1)*i];
    cnt = cnt+n;
end

%存储数据部分
save('Dat.mat', 'Dat');

%画图部分
close all;
view(3);
hold on;
grid on;
mycolor = colorcube(20);
cnt = 0;
for i = 1:K
    if i == K
        n = N-cnt;
    else
       n = round(N*Phi{i});
    end
    t =  Dat(cnt+1:cnt+n,:);
    plot3(t(:,1), t(:,2), t(:,3), '.', 'Color', mycolor(i,:));
    cnt = cnt+n;
end
hold off;

