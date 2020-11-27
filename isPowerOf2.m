%% isPowerOf2
% @descript: Checks if a number is a power of 2
% @param num The number to check
% @retval t True if num is a power of 2, else false.
function t = isPowerOf2(num)
    result = log2(num);
    if(floor(result) == ceil(result))
       t = true;
    else
       t = false; 
    end
end