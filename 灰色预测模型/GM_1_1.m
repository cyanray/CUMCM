% 灰色预测模型 GM(1,1)
%% 输入数据
X_0 = [223.3  227.3  230.5  238.1  242.9  251.1];   % 原始数据
N = 5;              % 要往后预测的个数
%% 初始化常用值
Len = length(X_0);  % 数据的个数
%% 累加生成
X_1 = zeros(1,Len);   % 初始化变量X_1
for i = 1:Len
    X_1(i) = sum(X_0(1:i));
end
%% 构造矩阵B和数据向量Y
Y = X_0(2:end)';        % 构造数据向量Y
B = ones(Len - 1,2);    % 初始化变量B
for i = 1 : Len - 1
    B(i,1) = -0.5*( X_1(i) + X_1(i+1) );
end
%% 计算系数a和u
au = B\Y;
a = au(1);
u = au(2);
%% 计算GM(1,1)模型的累加结果
yc_1(1) = X_0(1);
for i = 1: Len + N
    c = X_0(1) - u/a;
    yc_1(i+1) = c * exp(-a*i)+u/a;
end
%% 还原预测结果
yc_0(1) = X_0(1);
for i = 1 : Len + N
    yc_0(i+1) = yc_1(i+1)-yc_1(i);
end
%% 绘制图像
plot(X_0,'r*');                         % 原始数据为红星
hold on;
plot(yc_0);                             % 绘制预测数据折线图
hold on;
plot(yc_0,'bo');                        % 预测数据为蓝圈
%% 残差检验
dev = abs( yc_0(1:Len) - X_0 ) ./ X_0;  % 相对误差
max_dev = max(dev);                     % 最大相对误差 