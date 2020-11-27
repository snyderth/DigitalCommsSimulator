%% generate fir filter
% @descript Generates a filter with cutoff wc with the windowing method.
% @param wc The cutoff frequency of the filter
% @param n The number of samples in the filter
% @param window The windowing function to multiply the filter with.
% Options: Rectangular, Hamming, Hann, Blackman, Bartlett.
% @retval A vector of length n that contains the fir filter.
function h = generate_fir(wc, n, window, plt, center_freq)
timescale = 0:1:(n-1);
sinscale = wc * (timescale - (n-1)/2);
if ~exist('center_freq', 'var')
   center_freq = 0; 
end

% Truncated ideal impulse response
h_d = sin(sinscale) ./ (pi .* (timescale - (n - 1)/2));
h_d = 2 * h_d .* cos(center_freq * timescale);



% Window ( found in "Discreete-Time Signal Processing" Section 7.2.1)
w = zeros([1,n]);
if window == "Bartlett" || window == "bartlett"
    w(1,1:end/2) = 2 * timescale(:,1:end/2) / n;
    w(1,end/2 + 1:end) = 1 - (2 * timescale(:,1:end/2) / n);
elseif window == "Hanning" || window == "hanning"
    w(1,:) = 0.5 - 0.5 * cos(2 * pi * timescale / n);
elseif window == "Hamming" || window == "hamming"
    w(1,:) = 0.54 - 0.46 * cos(2 * pi * timescale / n);
elseif window == "Blackman" || window == "blackman"
    w(1,:) = 0.42 - 0.5*cos(2*pi*timescale/n) + 0.08*cos(4*pi*timescale/n);
else % Default to Rectangular window
    w(:,:) = 1;
end


h = w .* h_d;

%% Plotting the fir

if plt == true
figure
subplot(1,2,1);
plot(h);
title("Truncated and Windowed Impulse Response");
ylabel("Magnitude");
xlabel("Time");
subplot(1,2,2);
plot(linspace(-pi,pi,n*2),fftshift(abs(fft(h,n*2))));
set(gca, 'YScale', 'log')
ylabel("Magnitude");
xlabel("Normalized Frequency");
xticks(-pi:pi/8:pi);
title("Frequency Response of the FIR filter");
xticklabels({"-\pi",...
            "^{-7\pi}/_{8}",...
            "^{-3\pi}/_{4}",...
            "^{-5\pi}/_{8}",...
            "^{-\pi}/_{2}",...
            "^{-3\pi}/_{8}",...
            "^{-\pi}/_{4}",...
            "^{-\pi}/_{8}",...
            "0",...
            "^{\pi}/_{8}",...
            "^{\pi}/_{4}",...
            "^{3\pi}/_{8}",...
            "^{\pi}/_{2}",...
            "^{5\pi}/_{8}",...
            "^{3\pi}/_{4}",...
            "^{7\pi}/_{8}",...
            "\pi"});

set(gcf,'Position',[0 0 2500 500]);
end

if plt == true
% subplot(1,3,3);
% plot(w);
% pltTitle = sprintf("%s Window",window);
% title(pltTitle);
% xlabel("Time");
% ylabel("Magnitude");


% subplot(1,2,1);
% plot(linspace(-pi,pi,n*2),fftshift(angle(fft(h,n*2))));
% ylabel("Phase Shift (Radians)");
% xlabel("Normalized Frequency");
% title("Phase Response of the FIR filter");
end

end