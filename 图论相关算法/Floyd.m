function [dist,mypath]=myfloyd(a,sb,db)
%�����ڽӾ���a��Ԫ��a(i,j)��������i��j֮���ֱ����룬�����������
%sb���ı�ţ�db�յ�ı��
%�����dist������̵ľ���
%mypath������̵�·��
%�ŵ���������������֮������·ȱ�������
n=size(a,1);path=zeros(n);
for k=1:n
	for i=1:n
        for j=1:n
            if a(i,j)>a(i,k)+a(k,j)
                a(i,j)=a(i,k)+a(k,j);
                path(i,j)=k;
            end
        end
	end
end
%��path�������path(i,j)��ֵ��ʾ���Ҫ��i��j,j��ǰһ���ڵ㣬Ȼ��path(i,path(i,j)(��ǰһ���ڵ��ֵ))
%���ε����ҵ����·��
dist = a(sb,db);
parent = path(sb,:);%�����sb���յ�db�����·�ϸ������ǰ������
parent(parent==0)=sb;%path�еķ���Ϊ0����ʾ�ö����ǰ�������
mypath =db; t=db;
while t~=sb
	p = parent(t);
	mypath = [p,mypath];%���յ㵽��㵹�ż�¼
	t=p;
end
end