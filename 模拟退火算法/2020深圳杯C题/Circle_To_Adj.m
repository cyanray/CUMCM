%% 回路 to 邻接表
function result = Circle_To_Adj( c )
    len = length(c);
    result = zeros(len);
    for m = 1: len - 1
        result( c(m), c(m+1) ) = 1;
        result( c(m+1), c(m) ) = 1;
    end
    result( c(1), c(len) ) = 1;
    result( c(len), c(1) ) = 1;
end

