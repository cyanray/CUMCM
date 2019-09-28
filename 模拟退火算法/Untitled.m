%% 模拟退火0-1背包问题，二进制编码
clear
clc
%% 数据初始化
k = [5;10;13;4;3;11;13;10;8;16;7;4];    % 各物体的价值
k = -k;	% 模拟退火算法是求解最小值，故取负数
d = [2;5;18;3;2;5;10;4;11;7;14;6];  % 各物体的重量
restriction = 46;   % 约束条件 背包的大小
num = 12;           % 物品的个数
%% 模拟退火
% E_current是当前解对应的目标函数值（即背包中物品总价值）；
% E_new是新解的目标函数值；
% E_best是最优解的
E_current = inf;E_best = inf;  
sol_new = ones(1,num);         % 生成初始解
sol_current = sol_new; sol_best = sol_new;
t0=97;      % 初始温度
tf=3;       % 目标温度
t=t0;       % 当前温度
a = 0.95;   % 降温速率
p=1;
while t>=tf
	for r=1:100 % 一次降火要迭代一百次
		%产生随机扰动
		tmp=ceil(rand.*num);    % 生成[0~12]的随机数
		sol_new(1,tmp)=~sol_new(1,tmp);
		
		%检查是否满足约束
		while 1
			q=(sol_new*d <= restriction);
			if ~q
                p=~p;	%实现交错地逆转头尾的第一个1
                tmp=find(sol_new==1);
                if p
                    sol_new(1,tmp(1))=0;    % 变成0还是1视情况而定
                else
                    sol_new(1,tmp(end))=0;
                end
            else
                break
			end
		end
		
		% 计算背包中的物品价值
		E_new=sol_new*k;
		if E_new<E_current
            E_current=E_new;
            sol_current=sol_new;
            if E_new<E_best
				% 把冷却过程中最好的解保存下来
                E_best=E_new;
                sol_best=sol_new;
            end
		else
            if rand<exp(-(E_new-E_current)./t)
                E_current=E_new;
                sol_current=sol_new;
            else
                sol_new=sol_current;
            end
		end
	end
	t=t.*a;
end

disp('最优解为：')
disp(sol_best)
disp('物品总价值等于：')
val=-E_best;
disp(val)
disp('背包中物品重量是：')
disp(sol_best * d)