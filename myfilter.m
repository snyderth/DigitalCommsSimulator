%% NOTE: Run "Simulator.m" in matlab for the full simulator
% @fn myfilter
% @descript Convolves two signals. Outputs the result
% @param x Input signal
% @param h System impulse response
% @retval y The output of the system given input x
%
function y = myfilter(x, h)
    X = zeros(size(h));
    y = zeros(size(x));
    for i = 1:length(x)
        X(2:end) = X(1:end-1);
        X(1) = x(i);
        y(i) = X * h';
    end
end    