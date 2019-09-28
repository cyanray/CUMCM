// 模拟退火.cpp : 此文件包含 "main" 函数。程序执行将在此处开始并结束。
//
#include <vector>
#include <iostream>
#include <time.h>
#include <math.h>
using namespace std;

// 计算一个答案的值
int Calc_Val(vector<int>& Data, vector<int>& ans)
{
	int val = 0;
	for (size_t i = 0; i < Data.size(); i++)
	{
		if (ans[i] == 1)
		{
			val += Data[i];
		}
	}
	return val;
}

int main()
{
	// 寻找Data数组中不相邻元素的最大和
	vector<int> Data = { 1,2,3,2,1,5,7,6 ,8 };
	vector<int> curr_ans(Data.size());
	vector<int> best_ans(Data.size());
	vector<int> new_ans(Data.size());
	int curr_val = 0;
	int best_val = 0;
	int new_val = 0;
	double
		t0 = 100,		// 初始温度
		tn = 3,			// 目标温度
		dt = 0.95,		// 降温速率
		curr_t = t0;	// 当前温度
	while (curr_t >= tn)
	{
		srand(time(0));
		for (size_t i = 0; i < 100; i++)	// 每次退火进行一百次扰动
		{
			// 制造扰动
			int R = rand() % Data.size();				// 取随机数
			new_ans[R] = (new_ans[R] == 1) ? 0 : 1;	// 反转

			// 检验扰动的结果是否合法，不合法则自动修复
			int lm = -2;
			for (size_t i = 0; i < Data.size(); i++)
			{
				if (i - lm <= 1)
				{
					new_ans[i] = 0;
					continue;
				}
				if (new_ans[i] == 1) lm = i;
			}

			// 计算新答案的值
			new_val = Calc_Val(Data, new_ans);
			if (new_val > best_val)
			{
				best_ans = new_ans;
				best_val = new_val;
				// 调试输出
				cout << "当前的最优值：" << best_val << endl;
			}
			else
			{
				if (1.0 / rand() < exp(-(new_val - curr_val) / curr_t))
				{
					curr_ans = new_ans;
					curr_val = new_val;
				}
				else
				{
					new_ans = curr_ans;
				}
			}

		}
		curr_t *= dt;	//模拟降温
	}
	for (auto m : best_ans)
	{
		cout << m << " ";
	}
}

