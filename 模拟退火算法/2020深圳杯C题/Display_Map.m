function [] = Display_Map( circle, data )
clf;
adj = Circle_To_Adj(circle);
scatter(data(:,1),data(:,2),'filled');
hold on;
scatter(data(1,1),data(1,2),[],[1 0 0],'filled');
grid on;
gplot(adj,data);
ylabel('Î¬¶È')
xlabel('¾­¶È')
text(data(:,1)+0.0005,data(:,2),num2cell([1 1:29]));
end

