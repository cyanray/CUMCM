%% 函数：随机生成初始解
function [circle,adj] = Generate_Random_Ans(len)
    adj = zeros(len);
    unselected = 2:len;
    selection = 1;
    circle = 1;
    while ~isempty(unselected)
        LL = length(unselected);
        new_selection = unselected(randi(LL));        
        adj(selection,new_selection) = 1;
        adj(new_selection,selection) = 1;
        selection = new_selection;
        circle = [circle selection];
        unselected(ismember(unselected,selection)) = [];
    end
    adj(selection,1) = 1;
    adj(1,selection) = 1;
end