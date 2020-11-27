%% overlap_save_fir
% @descript Implements the overlap save method for implementing FIR filters
%           the DFT algorithm
% @param x The input signal to convolve with the signal
% @param h The FIR filter coefficients. The number of coefficients must be
%           a power of 2
% @param y The output signal: convolution of x and h
function y = overlap_save_fir(x, h)
%     x = cos((1:1:1000)*0.5*pi) + cos((1:1:1000)*0.1*pi);
%     h = fir1(511,0.2);
    
    if(~isPowerOf2(length(h)))
       error("Length of FIR filter must be a power of 2"); 
    end
    

    M = length(h); % Length of Filter
    L = length(h)+1; % L > M (Just by one so that N is power of two)
    N = M+L-1; % Length of DFT (Overlap of M-1)
    
    y = [];
    num_iterations = floor(length(x)/L);
    padding = 0;
    if(floor(length(x)/L)*L < length(x))
        padding = ((num_iterations+1) * L) - length(x);
        x = [x(1,:),zeros(1,padding)];
    end
    for i = 1:floor(length(x) / L)
       x_in = zeros(1,N);
       if i == 1
          x_in= [zeros(1, M-1), x(1,1:L)];
       else
          x_in = [x(1, ((i-1)*L)-M+1:(i-1)*L-1), x(1,(i-1)*L:i*L-1)];
       end
       X_in = compute_fft(x_in, N);
       H = compute_fft(h, N);
       Y = X_in .* H;
       y_temp = compute_ifft(Y, N);
       y = [y, y_temp(1, M:N)];
    end
    y = y(1,1:end-padding);
end