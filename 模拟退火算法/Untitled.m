%% ģ���˻�0-1�������⣬�����Ʊ���
clear
clc
%% ���ݳ�ʼ��
k = [5;10;13;4;3;11;13;10;8;16;7;4];    % ������ļ�ֵ
k = -k;	% ģ���˻��㷨�������Сֵ����ȡ����
d = [2;5;18;3;2;5;10;4;11;7;14;6];  % �����������
restriction = 46;   % Լ������ �����Ĵ�С
num = 12;           % ��Ʒ�ĸ���
%% ģ���˻�
% E_current�ǵ�ǰ���Ӧ��Ŀ�꺯��ֵ������������Ʒ�ܼ�ֵ����
% E_new���½��Ŀ�꺯��ֵ��
% E_best�����Ž��
E_current = inf;E_best = inf;  
sol_new = ones(1,num);         % ���ɳ�ʼ��
sol_current = sol_new; sol_best = sol_new;
t0=97;      % ��ʼ�¶�
tf=3;       % Ŀ���¶�
t=t0;       % ��ǰ�¶�
a = 0.95;   % ��������
p=1;
while t>=tf
	for r=1:100 % һ�ν���Ҫ����һ�ٴ�
		%��������Ŷ�
		tmp=ceil(rand.*num);    % ����[0~12]�������
		sol_new(1,tmp)=~sol_new(1,tmp);
		
		%����Ƿ�����Լ��
		while 1
			q=(sol_new*d <= restriction);
			if ~q
                p=~p;	%ʵ�ֽ������תͷβ�ĵ�һ��1
                tmp=find(sol_new==1);
                if p
                    sol_new(1,tmp(1))=0;    % ���0����1���������
                else
                    sol_new(1,tmp(end))=0;
                end
            else
                break
			end
		end
		
		% ���㱳���е���Ʒ��ֵ
		E_new=sol_new*k;
		if E_new<E_current
            E_current=E_new;
            sol_current=sol_new;
            if E_new<E_best
				% ����ȴ��������õĽⱣ������
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

disp('���Ž�Ϊ��')
disp(sol_best)
disp('��Ʒ�ܼ�ֵ���ڣ�')
val=-E_best;
disp(val)
disp('��������Ʒ�����ǣ�')
disp(sol_best * d)