function [dist,mypath]=myfloyd(a,sb,db)
%输入邻接矩阵a；元素a(i,j)——顶点i到j之间的直达距离，可以是有向的
%sb起点的标号；db终点的标号
%输出：dist——最短的距离
%mypath——最短的路径
%优点可以求出任意两点之间的最短路缺点就是慢
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
%得path矩阵对于path(i,j)的值表示如果要从i到j,j的前一个节点，然后看path(i,path(i,j)(即前一个节点的值))
%依次倒推找到最短路径
dist = a(sb,db);
parent = path(sb,:);%从起点sb到终点db的最短路上各顶点的前驱顶点
parent(parent==0)=sb;%path中的分量为0，表示该顶点的前驱是起点
mypath =db; t=db;
while t~=sb
	p = parent(t);
	mypath = [p,mypath];%从终点到起点倒着记录
	t=p;
end
end