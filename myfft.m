%% myfft
% @descript: An FFT algorithm for power-of-2 sequences. This is a
%           a decimation in frequency algorithm
% @param h The signal to transform
% @param samples The number of samples to take in the transform.
function H = myfft(h, samples)
%% Ensure power of 2
    if(~isPowerOf2(samples))
       error("The number of samples to take must be a power of 2."); 
    end
    
%% Ensure h is a row vector (or matrix of row vectors)
    % I assume that the number of signals to transform is not greater than
    % the number of samples in the signals. I also assume that every
    % signal is of the same length
    

    
    hsize = size(h);
    hlength = 0; % Number of samples (columns)
    hdepth = 0; % Number of signals (rows)
    if(hsize(1) > hsize(2))
        h = h';
        hlength = hsize(1);
        hdepth = hsize(2);
    else
        hlength = hsize(2);
        hdepth = hsize(1);
    end
    if(hlength < samples)
        h = [h, zeros(hdepth, samples-hlength)];
    end
    
    
    %% FFT See Figure 9.20 in Oppenheim text
    if(samples == 2)
        H = zeros(hdepth, samples);
        for i = 1:hdepth
            H(i,1) = h(i,1) + h(i,2);
            H(i,2) = (h(i,1) - h(i,2));
        end
    else
        htemp = h;
        
        for i = 1:hdepth
            for k = 1:samples/2
                h(i,k) = htemp(i,k) + htemp(i, k+samples/2);
                h(i,k+samples/2) = (htemp(i,k) - htemp(i, k+samples/2)) * exp(-1j*(k-1)*2*pi/(samples));
            end
        end
        H_low = myfft(h(:,1:samples/2), samples/2);
        H_high = myfft(h(:,samples/2+1:samples), samples/2);
        H = [H_low, H_high];
    end

end


    