%% ģ���˻�����һ��
clear;clc;
%% ��ȡ����
load('Data1.mat');
load('Distance.mat');
%% ģ���˻�
Len = length(Data1);
T0 = 10000;          % ��ʼ�¶�
Tn = 3;             % Ŀ���¶�
dt = 0.98;          % ��������
T_cur = T0;         % ��ǰ�¶�

Ans_cur = Generate_Random_Ans(length(Data1));
Ans_best = Ans_cur;
Ans_new = Ans_cur;
Dist_cur = Calc_Distance(Ans_cur,Distance);
Dist_best = Dist_cur;
Dist_new = Dist_cur;
Display_Map(Ans_cur,Data1);
while T_cur >= Tn
    for o=1:100 % ÿ���˻����100���Ŷ�        
        % ��������Ŷ�
        a = floor(1 + (Len-1).*rand());
        b = floor((a+2) + (Len - (a+2)).*rand());
        
        Ans_new(a:b) = flip(Ans_new(a:b));
        
        Dist_new = Calc_Distance(Ans_new,Distance);
        
        if Dist_new < Dist_cur
            Ans_cur = Ans_new;
            Dist_cur = Dist_new;
            if Dist_new < Dist_best
                Ans_best = Ans_new;
                Dist_best = Dist_new;
                % ˢ��ͼ��
                Display_Map(Ans_cur,Data1);
                pause(0.01);
            end
        else
            if rand<exp(-(Dist_new-Dist_cur)./T_cur)
                Ans_cur = Ans_new;
                Dist_cur = Dist_new;
            else
                Ans_new = Ans_cur;
            end
        end
        
    end
    T_cur = dt * T_cur;
end
%% ��ʾͼ��
Display_Map(Ans_cur,Data1);