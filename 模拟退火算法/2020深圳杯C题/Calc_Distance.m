%% 函数：计算路径总距离
function distance = Calc_Distance( circle, dis )
    adj = Circle_To_Adj(circle);
    distance = sum(sum(adj .* dis)) ./ 2;
end

